// DEPENDENCIES
const cors = require('cors')
const express = require('express')
const csrf = require('csurf')
const cookieParser = require('cookie-parser')
const userController = require('./controllers/userController')
const authController = require('./controllers/authController')

// CONFIGURATION
const app = express()

const requestsController = require("./controllers/requestsController")

// MIDDLEWARE
app.use(
  cors({
    origin: 'http://localhost:3000', // Allow only this origin to access
    credentials: true, // Allow cookies and headers to be sent along with the request
  })
)
app.use(express.json())
app.use(cookieParser())
const csrfProtection = csrf({ cookie: true })

app.use(csrfProtection)

app.use((req, res, next) => {
  res.cookie('XSRF-TOKEN', req.csrfToken())
  next()
})

app.use('/api/users', userController)
app.use('/api/auth', authController)
app.use('/api/requests', requestsController )

// IMPORT REQUESTS AND REVIEWS
// ROUTES
app.get('/', (req, res) => {
  res.send('Welcome to Basic Express Server')
})

// 404 PAGE
app.get('*', (req, res) => {
  res.status(404).send('Page not found')
})

// EXPORT
module.exports = app
