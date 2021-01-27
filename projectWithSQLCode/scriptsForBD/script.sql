INSERT mydb.TECH_SERVICE (NAME_SERVICE ) VALUES("Проверка проводки"),("Проверка навигации"), ("Тех осмотр двигателей"),("Тех осмотр шасси"),("Тех осмотр закрылок"), ("Замена закрылок"), ("Ремонт шасси"), ("Ремонт генератора"), ("Полный ремонт двигателя");
INSERT mydb.EARTH_SERVICE (NAME_SERVICE ) VALUES("Заправка"),("Замена покрышек"), ("Очистка салона"), ("Пополнение запасов еды"), ("Осмотр фезуляжа"), ("Замена масла"), ("Пополнение запасов воды"), ("Проверка работы аварийных систем"), ("Сан. услуги");
INSERT mydb.DISPATCHER (SECOND_NAME, NAME ) VALUES("Иванов", "Сергей"),( "Беспалов", "Владимир"), ("Белашков", "Денис"), ("Петров", "Юрий"), ("Жмышенко", "Инокентий"), ("Нартов", "Евгений"), ("Зыков", "Георгий");
--INSERT mydb.USERS (USERS_NAME, ROLE, ID_DISPATCHER, PASSWORD ) VALUES("Иванов Сергей", 1, 1, "password" ),( "Беспалов Владимир", 1, 2, "password"), ("Белашков Денис", 1, 3, "password"), ("Петров Юрий", 1, 4, "password"), ("Жмышенко Инокентий", 1, 5, "password"), ("Нартов Евгений", 1, 6, "password"), ("Зыков Георгий", 1, 7, "password");
INSERT mydb.AIRCRAFT (NAME_AIRCRAFT) VALUES("Bing-777"),("Boing-767"), ("An-17"),("Airbus A220"), ("Tu-204");
INSERT mydb.AIRLINE (NAME_AIRLINE) VALUES("AirFlot" ), ("British Airlines"), ("US Airlines"), ("Air France-KLM"), ("Emirates");
INSERT mydb.RATE (`DATE`,EURO ) VALUES(CURRENT_DATE() - interval 2 day, 74.00),(CURRENT_DATE() - interval 1 day, 74.05), (CURRENT_DATE(),75.91);
INSERT mydb.LANDING_ACT (DATE,ID_DISPATCHER,ID_AIRLINE,TYPE_AIRCRAFT ) VALUES(CURRENT_DATE(), 2, 3, 1),(CURRENT_DATE(), 1, 2, 1), (CURRENT_DATE() , 2, 1, 3), (CURRENT_DATE(), 3, 2, 4),(CURRENT_DATE() , 4, 2, 1);
Start transaction;
INSERT mydb.LIST_SERVICE (ID_ACT, TYPE_SERVICE, ID_SERVICE) VALUES(1, true, 2), (1, true, 3), (1, false, 3), (2, false, 3),(3, true, 3), (3, false, 1), (3, true, 5), (3, false, 5), (3, true, 7), (5, true, 1), (5, true, 3), (5 , false, 6), (4, true, 5), (4, false, 7);
INSERT mydb.TARIFF (ID_AIRCRAFT, TYPE_SERVICE, ID_SERVICE, COST) VALUES(1, true, 1 ,35.40168988242121),(1, true, 2 ,25.440148385037517),(1, true, 3 ,46.45512041054408),(1, true, 4 ,29.693382759257343),(1, true, 5 ,47.72829250139958),(1, true, 6 ,42.578448725257275),(1, true, 7 ,58.21728522200958),(1, true, 8 ,44.43861089833845),(1, true, 9 ,32.843039869456035),(1, false, 1,37.800261122667465),(1, false, 2,28.87259137701112),(1, false, 3,40.58687983809759),(1, false, 4,21.27889784501481),(1, false, 5,40.24726693119069),(1, false, 6,57.184127126515996),(1, false, 7,56.982412625389856),(1, false, 8,20.125930093740713),(1, false, 9,20.486027985359563),(2, true, 1 ,57.080121910666584),(2, true, 2 ,33.50959674572111),(2, true, 3 ,41.29829877621532),(2, true, 4 ,41.728984388961564),(2, true, 5 ,25.573554405372732),(2, true, 6 ,42.26305714849994),(2, true, 7 ,58.13248631877693),(2, true, 8 ,47.13176351321241),(2, true, 9 ,49.56893528657561),(2, false, 1,59.668933970929785),(2, false, 2,35.965293514772185),(2, false, 3,46.91384694497573),(2, false, 4,36.756197837667756),(2, false, 5,26.734360427374693),(2, false, 6,59.01950097156544),(2, false, 7,49.04727273466326),(2, false, 8,45.020885683851674),(2, false, 9,56.06791781079601),(3, true, 1 ,39.70470958274134),(3, true, 2 ,28.982307737082976),(3, true, 3 ,21.040866343464874),(3, true, 4 ,30.655544544827052),(3, true, 5 ,24.530160122551564),(3, true, 6 ,31.302964263001023),(3, true, 7 ,46.450168250718576),(3, true, 8 ,50.95359923699567),(3, true, 9 ,25.461103905314175),(3, false, 1,29.930804340159707),(3, false, 2,25.827943281408086),(3, false, 3,23.268078365267858),(3, false, 4,53.98243259726909),(3, false, 5,33.47656508051551),(3, false, 6,45.11039052883976),(3, false, 7,58.06996762821055),(3, false, 8,55.878619851650136),(3, false, 9,52.01288050267746),(4, true, 1 ,21.438443352399087),(4, true, 2 ,49.89421642947248),(4, true, 3 ,21.207278871463004),(4, true, 4 ,52.558405088230614),(4, true, 5 ,56.337899202822975),(4, true, 6 ,48.84608715981498),(4, true, 7 ,35.01709112283728),(4, true, 8 ,45.56703893244448),(4, true, 9 ,39.60097360543615),(4, false, 1,56.84035078929528),(4, false, 2,51.60536791754096),(4, false, 3,59.33208403592927),(4, false, 4,41.56248087710837),(4, false, 5,31.484862720545728),(4, false, 6,31.10653611107648),(4, false, 7,49.26090712717297),(4, false, 8,43.98878370787578),(4, false, 9,48.52461406167615),(5, true, 1 ,34.788911953053145),(5, true, 2 ,43.83316131556463),(5, true, 3 ,22.064078856494348),(5, true, 4 ,29.04975719353304),(5, true, 5 ,53.982187301314404),(5, true, 6 ,53.660419199727954),(5, true, 7 ,45.23755503522529),(5, true, 8 ,55.60144038772763),(5, true, 9 ,46.65125692847752),(5, false, 1,44.49503148657508),(5, false, 2,37.21454673148058),(5, false, 3,33.93452034642242),(5, false, 4,50.25722404933),(5, false, 5,37.306693290663894),(5, false, 6,35.75352373011835),(5, false, 7,52.13137314537712),(5, false, 8,53.66307729601014),(5, false, 9,24.87769234206602);
INSERT mydb.SCORE (ID_SCORE, ID_ACT, SCORE) VALUES (1, 1, 50),(2,2,40),(3,3,60);
 commit;
 --
 --INSERT mydb.USERS (USER_NAME, ROLE, ID_PRIVATE, PASSWORD, LOGIN ) VALUES( "airline2", 2, 4, "password", "airline2" );
 --
 SELECT * FROM mydb.LIST_SERVICE WHERE ID_ACT = 1;
 SELECT SUM(COST) FROM mydb.TARIFF WHERE ID_AIRCRAFT = 1 AND TYPE_SERVICE;
 --SELECT COST,mydb.TARIFF.ID_AIRCRAFT FROM mydb.TARIFF INNER JOIN mydb.AIRCRAFT ON mydb.TARIFF.ID_AIRCRAFT = mydb.AIRCRAFT.ID_AIRCRAFT;
 SELECT * FROM mydb.`LANDING ACT` INNER JOIN mydb.RATE ON mydb.RATE.DATE = mydb.`LANDING ACT`.DATE AND mydb.RATE.EURO > 74.05;
 SELECT COST FROM mydb.TARIFF INNER JOIN mydb.LIST_SERVICE ON mydb.LIST_SERVICE.ID_ACT = 110 AND mydb.TARIFF.ID_AIRCRAFT = 1 WHERE mydb.LIST_SERVICE.TYPE_SERVICE = mydb.TARIFF.TYPE_SERVICE AND mydb.LIST_SERVICE.ID_SERVICE = mydb.TARIFF.ID_SERVICE ;
 
 INSERT mydb.USERS (ID_USER, USER_NAME, ROLE, ID_DISPATCHER, PASSWORD ) VALUES(23,"tntrol", 1, 1, "password" );
 
