'use strict'

const http = require('http')
const Game = require('../../100-Guess-Library/gamejs.js')

function createServer() {
	const game = new Game(2)
  return http.createServer((req, res) => {
		const arr = req.url.split('/')
		const cmd = arr[1]
		if (cmd == 'favicon.ico') return
		if (cmd == '') game.init(2)
		if (cmd != '') game.action(cmd)
		res.end(`${game.low}-${game.high}` + '\n')
	})
}

module.exports = createServer
