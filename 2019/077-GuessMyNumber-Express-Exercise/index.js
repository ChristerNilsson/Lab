'use strict'

const express = require('express')
const _ = require('lodash')

const app = express()

let game = {level:2}

const reset = (level) => {
	if (level<2) level = 2
	game = {level:level, low:1, high:2**level-1, history:[]}
	game.secret = _.random(game.low,game.high)
}

const guess = (nr) => {
	game.history.push(nr)
	if (nr < game.secret) game.low  = nr + 1
	if (nr > game.secret) game.high = nr - 1
	if (nr == game.secret) {
		reset(game.level + (game.history.length > game.level ? -1 : 1))
	}
}

const show = (res) => {
	res.write(`<h1>Level: ${game.level}</h1>`)
	res.write(`<h1>Interval: ${game.low}-${game.high}</h1>`)
	res.end('')
}

app.get('/', (req,res) => {
	reset(2)
	show(res)
})

app.get('/nr/:x', (req,res) => {
	const x = parseInt(req.params.x)
	guess(x)
	show(res)
})

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
