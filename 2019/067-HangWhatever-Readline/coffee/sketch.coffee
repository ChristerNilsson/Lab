fs = require 'fs'
readline = require 'readline-sync'

WORDS = 'words.txt'

hm = {}

reset = ->
	words = fs.readFileSync(WORDS, 'utf8').split '\r\n'
	hm.secret = words[Math.floor words.length * Math.random()]
	hm.guessed = hm.secret.split('').map => '_'
	hm.history = []

show = -> hm.guessed.join(' ') + ' > '
guess = (letter) ->
	hm.history.push letter
	for ltr,i in hm.secret 
		if ltr == letter then hm.guessed[i] = letter

reset()
while true
	letter = readline.keyIn show()
	if letter == ' ' then reset() else guess letter
	if '_' not in hm.guessed then console.log hm.history.join ''
