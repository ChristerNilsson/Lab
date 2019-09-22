{ question } = require 'readline-sync'
Game = require '../js/game.js'

guess = { level:2 }

reset = (diff) ->
	if diff != 0 then console.log 'Correct!'
	guess = { level:guess.level+diff, low:1, history:[] }
	if guess.level < 2 then guess.level = 2
	guess.high = 2**guess.level - 1
	guess.secret = Math.ceil guess.high * Math.random()

reset 0
while true 
	guess.history.push nr = parseInt question "#{guess.low}-#{guess.high} > "
	if nr > guess.secret then guess.high = nr - 1
	if nr < guess.secret then guess.low = nr + 1
	if nr == guess.secret 
		reset if guess.history.length <= guess.level then 1 else -1
