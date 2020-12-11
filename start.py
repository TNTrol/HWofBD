from flask import Flask, request, render_template, redirect, url_for
from flask_login import LoginManager, UserMixin, login_required, login_user, current_user, logout_user
from flask_login import LoginManager
import mysql.connector as MySQL
from mysql.connector import Error
from user import MyUser
from flask import json
import json as my_json

app = Flask(__name__)
login_manager = LoginManager(app)
app.config['SECRET_KEY'] = 'a really really really really long secret key'


def recover_connection(base_name, user, password, buffered = False):
	try:
		db = MySQL.connect(database = base_name, user = user, password = password)
		cursor = db.cursor(prepared=buffered)
		#Log.info('Connection to data base')
		return db, cursor
	except Error as e:
		#Log.error('Error in connection' + str(e))
		print(str(e))
	except Exception as e:
		print("you lose")

def get_data_for_js(array):
	outList = []
	for row in array:
		outList.append((row[0], str(row[1])))
	return outList

def select_from(name):
	cursor.execute('SELECT * FROM ' + name + ';')
	return cursor.fetchall()

@login_manager.user_loader
def load_user(user_id):
	cursor.execute('SELECT * FROM USERS WHERE ID_USER = ? ;', (int(user_id),))
	res = cursor.fetchone()
	print(res[4])
	user = MyUser(res[1], res[3], res[0], res[4])
	return user

@app.route('/login', methods=["GET", "POST"])
def login():
	if current_user.is_authenticated:
		return redirect(url_for('base'))
	if request.method != 'POST':
		return render_template('login.html')
	login = request.form['login']
	password = request.form['password']
	global cursor
	cursor.execute('SELECT * FROM USERS WHERE LOGIN = ? AND PASSWORD = ? ;', (login, password))
	
	user_sql = cursor.fetchone()
	print(user_sql)
	if user_sql is None :
		return render_template('login.html')
	user = MyUser(user_sql[1], user_sql[3], user_sql[0], user_sql[4])
	login_user( user)
	return redirect(url_for('base'))

@app.route('/logout')
def logout_index():
	logout_user()
	return redirect(url_for('base'))

@app.route('/')
def base():
	return render_template('base.html')

@app.route('/service/<int:index>',methods=[ "POST",])
def service(index):
	cursor.execute('SELECT * FROM EARTH_SERVICE;')
	data = cursor.fetchall()
	response = app.response_class(response=json.dumps(data), status=200, mimetype='application/json')
	return response

@app.route('/check', methods=["GET", "POST"])
@login_required
def generate_airline():
	if current_user.role != 2:
		return redirect(url_for('base'))
	data_acts = None
	count_acts = None
	data_earth = None
	data_tex = None
	final_score = None
	if request.method == 'POST':
		with_date = request.form['with']
		to_date = request.form['to']
		cursor.execute('SELECT LIST_SERVICE.ID_ACT, TARIFF.ID_SERVICE, LIST_SERVICE.TYPE_SERVICE, TARIFF.COST FROM LIST_SERVICE JOIN TARIFF JOIN LANDING_ACT ON TARIFF.TYPE_SERVICE = LIST_SERVICE.TYPE_SERVICE AND TARIFF.ID_SERVICE = LIST_SERVICE.ID_SERVICE AND LIST_SERVICE.ID_ACT = LANDING_ACT.ID_ACT AND mydb.TARIFF.ID_AIRCRAFT = LANDING_ACT.TYPE_AIRCRAFT AND LANDING_ACT.ID_AIRLINE = ? AND LANDING_ACT.DATE > ? AND LANDING_ACT.DATE < ? ORDER BY LIST_SERVICE.ID_ACT;', (current_user.private_id, with_date, to_date))
		data_acts = cursor.fetchall()
		cursor.execute('SELECT COUNT(LIST_SERVICE.ID_ACT) , LIST_SERVICE.ID_ACT, LANDING_ACT.DATE FROM LIST_SERVICE JOIN LANDING_ACT WHERE LANDING_ACT.ID_ACT = LIST_SERVICE.ID_ACT AND LANDING_ACT.ID_AIRLINE = ? AND LANDING_ACT.DATE > ? AND LANDING_ACT.DATE < ? GROUP BY LIST_SERVICE.ID_ACT ORDER BY LIST_SERVICE.ID_ACT DESC;', (current_user.private_id, with_date, to_date))
		count_acts = cursor.fetchall()
		cursor.execute('SELECT NAME_SERVICE FROM TECH_SERVICE;')
		data_tex = cursor.fetchall()
		cursor.execute('SELECT NAME_SERVICE FROM EARTH_SERVICE;')
		data_earth = cursor.fetchall()
		cursor.execute('SELECT SCORE FROM SCORE JOIN LANDING_ACT ON SCORE.ID_ACT = LANDING_ACT.ID_ACT AND LANDING_ACT.ID_AIRLINE = ? AND LANDING_ACT.DATE > ? AND LANDING_ACT.DATE < ? ',(current_user.private_id, with_date, to_date))
		final_score = cursor.fetchall();
	return render_template('airline.html', count_acts = count_acts, data_acts = data_acts, data_tex = data_tex, data_earth = data_earth, final_score = final_score)

