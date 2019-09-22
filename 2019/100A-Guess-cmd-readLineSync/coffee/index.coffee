{ question } = require 'readline-sync'
Game = require '../js/game.js'

game = new Game 2

while true 
	game.action question "#{game.low}-#{game.high} > "
