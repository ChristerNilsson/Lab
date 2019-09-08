'use strict'

//     Secret = 82 
//     low   nr    high    Next Interval
//     1     64    127  => 65-127
//     65    96    127  => 65-95
//     65    80     95

const {question} = require('readline-sync')

let guess = {}

const reset = (level) => {
	if (level < 2) level = 2
	guess.level = level
	guess.low = 1
	guess.high = 2**guess.level - 1
	guess.history = []
	guess.secret = Math.ceil(guess.high * Math.random()) 
}

reset(2) 

while (true) {
	const nr = JSON.parse(question(`${guess.low}-${guess.high} > `))
	guess.history.push(nr)

	if (nr < guess.secret) guess.low = nr + 1
	if (nr > guess.secret) guess.high = nr - 1 
	if (nr == guess.secret) {
		console.log('Correct!')
		reset(guess.level + (guess.history.length > guess.level ? -1 : 1))
	}
}
