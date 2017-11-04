lysen = []

setup = ->
	createCanvas windowWidth,windowHeight
	bg 0.5
	for i in range 10
		lysen.push new Stoppljus 60 + 60*i, 50, 50, [random(500,1500),random(200,300),random(500,1500),random(200,300)]

draw = -> lyse.update() for lyse in lysen
		
class Stoppljus
	constructor : (@x, @y, @size, @delays) ->
		@delay = 0
		@state = 0

	one_lamp : (villkor, r,g,b, y) ->
		if villkor then fc r,g,b else fc 0
		circle @x, @y+y, @size/2

	update : ->
		if millis() > @delay
			@state += 1
			@state %= 4
			@delay = millis() + @delays[@state]

			@one_lamp @state <= 1, 1,0,0 , 0       # Red
			@one_lamp @state%2==1, 1,1,0 , @size   # Yellow
			@one_lamp @state == 2, 0,1,0 , 2*@size # Green