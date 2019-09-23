express = require 'express'
Game = require '../../100-Guess-Library/game.js'

app = express() 
{renderable,h1,form,input} = require 'teacup'

game = new Game 2

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
