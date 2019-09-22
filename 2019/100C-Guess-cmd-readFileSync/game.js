_ = require('lodash')

class Game {
	constructor (level) { 
		this.init(level)
	}

	init (level) {
		this.level = level
		if (this.level < 2) {
			this.level = 2
		}
		this.low = 1
		this.high = 2**this.level - 1
		this.secret = _.random(this.low, this.high)
		this.hist = []
	}
	
	action (value) {
		value = parseInt(value)
		this.hist.push(value)
		if (value < this.secret && value >= this.low) {
			this.low = value + 1
		}
		if (value > this.secret && value <= this.high) {
			this.high = value - 1
		}
		if (value == this.secret) { 
			this.init(this.level + (this.hist.length <= this.level ? 1 : -1))
		}
	}
}

const game = new Game(2)
// guess.secret = 82
// assert(guess.secret, 82)
// assert(guess.limits(), '1-127')
// assert(guess.history, [])
// assert(guess.guess(64),'65-127')
// assert(guess.history, [64])
// assert(guess.guess(96), '65-95')
// assert(guess.guess(80), '81-95')
// assert(guess.guess(88), '81-87')
// assert(guess.guess(84), '81-83')
// assert(guess.guess(82), 'Correct!')
// assert(guess.history, [64,96,80,88,84,82])
// assert(`${guess}`, 'Your guesses are [64,96,80,88,84,82]')
// guess.reset()
// assert(guess.history, [])
// console.log('Ready!')


module.exports = Game