SELECT SUM(COST) ,mydb.TARIFF.ID_SERVICE 
	FROM mydb.TARIFF 
	JOIN mydb.LIST_SERVICE 
	JOIN mydb.LANDING_ACT ON mydb.LIST_SERVICE.ID_ACT = mydb.LANDING_ACT.ID_ACT WHERE mydb.LANDING_ACT.DATE < '2020-10-15' AND mydb.LANDING_ACT.DATE > '2020-10-13' AND mydb.LIST_SERVICE.TYPE_SERVICE = TRUE GROUP BY mydb.TARIFF.ID_SERVICE ;

SELECT SUM(COST) 
	FROM mydb.TARIFF 
	JOIN mydb.LIST_SERVICE 
	JOIN mydb.LANDING_ACT WHERE  mydb.LIST_SERVICE.ID_ACT = mydb.LANDING_ACT.ID_ACT AND mydb.LIST_SERVICE.ID_ACT = 1 AND mydb.LIST_SERVICE.TYPE_SERVICE = TRUE AND mydb.TARIFF.TYPE_SERVICE = mydb.LIST_SERVICE.TYPE_SERVICE;
	
SELECT LIST_SERVICE.ID_ACT, TARIFF.ID_SERVICE, LIST_SERVICE.TYPE_SERVICE, TARIFF.COST 
	FROM LIST_SERVICE
	JOIN TARIFF
	ON TARIFF.TYPE_SERVICE = LIST_SERVICE.TYPE_SERVICE AND TARIFF.ID_SERVICE = LIST_SERVICE.ID_SERVICE AND LIST_SERVICE.ID_ACT = 1
	AND mydb.TARIFF.ID_AIRCRAFT = 1 GROUP BY TARIFF.ID_TARIFF;
	
