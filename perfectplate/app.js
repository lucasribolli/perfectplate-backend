const express = require('express')
var bodyParser = require('body-parser')
const cors = require('cors')
const db = require('./db/index')
const errors = require('./utils/messages_errors')
const responses = require('./utils/responses')

var app = express()
app.use(cors())
app.use(bodyParser.json())
PORT = process.env.PORT || 4000

app.set('port', PORT)
app.listen(PORT, function () {
  console.log('Server is running...')
})

app.get('/users/query_all', function (req, res, next) {
  db.query('SELECT * FROM USERS')
  .then((result) => res.send(responses.success(result.rows)))
  .catch((err) => res.send(responses.fail('fail')))
})

app.get('/user', function (req, res, next) {
  var userId = req.query.user_id
  db.query(
      'SELECT * FROM USERS WHERE id = $1',
      [userId]
  )
      .then((result) => res.send(responses.success(result.rows[0])))
      .catch((err) => res.send(responses.fail('fail')))
})

app.post('/users/signup', function (req, res, next) {
  var email = req.body['email']
  var password = req.body['password']
  var name = req.body['name']
  var age = req.body['age']
  var sex = req.body['sex']
  var weight = req.body['weight']
  var height = req.body['height']
  var userType = req.body['userType']

  db.query(
    "INSERT INTO USERS " +
    "(email, password, name, age, sex, weight, height, userType) " +
    "VALUES($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id",
    [email, password, name, age, sex, weight, height, userType]
  )
  .then((result) => {
    res.send(responses.success(result.rows[0].id))
  })
  .catch((err) => {
    res.send(responses.fail(errors[err.code]))
  })
})

app.post('/users/login', function (req, res, next) {
  email = req.body['email']
  password = req.body['password']

  db.query(
    "SELECT * FROM users WHERE email = $1 AND password = $2",
    [email, password]
  ).then((result) => {
    var successOrFail
    if(result.rowCount == 0) {
      successOrFail = responses.fail("USER_UNFOUND")
    } else {
      successOrFail = responses.success({
        id: result.rows[0].id,
        userType: result.rows[0].usertype
      })
    }
    res.send(successOrFail)
  })
  .catch((err) => {
    res.send(responses.fail(errors[err.code]))
  })
})

app.get('/ingredients/query_all', function (req, res, next) {
  db.query('SELECT * FROM ingredients')
  .then((result) => {
    res.send(responses.success(result.rows))
  })
  .catch((err) => {
    res.send(responses.fail(err))
  })
})

app.get('/ingredients/query', function (req, res, next) {
  var id = req.query.id
  db.query(
    'SELECT * FROM ingredients WHERE id = $1',
    [id]
  )
  .then((result) => {
    res.send(responses.success(result.rows[0]))
  })
  .catch((err) => {
    res.send(responses.fail(err))
  })
})

app.get('/plates/query_all', async function (req, res, _) {
  try {
    var userId = req.query.user_id
    var plateResult = await db.query(
      'SELECT'
      + ' id,'
      + ' date,'
      + ' name'
      + ' FROM plates'
      + ' WHERE user_id = $1',
      [userId]
    )
    var plates = Array();
    for(var i=0; i < plateResult.rowCount; i++) {
      var plate = plateResult.rows[i]
      var ingredientsResult = await db.query(
        'SELECT'
        + ' i.id as ingredient_id,'
        + ' i.name,'
        + ' i.one_portion_weight,'
        + ' i.classification,'
        + ' i.energetic_value,'
        + ' i.carbohydrate,'
        + ' i.protein,'
        + ' i.saturated_fat,'
        + ' i.total_fat,'
        + ' i.trans_fat,'
        + ' i.fibre,'
        + ' i.sodium,'
        + ' p.number_of_portions'
        + ' FROM plate_ingredients AS p, ingredients as i'
        + ' WHERE p.plate_id = $1 AND i.id = p.ingredient_id',
        [plate.id]
      )
      plate.ingredients = ingredientsResult.rows;
      plates.push(plate)
    }
    res.send(responses.success(plates))
  } catch (e) {
    res.send(responses.fail(err))
  }
})

app.post('/plates/plate/insert', function (req, res, next) {
  var userId = req.body['user_id']
  var name = req.body['name']
  var date = req.body['date']

  db.query(
    'INSERT INTO plates(user_id, name, date) values ($1, $2, $3) RETURNING id',
    [userId, name, date]
  )
  .then((result) => {
    res.send(responses.success(result.rows[0].id))
  })
  .catch((err) => {
    res.send(responses.fail(err))
  })
})

app.post('/plates/ingredient/insert', function (req, res, next) {
  var ingredient_id = req.body['ingredient_id']
  var plate_id = req.body['plate_id']
  var number_of_portions = req.body['number_of_portions']

  db.query(
    'INSERT INTO ' +
    'plate_ingredients(ingredient_id, plate_id, number_of_portions) ' +
    'values ($1, $2, $3) RETURNING id',
    [ingredient_id, plate_id, number_of_portions]
  )
  .then((result) => {
    res.send(responses.success(result.rows[0].id))
  })
  .catch((err) => {
    res.send(responses.fail(err))
  })
})

app.get('/plate', async function (req, res, _) {
  try {
    var plateId = req.query.plate_id
    var ingredientsResult = await db.query(
        'SELECT'
        + ' i.id as ingredient_id,'
        + ' i.name,'
        + ' i.one_portion_weight,'
        + ' i.classification,'
        + ' i.energetic_value,'
        + ' i.carbohydrate,'
        + ' i.protein,'
        + ' i.saturated_fat,'
        + ' i.total_fat,'
        + ' i.trans_fat,'
        + ' i.fibre,'
        + ' i.sodium,'
        + ' p.number_of_portions'
        + ' FROM plate_ingredients AS p, ingredients as i'
        + ' WHERE p.plate_id = $1 AND i.id = p.ingredient_id',
        [plateId]
    )
    res.send(responses.success(ingredientsResult.rows))
  } catch (e) {
    res.send(responses.fail(err))
  }
})
