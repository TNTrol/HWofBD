from user import MyUser
import json as my_json
from datetime import date
from sqlalchemy.sql import func
from sqlalchemy import and_
from flask_login import login_required, login_user, current_user, logout_user
from app_config import *


@login_manager.user_loader
def load_user(user_id):
    user = db.session.query(Users).filter(Users.ID_USER == user_id).one_or_none()
    return MyUser(user.LOGIN, user.ROLE, user.ID_USER)


@app.route('/')
def base():
    return render_template('base.html')


@app.route('/logout')
def logout_index():
    logout_user()
    return redirect(url_for('base'))


@app.route('/login', methods=["GET", "POST"])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('base'))
    if request.method != 'POST':
        return render_template('login.html')
    login = request.form['login']
    password = request.form['password']
    user = db.session.query(Users).filter(Users.LOGIN == login, Users.PASSWORD == password).one_or_none()
    if user is None:
        return render_template('login.html')
    user = MyUser(user.LOGIN, user.ROLE, user.ID_USER)
    login_user(user)
    return redirect(url_for('base'))


@app.route('/check', methods=["GET", "POST"])
@login_required
def generate_airline():
    if current_user.role == 1:
        return redirect(url_for('base'))
    data_acts = None
    count_acts = None
    final_score = None
    dict_service = {}
    if request.method == 'POST':
        with_date = request.form['with']
        to_date = request.form['to']
        data_acts = db.session.query(ListService.ID_SERVICE, Tariff.COST).join(LandingAct).join(Tariff, and_(ListService.ID_SERVICE == Tariff.ID_SERVICE, LandingAct.ID_AIRCRAFT == Tariff.ID_AIRCRAFT)).filter(LandingAct.ID_AIRLINE == current_user.get_id()).filter(LandingAct.DATE > with_date).filter(LandingAct.DATE < to_date).order_by(ListService.ID_ACT).all()
        count_acts = db.session.query(func.count(ListService.ID_ACT).label('COUNT'), LandingAct.DATE, LandingAct.ID_ACT).join(LandingAct).filter(LandingAct.ID_AIRLINE == current_user.get_id()).filter(LandingAct.DATE > with_date).filter(LandingAct.DATE < to_date).group_by(ListService.ID_ACT).order_by(ListService.ID_ACT.desc()).all()
        data_tex1 = db.session.query(TechService).all()
        data_earth1 = db.session.query(EarthService).all()
        for t in data_tex1:
            dict_service[t.ID_SERVICE] = t.NAME_SERVICE
        for t in data_earth1:
            dict_service[t.ID_SERVICE] = t.NAME_SERVICE
        final_score = db.session.query(Score).join(LandingAct).filter(LandingAct.ID_AIRLINE == current_user.get_id()).filter(LandingAct.DATE > with_date).filter(LandingAct.DATE < to_date).filter(Score.SCORE > 0).all()
    return render_template('airline.html', count_acts = count_acts, data_acts = data_acts, data_service = dict_service, final_score = final_score)


@app.route('/add', methods=["GET", "POST"])
@login_required
def index():
    if current_user.role != 1:
        return redirect(url_for('base'))
    if request.method == 'POST':
        data = my_json.loads(request.form['data'])
        airline = data['airline']
        aircraft = data['aircraft']
        services = list(data['services'])
        try:
            act = LandingAct(ID_AIRLINE=airline, ID_DISPATCHER=current_user.get_id(), ID_AIRCRAFT=aircraft,
                             DATE=date.today())
            db.session.add(act)
            db.session.commit()
            for i in range(len(services)):
                list_service = ListService(ID_ACT=act.ID_ACT, ID_SERVICE=services[i])
                db.session.add(list_service)
            db.session.commit()
            cost = db.session.query(func.sum(Tariff.COST).label('total')).join(ListService,
                                                                                     ListService.ID_SERVICE == Tariff.ID_SERVICE).filter(
                Tariff.ID_AIRCRAFT == aircraft, ListService.ID_ACT == act.ID_ACT).first()
            if cost.total is None:
                db.session.add(Score(SCORE=0, ID_ACT=act.ID_ACT))
            else:
                db.session.add(Score(SCORE=cost.total, ID_ACT=act.ID_ACT))
        except Exception as e:
            print()
            print(e)
            db.session.rollback()
            return " ", 202
        else:
            db.session.commit()
            return " ", 200
    airlines = db.session.query(Airline).all()
    aircrafts = db.session.query(Aircraft).all()
    tex = db.session.query(TechService).all()
    earth = db.session.query(EarthService).all()
    return render_template('add.html', airline=airlines, aircraft=aircrafts, tex_service=tex, earth_service=earth)


if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)
