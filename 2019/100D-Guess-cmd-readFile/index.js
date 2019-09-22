'use strict'

const fs = require('fs')
const util = require('util')
const Game = require('../100-Guess-Library/game.js')
const game = new Game(2) 
const PATH = 'data.txt'

const readFile = util.promisify(fs.readFile)
const writeFile = util.promisify(fs.writeFile)

readFile(PATH).then(data => {
	const str = data.toString()
	Object.assign(game, JSON.parse(str))
	if (process.argv.length == 2) game.init(2)
	else game.action(process.argv[2])
	console.log(`${game.low}-${game.high}`)
	writeFile(PATH,JSON.stringify(game))
})