@app.route('/add', methods=["GET", "POST"])
@login_required
def index():
	if current_user.role != 1:
		return redirect(url_for('base'))
	if request.method == 'POST':
		data = my_json.loads(request.form['data'])
		airl = data['airline']
		airc = data['aircraft']
		print(data)
		dis = current_user.private_id #data['dispatcher']
		arr_types = data['types']
		arr_service = data['services']
		try:
			global id_act
			cursor.execute('INSERT LANDING_ACT (ID_ACT, DATE,ID_DISPATCHER,ID_AIRLINE,TYPE_AIRCRAFT ) VALUES(?, CURRENT_DATE(), ?, ?, ?);', (id_act, int(dis), int(airl), int(airc)))
			for i in range(len(arr_types)):
				cursor.execute('INSERT mydb.LIST_SERVICE (ID_ACT, TYPE_SERVICE, ID_SERVICE) VALUES(?, ?, ?);', (id_act, arr_types[i], int(arr_service[i]) ))
			cursor.execute(' SELECT SUM(COST) FROM mydb.TARIFF INNER JOIN mydb.LIST_SERVICE ON mydb.LIST_SERVICE.ID_ACT = ? AND mydb.TARIFF.ID_AIRCRAFT = ? WHERE mydb.LIST_SERVICE.TYPE_SERVICE = mydb.TARIFF.TYPE_SERVICE AND mydb.LIST_SERVICE.ID_SERVICE = mydb.TARIFF.ID_SERVICE ;''', (id_act, int(airc)))
			cost = cursor.fetchall()
			cursor.execute('INSERT mydb.SCORE (ID_ACT, SCORE) VALUES (?, ?)', (id_act, float(cost[0][0])/2))
			id_act += 1
		except Exception as e:
			db.rollback()
			print()
			print(e)
		else:
			db.commit();
	#if request.method == 'GET':
	airline = select_from('AIRLINE')
	despatcher = select_from('mydb.DISPATCHER')
	aircraft = select_from('AIRCRAFT')
	tex = select_from('TECH_SERVICE')
	#ear = select_from('EARTH_SERVICE')
	return render_template('add.html', airline = airline, despatcher = despatcher,aircraft = aircraft, tex_service = tex )

if __name__ == "__main__":
	try:
		db , cursor = recover_connection('mydb', 'tntrol', 'password', True)
		cursor.execute('SELECT MAX(ID_ACT) FROM LANDING_ACT')
		id_act = cursor.fetchall()
		id_act = int(id_act[0][0]) + 1
		app.run(debug = True)
	except:
		print('you lose')
	