SELECT LIST_SERVICE.ID_ACT, TARIFF.ID_SERVICE, LIST_SERVICE.TYPE_SERVICE, TARIFF.COST
	FROM LIST_SERVICE
	JOIN TARIFF
	JOIN LANDING_ACT
	ON TARIFF.TYPE_SERVICE = LIST_SERVICE.TYPE_SERVICE AND TARIFF.ID_SERVICE = LIST_SERVICE.ID_SERVICE AND LIST_SERVICE.ID_ACT = LANDING_ACT.ID_ACT
    WHERE mydb.TARIFF.ID_AIRCRAFT = LANDING_ACT.TYPE_AIRCRAFT AND LANDING_ACT.ID_AIRLINE = 2  ORDER BY LIST_SERVICE.ID_ACT;

----------
SELECT COUNT(LIST_SERVICE.ID_ACT) , LIST_SERVICE.ID_ACT, LANDING_ACT.DATE
	FROM LIST_SERVICE
	JOIN LANDING_ACT WHERE LANDING_ACT.ID_ACT = LIST_SERVICE.ID_ACT AND LANDING_ACT.ID_AIRLINE = 2
	GROUP BY LIST_SERVICE.ID_ACT ORDER BY LIST_SERVICE.ID_ACT DESC;
	
SELECT NAME_SERVICE FROM mydb.LIST_SERVICE.EARTH_SERVICE;
SELECT NAME_SERVICE FROM mydb.LIST_SERVICE.TECH_SERVICE;

SELECT COUNT(LIST_SERVICE.ID_ACT) , LIST_SERVICE.ID_ACT, LANDING_ACT.DATE
	FROM LIST_SERVICE
	JOIN LANDING_ACT WHERE LANDING_ACT.ID_ACT = LIST_SERVICE.ID_ACT AND LANDING_ACT.ID_AIRLINE = 4
	AND LANDING_ACT.DATE > '2020-12-10' AND LANDING_ACT.DATE < '2020-12-12'
	GROUP BY LIST_SERVICE.ID_ACT ORDER BY LIST_SERVICE.ID_ACT DESC;

SELECT LIST_SERVICE.ID_ACT, TARIFF.ID_SERVICE, LIST_SERVICE.TYPE_SERVICE, TARIFF.COST FROM LIST_SERVICE JOIN TARIFF JOIN LANDING_ACT ON TARIFF.TYPE_SERVICE = LIST_SERVICE.TYPE_SERVICE AND TARIFF.ID_SERVICE = LIST_SERVICE.ID_SERVICE AND LIST_SERVICE.ID_ACT = LANDING_ACT.ID_ACT AND mydb.TARIFF.ID_AIRCRAFT = LANDING_ACT.TYPE_AIRCRAFT AND LANDING_ACT.ID_AIRLINE = 1 AND LANDING_ACT.DATE > '2020-12-10' AND LANDING_ACT.DATE < '2020-12-12' ORDER BY LIST_SERVICE.ID_ACT;

SELECT SCORE FROM SCORE
    JOIN LANDING_ACT ON SCORE.ID_ACT = LANDING_ACT.ID_ACT AND LANDING_ACT.ID_AIRLINE = 4
	AND LANDING_ACT.DATE > '2020-12-10' AND LANDING_ACT.DATE < '2020-12-12' ORDER BY LANDING_ACT.ID_ACT DESC;