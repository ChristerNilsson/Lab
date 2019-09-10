const express = require('express')
const {random} = require('lodash')
const app = express()

let game = {level:2}

reset = (level) => {
	if (level<2) level = 2
	game = {level:level, low:1, high:2**level-1, history:[]}
	game.secret = random(game.low,game.high)
}

guess = (nr) => {
	game.history.push(nr)
	if (nr < game.secret) game.low  = nr + 1
	if (nr > game.secret) game.high = nr - 1
	if (nr == game.secret) reset(game.level + 1)
}

app.use(express.urlencoded({ extended: false }))

send = (res) => {
	res.write(`<h1>yyy ${game.low}-${game.high}</h1>`)
	res.write('<form action="/" method="post">')
  res.write('  <input type="text" name="nr" autofocus>')
  res.write('  <input type="submit" value="Submit">')
  res.write('</form>')
	res.end()
}

app.get('/', (req, res) => {
	reset(2)
  send(res)
})

app.post('/', (req, res) => {
	const nr = parseInt(req.body.nr) // with express.urlencoded
	guess(nr)
	send(res)
})

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
