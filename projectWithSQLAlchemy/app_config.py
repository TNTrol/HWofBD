from flask import Flask, request, render_template, redirect, url_for
from sqlalchemy.ext.automap import automap_base
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

app = Flask(__name__)
app.config['DEBUG'] = True
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://tntrol:password@localhost:3306/mydb'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['CSRF_ENABLED'] = True
app.config['SECRET_KEY'] = 'a really really really really long secret key'

login_manager = LoginManager(app)
db: SQLAlchemy = SQLAlchemy(app, session_options={'autoflush': False})
Base = automap_base()
Base.prepare(db.engine, reflect=True)

Users = Base.classes.USERS
Tariff = Base.classes.TARIFF
LandingAct = Base.classes.LANDING_ACT
Score = Base.classes.SCORE
Airline = Base.classes.AIRLINE
TechService = Base.classes.TECH_SERVICE
EarthService = Base.classes.EARTH_SERVICE
Aircraft = Base.classes.AIRCRAFT
ListService = Base.classes.LIST_SERVICE