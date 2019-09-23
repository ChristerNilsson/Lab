'use strict'

const express = require('express')
const app = express()
const Game = require('../100-Guess-Library/game.js')

const game = new Game(2)

app.use(express.urlencoded({ extended: false }))
app.set('view engine', 'pug') 

app.get('/', (req, res) => {
	game.init(0)
  res.render('index', { game }) 
})

app.post('/', (req, res) => {
	game.action(req.body.nr)
  res.render('index', { game }) 
})

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
