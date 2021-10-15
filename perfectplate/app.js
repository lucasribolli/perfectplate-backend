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
    successResponse.date = Date.now().toString()
    successResponse.user_id = result.rows[0].user_id
    res.status(200).send(successResponse) 
  })
  .catch((err) => {
    var responseError = new Object()
    responseError.message = errors[err.code].message
    responseError.date = Date.now().toString()
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
    response.date = Date.now().toString()
    res.status(statusCode).send(response)
  })
  .catch((err) => {
    var responseError = new Object()
    responseError.message = errors[err.code]
    responseError.date = Date.now().toString()
    res.status(500).send(responseError) 
  })
})