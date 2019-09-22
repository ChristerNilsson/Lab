{ question } = require 'readline-sync'
Game = require '../../100-Guess-Library/game.js'

game = new Game 2

while true 
	game.action question "#{game.low}-#{game.high} > "
