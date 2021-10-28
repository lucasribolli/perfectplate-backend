DROP TABLE PLATE_INGREDIENTS;
DROP TABLE PLATES;
DROP TABLE INGREDIENTS;
DROP TABLE USERS;
DROP TYPE foodPyramid;

CREATE TABLE USERS(
	id serial PRIMARY KEY,
	email VARCHAR(255) UNIQUE NOT NULL ,
	password VARCHAR(255) NOT NULL,
	name VARCHAR(100) NOT NULL,
	age VARCHAR(3) NOT NULL,
	sex VARCHAR(50) NOT NULL,
	weight VARCHAR(10) NOT NULL,
	height VARCHAR(10) NOT NULL, 
	userType VARCHAR(100) NOT NULL
);

CREATE TYPE foodPyramid AS ENUM ('carbohydrate', 'vegetable', 'protein');

CREATE TABLE INGREDIENTS (
	id SERIAL PRIMARY KEY,
	name VARCHAR(700) NOT NULL,
	one_portion_weight DECIMAL NOT NULL,
	classification foodPyramid NOT NULL,
	energetic_value DECIMAL NOT NULL,
	carbohydrate DECIMAL NOT NULL,
	protein DECIMAL NOT NULL,
	saturated_fat DECIMAL NOT NULL,
	total_fat DECIMAL NOT NULL,
	trans_fat DECIMAL NOT NULL,
	fibre DECIMAL NOT NULL,
	sodium DECIMAL NOT NULL
);

CREATE TABLE PLATES (
	id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	name VARCHAR(500) NOT NULL,
	date DATE NOT NULL,
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES USERS(id)
);

CREATE TABLE PLATE_INGREDIENTS (
	id SERIAL PRIMARY KEY,
	ingredient_id INTEGER NOT NULL,
	plate_id INTEGER NOT NULL,
	number_of_portions INTEGER NOT NULL,
	CONSTRAINT fk_ingredient FOREIGN KEY(ingredient_id) REFERENCES INGREDIENTS(id),
	CONSTRAINT fk_plate FOREIGN KEY(plate_id) REFERENCES PLATES(id)
);


INSERT INTO 
INGREDIENTS(
	name,
	one_portion_weight,
	classification,
	energetic_value,
	carbohydrate,
	protein,
	saturated_fat,
	total_fat,
	trans_fat,
	fibre,
	sodium
) 
VALUES(
	'Arroz',
	200,
	'carbohydrate',
	130,
	2.5, 
	0.01,
	0.63,
	0.05,
	0,
	0.4,
	0.025
);

INSERT INTO PLATES (
	user_id,
	name,
	date
)
VALUES(
	1,
	'Marmita',
	'2021-12-12 00:00:00'
);

INSERT INTO PLATES (
	user_id,
	name,
	date
)
VALUES(
	1,
	'Almoço na sogra',
	'2021-12-24'
);

INSERT INTO PLATE_INGREDIENTS (
	ingredient_id,
	plate_id,
	number_of_portions
)
VALUES(
	1,
	3,
	50
);

INSERT INTO PLATE_INGREDIENTS (
	ingredient_id,
	plate_id,
	number_of_portions
)
VALUES(
	1,
	4,
	100
);

-- select all plates from a specific user id
SELECT 
p.id AS plate_id, 
p.date AS date,
p.name AS name,
pi.id AS plate_ingredients_id, 
pi.ingredient_id AS ingredient_id, 
pi.number_of_portions AS number_of_portions
FROM plates AS p
INNER JOIN plate_ingredients AS pi
ON p.id = pi.plate_id
AND p.user_id = 1;

-- select all plates from a specific user id and a specific date
SELECT 
p.id AS plate_id, 
p.user_id AS user_id, 
pi.id AS plate_ingredients_id, 
pi.ingredient_id AS ingredient_id, 
pi.number_of_portions AS number_of_portions
FROM plates AS p
INNER JOIN plate_ingredients AS pi
ON p.id = pi.plate_id
AND p.user_id = 1
AND p.date = '2021-12-24';

DELETE FROM PLATE_INGREDIENTS WHERE ID > 0;
DELETE FROM PLATES WHERE ID > 0;