DROP TABLE PLATE_INGREDIENTS;
DROP TABLE PLATES;
DROP TABLE INGREDIENTS;
DROP TABLE USERS;
DROP TYPE foodPyramid;

CREATE TABLE USERS(
	id serial PRIMARY KEY,
	email VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	name VARCHAR(100) NOT NULL,
	age VARCHAR(3) NOT NULL,
	sex VARCHAR(50) NOT NULL,
	weight VARCHAR(10) NOT NULL,
	height VARCHAR(10) NOT NULL,
	userType userType NOT NULL
);

INSERT INTO
USERS(
	email,
    password,
    name,
    age,
    sex,
    weight,
    height,
    userType
)
VALUES(
	'admin@admin.com',
	'admin123',
	'admin',
	'19',
	'Masculino',
	'70',
	'180',
	'ADMIN',
);

CREATE TABLE INGREDIENTS_SUGGESTION(
	id serial PRIMARY KEY,
	name VARCHAR(255) UNIQUE NOT NULL,
);

CREATE TYPE userType AS ENUM ('FISICULTURISTA', 'NUTRICIONISTA', 'PADRAO', 'ADMIN')

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
	50,
	'carbohydrate',
	185,
	41,
	3.4,
	0,
	0,
	0,
	1.4,
	0
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
	'Milho verde',
	130,
	'carbohydrate',
	179,
	37,
	8.6,
	0.8,
	0,
	0,
	5.1,
	447
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
	'Batata',
	50,
	'carbohydrate',
	123,
	17,
	0,
	5.8,
	0.6,
	0,
	0.8,
	76
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
	'Quinoa',
	50,
	'carbohydrate',
	184,
	36.7,
	6.7,
	2.7,
	0,
	0,
	3,
	10.6
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
	'Mandioca',
	40,
	'carbohydrate',
	72,
	11,
	3.1,
	1.8,
	0.9,
	0,
	0,
	149
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
	'Filé de frango',
	124,
	'protein',
	157,
	0,
	36,
	1.5,
	0,
	0,
	0,
	86
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
	'Linguiça',
	50,
	'protein',
	160,
	0.8,
	8.8,
	14,
	4.5,
	0,
	0,
	725
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
	'Filé mingnon',
	90,
	'protein',
	133,
	0,
	22,
	5,
	1.7,
	0,
	0,
	67
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
	'Filé de salmão',
	100,
	'protein',
	228,
	0,
	24,
	2,
	0,
	0,
	0,
	85
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
	'Bisteca',
	110,
	'protein',
	197,
	0,
	20,
	13,
	4.5,
	0.3,
	0,
	155
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
	'Alface',
	65,
	'vegetable',
	52,
	7.7,
	0,
	2.5,
	2.2,
	0,
	1,
	5.9
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
	'Acelga',
	100,
	'vegetable',
	21,
	2.7,
	2.1,
	0.2,
	0,
	0,
	2.7,
	1.2
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
	'Couve',
	100,
	'vegetable',
	26,
	4.5,
	2,
	0,
	0,
	0,
	2,
	3.4
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
	'Espinafre',
	100,
	'vegetable',
	151,
	32,
	3.5,
	1.1,
	0,
	0,
	2.7,
	208
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
	'Brócolis',
	50,
	'vegetable',
	13,
	2,
	2.2,
	0,
	0,
	0,
	0.4,
	3.3
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
