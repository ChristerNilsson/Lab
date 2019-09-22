'use strict'

const express = require('express')
const Game = require('./game')
const app = express()

const game = new Game(2)

const show = (res) => {
	res.write(`<h1>Level: ${game.level}</h1>`)
	res.write(`<h1>Interval: ${game.low}-${game.high}</h1>`)
	res.end('')
}

app.get('/', (req,res) => {
	game.init(2)
	show(res)
})

app.get('/:nr', (req,res) => {
	game.action(req.params.nr)
	show(res)
})

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
