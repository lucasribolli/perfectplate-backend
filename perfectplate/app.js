// /**
//  * running at http://localhost:4000
//  */

const express = require('express')
var bodyParser = require('body-parser')
const cors = require('cors')
const db = require('./db/index')
const errors = require('./utils/messages_errors')

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
  .then((result) => res.send(result.rows))
  .catch((err) => res.status(500).send(err))
})

/*
{
  'username': ''
  'email': '' 
  'password': ''
}
*/
app.post('/users/signup', function (req, res, next) {
  username = req.body['username']
  email = req.body['email']
  password = req.body['password']

  db.query(
    "INSERT INTO USERS (username, password, email) VALUES($1, $2, $3) RETURNING user_id", 
    [username, password, email]
  ).then((result) => {
    var successResponse = new Object()
    successResponse.message = "USER_INSERTED"
    successResponse.user_id = result.rows[0].user_id
    successResponse.ok = true
    res.status(200).send(successResponse) 
  })
  .catch((err) => {
    var responseError = new Object()
    responseError.message = errors[err.code].message
    responseError.ok = false
    res.status(errors[err.code].statusCode).send(responseError) 
  })
})

/*
{
  'email': '' 
  'password': ''
}
*/
app.post('/users/login', function (req, res, next) {
  email = req.body['email']
  password = req.body['password']

  db.query(
    "SELECT * FROM users WHERE email = $1 AND password = $2",
    [email, password]
  ).then((result) => {
    var response = Object()
    var statusCode
    if(result.rowCount == 0) {
      statusCode = 401
      response.message = "USER_UNFOUND"
    } else {
      statusCode = 200
      response.user_id = result.rows[0].user_id
      response.message = "AUTHORIZED"
    }
    response.ok = true
    res.status(statusCode).send(response)
  })
  .catch((err) => {
    var responseError = new Object()
    responseError.ok = false
    responseError.message = errors[err.code]
    res.status(500).send(responseError) 
  })
})

app.get('/ingredients', function (req, res, next) {
  var id = req.query.id
  console.log('id = ' + id)
  db.query(
    'SELECT * FROM ingredients WHERE id = $1',
    [id]
  )
  .then((result) => {
    var response = Object()
    response.date = Date.now().toString()
    response.ok = true
    response.ingredient = result.rows[0]
    res.send(response)
  })
  .catch((err) => {
    response.ok = false
    response.error = err
    res.send(response)
  })
})

app.get('/plates', function (req, res, next) {
  var userId = req.query.user_id
  console.log('userId = ' + userId)
  db.query(
    'SELECT'
    + ' p.id AS plate_id,'
    + ' p.user_id AS user_id,'
    + ' p.date AS date,'
    + ' pi.id AS plate_ingredients_id,'
    + ' pi.ingredient_id AS ingredient_id,'
    + ' pi.number_of_portions AS number_of_portions'
    + ' FROM plates AS p'
    + ' INNER JOIN plate_ingredients AS pi'
    + ' ON p.id = pi.plate_id'
    + ' AND p.user_id = $1',
    [userId]
  )
  .then((result) => {
    var response = Object()
    response.ok = true
    response.plates = result.rows
    res.send(response)
  })
  .catch((err) => {
    response.ok = false
    response.error = err
    res.send(response)
  })
})