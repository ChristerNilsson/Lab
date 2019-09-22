_ = require('lodash')

class Game {
	constructor (level) { 
		this.init(level)
	}

	init (level) {
		this.level =- level
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

module.exports = Game