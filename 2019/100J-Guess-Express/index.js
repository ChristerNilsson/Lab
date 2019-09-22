const express = require('express')
const app = express()
const Game = require('./game')

const game = new Game(2)

app.use(express.urlencoded({ extended: false }))

send = (res) => {
	res.write(`<h1>${game.low}-${game.high}</h1>`)
	res.write('<form action="/" method="post">')
  res.write('  <input type="text" name="nr" autofocus>')
  res.write('  <input type="submit" value="Submit">')
  res.write('</form>')
	res.end()
}

app.get('/', (req, res) => {
	game.init(2)
  send(res)
})

app.post('/', (req, res) => {
	game.action(req.body.nr)
	send(res)
})

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
