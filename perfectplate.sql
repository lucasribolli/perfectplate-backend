DROP TABLE PLATE_INGREDIENTS;
DROP TABLE PLATES;
DROP TABLE INGREDIENTS;
DROP TABLE USERS;

CREATE TABLE USERS(
	user_id serial PRIMARY KEY,
	username VARCHAR(100) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL 
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
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES USERS(user_id)
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
	user_id
)
VALUES(
	1
);

INSERT INTO PLATE_INGREDIENTS (
	ingredient_id,
	plate_id,
	number_of_portions
)
VALUES(
	1,
	1,
	5
);