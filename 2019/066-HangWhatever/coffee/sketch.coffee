_ = require 'lodash'
chai = require 'chai'
fs = require 'fs'

range = _.range
assert = chai.assert.deepEqual

WORDS = 'words.txt'
PATH = 'data.json'

class Hangman
	constructor : ->
		words = fs.readFileSync(WORDS, 'utf8').split '\r\n'
		@secret = words[_.random 200]
		@guessed = @secret.split('').map (word) => '_'
		@history = []

	show : -> @guessed.join ' '

	guess : (letter) ->
		@history.push letter
		for ltr,i in @secret 
			if ltr == letter then @guessed[i] = letter

	read : -> Object.assign @, JSON.parse fs.readFileSync PATH,'utf-8'
	write : -> fs.writeFileSync PATH,JSON.stringify @

hangman = new Hangman
hangman.read()

if process.argv.length == 2
	hangman = new Hangman
else
	hangman.guess process.argv[2]

if '_' not in hangman.guessed then console.log hangman.history.join()
console.log hangman.show()
hangman.write()