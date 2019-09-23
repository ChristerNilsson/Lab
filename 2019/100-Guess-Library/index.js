chai = require('chai')
assert = chai.assert.deepEqual

const names = ["Hole-in-one!", "Eagle", "Birdie", "Par", "Bogey", "Double Bogey", "Go Home!"];

const golfScore = (par, strokes) => {
	if (strokes == 1) return names[0]
	let diff = strokes - par
	if (diff < -2) diff = -2
	if (diff > 3) diff = 3
	return names[diff+3]
}

assert(golfScore(5, 1), "Hole-in-one!")
assert(golfScore(5, 2), "Eagle")
assert(golfScore(5, 3), "Eagle")
assert(golfScore(5, 4), "Birdie")
assert(golfScore(5, 5), "Par")
assert(golfScore(5, 6), "Bogey")
assert(golfScore(5, 7), "Double Bogey")
assert(golfScore(5, 8), "Go Home!")
assert(golfScore(5, 9), "Go Home!")
