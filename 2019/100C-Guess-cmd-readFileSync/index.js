'use strict'

const fs = require('fs')
const Game = require('./game')
const game = new Game(2) 
const PATH = 'data.txt'

function read() {                             
	Object.assign(game, JSON.parse(fs.readFileSync(PATH,'utf-8')))
}
	
function write() {
	fs.writeFileSync(PATH,JSON.stringify(game))
}

read()

if (process.argv.length == 2) game.init(2)
else game.action(process.argv[2])
console.log(`${game.low}-${game.high}`)

write()
