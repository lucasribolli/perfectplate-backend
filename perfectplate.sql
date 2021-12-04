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
	'Feijão',
	300,
	'carbohydrate',
	135,
	2.0, 
	0.05,
	0.65,
	0.02,
	0.5,
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
	13,
	1
);

INSERT INTO PLATE_INGREDIENTS (
	ingredient_id,
	plate_id,
	number_of_portions
)
VALUES(
	2,
	13,
	2
);

-- select all ingredients for each plate from a specific user id.
-- This requires two queries. Maybe can be improved
SELECT 
id AS plate_id, 
date AS date,
name AS name
FROM plates
WHERE user_id = 1;

SELECT
i.id as ingredient_id, 
i.name,
i.one_portion_weight,
i.classification,
i.energetic_value,
i.carbohydrate,
i.protein,
i.saturated_fat,
i.total_fat,
i.trans_fat,
i.fibre,
i.sodium,
p.number_of_portions
FROM plate_ingredients AS p, ingredients as i
WHERE p.plate_id = 13 AND i.id = p.ingredient_id