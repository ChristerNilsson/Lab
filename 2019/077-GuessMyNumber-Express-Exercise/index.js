const _ = require('lodash')

let game = {level:2}

reset = (level) => {
	if (level<2) level = 2
	game = {level:level, low:1, high:2**level-1, history:[]}
	game.secret = _.random(game.low,game.high)
}

guess = (nr) => {
	game.history.push(nr)
	if (nr < game.secret) game.low  = nr + 1
	if (nr > game.secret) game.high = nr - 1
	if (nr == game.secret) reset(game.level + 1)
}

const PORT = process.env.PORT || 3000
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
