const express = require('express')
const _ = require('lodash')
const app = express()

let game = {level:2}

reset = (level) => {
	if (level<2) level = 2
	game = {level:level, low:1, high:2**level-1, history:[]}
	game.secret = _.random(game.low,game.high)
}

guess = (nr) => {
	game.history.push(nr)
	if (nr < game.secret) game.low  = nr + 1
	if (nr > game.secret) game.high = nr - 1
	if (nr == game.secret) reset(game.level + 1)
}

app.use(express.urlencoded({ extended: false }))
app.set('view engine', 'pug') // PUG

app.get('/', (req, res) => {
	reset(2)
  res.render('index', { game }) // PUG
})

app.post('/', (req, res) => {
	const nr = parseInt(req.body.nr)
	guess(nr)
  res.render('index', { game }) // PUG
})

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
