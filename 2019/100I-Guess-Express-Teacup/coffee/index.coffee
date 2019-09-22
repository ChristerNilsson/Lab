express = require 'express'
Game = require '../js/game'
#_ = require 'lodash'
app = express()
{renderable,h1,form,input} = require 'teacup'

game = new Game 2
#game = {level:2}

# reset = (level) => 
# 	if level < 2 then level = 2
# 	game = {level:level, low:1, high:2**level-1, history:[]}
# 	game.secret = _.random game.low,game.high

# guess = (nr) => 
# 	game.history.push nr
# 	if nr < game.secret then game.low  = nr + 1
# 	if nr > game.secret then game.high = nr - 1
# 	if nr == game.secret then reset game.level + 1

render = renderable ->
	h1 "#{game.low}-#{game.high}"
	form action:"/", method:"post", ->
		input type:"text", name:"nr", autofocus:true
		input type:"submit", value:"Submit"

app.use express.urlencoded { extended: false }

app.get '/', (req, res) => 
	game.init 2
	res.send render()

app.post '/', (req, res) => 
	game.action req.body.nr
	res.send render()

PORT = process.env.PORT || 3000
app.listen PORT, () => console.log "Server started on port #{PORT}"
