streams = []
fadeInterval = 1.6
symbolSize = 14

setup = -> 
	createCanvas window.innerWidth, window.innerHeight
	x = 0
	for i in range width / symbolSize
		streams.push new Stream x, random -2000, 0
		x += symbolSize
	textFont 'Consolas'
	textSize symbolSize

draw = ->
	bg 0
	for stream in streams
		stream.render()

class Stream
	constructor : (@x,@y) ->
		@symbols = ""
		for i in range random 5, 35
			@symbols += String.fromCharCode 0x30A0 + round random 96
		@speed = random 5, 22
	render : () ->
		opacity = 1
		y = @y
		for symbol,i in @symbols
			opacity -= 1 / @symbols.length / fadeInterval
			if i==0 then fc 0.55, 1, 0.67, opacity
			else fc 0, 1, 0.27, opacity
			text symbol, @x, y
			y -= symbolSize
			@y = if @y >= height+35*symbolSize then 0 else @y + @speed/10