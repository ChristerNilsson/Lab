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
		// -+*/ % ! && || > < >= <= == = ^ ** 
		// elvis operator ?:  unary binary 
		// -3
		// 1+2
		// ternary 1,2,3
		reset(game.level + (game.history.length > game.level ? -1 : 1))
	}
}

// app.use(express.urlencoded({extended:false}))  // false: numbers and strings true:arrays and objects

// const render = (res) => {
// 	res.write(`<h1>Level: ${game.level}</h1>`)
// 	res.write(`<h1>Interval: ${game.low}-${game.high}</h1>`)
// 	res.write('<form action="/" method="post">')
// 	res.write('  <input type="text" name="nr" autofocus="autofocus"/>')
// 	res.write('  <input type="submit" value="Submit"/>')
// 	res.write('</form>')
// 	res.end('')
// }

const show = (res) => {
	res.write(`<h1>Nivå: ${game.level}</h1>`)
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

// app.post('/', (req,res) => {
// 	// res.write(JSON.stringify(req.body))  // {"nr":"2"}
// 	const nr = parseInt(req.body.nr)
// 	guess(nr)
// 	render(res)
// })

const PORT = process.env.PORT || 3016
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))


// 1-3

// /nr/2
// /nr/4