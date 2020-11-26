from flask import Flask, request, render_template, redirect, url_for
from flask_login import LoginManager, UserMixin, login_required, login_user, current_user, logout_user
from flask_login import LoginManager
import mysql.connector as MySQL
from mysql.connector import Error
from user import MyUser
from flask import json

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

@login_manager.user_loader
def load_user(user_id):
	#cursor.execute('SELECT * FROM USERS WHERE ID_USER = %(var)s', {'var':user_id,})
	cursor.execute('SELECT * FROM USERS WHERE ID_USER = ? ;', (int(user_id),))
	res = cursor.fetchone()
	user = MyUser(res[1], res[2], res[0])
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
	cursor.execute('SELECT * FROM USERS WHERE USER_NAME = ? AND PASSWORD = ? ;', (login, password))
	user_sql = cursor.fetchone()
	if user_sql is None :
		return render_template('login.html')
	user = MyUser(user_sql[1], user_sql[2], user_sql[0])
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

@app.route('/add', methods=["GET", "POST"])
@login_required
def index():
	
	if request.method == 'GET':
		cursor.execute('SELECT ID_AIRLINE,NAME_AIRLINE FROM AIRLINE;')
		airline = cursor.fetchall()
		cursor.execute('SELECT * FROM mydb.DISPATCHER;')
		despatcher = cursor.fetchall()
		cursor.execute('SELECT * FROM AIRCRAFT;')
		aircraft = cursor.fetchall()
		cursor.execute('SELECT * FROM TECH_SERVICE;')
		tex = cursor.fetchall()
		cursor.execute('SELECT * FROM EARTH_SERVICE;')
		ear = cursor.fetchall()
		return render_template('add.html', airline = airline, despatcher = despatcher,aircraft = aircraft, tex_service = tex )

if __name__ == "__main__":
	db , cursor = recover_connection('mydb', 'tntrol', 'dfkjd', True)
	app.run(debug = True)
	airline = cursor.execute('SELECT NAME_AIRLINE	,ID_AIRLINE FROM AIRLINE;')
	if airline is not None:
		print("urrr")
	

