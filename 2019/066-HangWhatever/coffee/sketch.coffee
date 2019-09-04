_ = require 'lodash'
chai = require 'chai'
fs = require 'fs'
assert = chai.assert.deepEqual

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
		@show()

	read : -> Object.assign @, JSON.parse fs.readFileSync PATH,'utf8'
	write : -> fs.writeFileSync PATH,JSON.stringify @

#########################################
hangman = new Hangman
hangman.secret  = 'riviera'
hangman.guessed = '_______'.split ''
assert '_ _ _ _ _ _ _', hangman.show()
assert '_ _ _ _ _ _ a', hangman.guess 'a'
assert '_ i _ i _ _ a', hangman.guess 'i'
hangman.write()

hangman = new Hangman
hangman.read()
assert '{"secret":"riviera","guessed":["_","i","_","i","_","_","a"],"history":["a","i"]}', JSON.stringify hangman
assert 'riviera', hangman.secret
assert ["_","i","_","i","_","_","a"], hangman.guessed
assert ['a','i'], hangman.history

assert 'r i _ i _ r a', hangman.guess 'r'
assert 'r i v i _ r a', hangman.guess 'v'
assert 'r i v i e r a', hangman.guess 'e'
console.log 'Ready!'
#########################################

hm = new Hangman
hm.read()

args = process.argv

if args.length == 2 then hm = new Hangman else hm.guess args[2]

if '_' not in hm.guessed then console.log hm.history.join()
console.log hm.show()
hm.write()