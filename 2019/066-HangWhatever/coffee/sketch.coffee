_ = require 'lodash'
fs = require 'fs'

WORDS = 'words.txt'
PATH = 'data.json'

class Hangman
	constructor : ->
		words = fs.readFileSync(WORDS, 'utf8').split '\r\n'
		@secret = words[_.random words.length]
		@guessed = @secret.split('').map => '_'
		@history = []

	show : -> @guessed.join ' '

	guess : (letter) ->
		@history.push letter
		for ltr,i in @secret 
			if ltr == letter then @guessed[i] = letter

	read : -> Object.assign @, JSON.parse fs.readFileSync PATH,'utf8'
	write : -> fs.writeFileSync PATH,JSON.stringify @

hm = new Hangman
hm.read()

args = process.argv

if args.length == 2 then hm = new Hangman else hm.guess args[2]

if '_' not in hm.guessed then console.log hm.history.join()
console.log hm.show()
hm.write()