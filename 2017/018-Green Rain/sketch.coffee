streams = []
fade = 0.95
symbolSize = 14

setup = -> 
	createCanvas window.innerWidth, window.innerHeight
	for x in range 0,width,symbolSize
		streams.push new Stream x, random -2000, 0
	textFont 'Consolas'
	textSize symbolSize

draw = ->
	background 0
	stream.render() for stream in streams

class Stream
	constructor : (@x,@y) ->
		@symbols = ""
		for i in range random 5, 35
			@symbols += String.fromCharCode 0x30A0 + round random 96
		@speed = random 5, 22
	render : () ->
		opacity = 255
		y = @y
		for symbol,i in @symbols
			opacity *= fade
			if i==0 then fill 140, 255, 170, opacity else fill 0, 255, 70, opacity
			text symbol, @x, y
			y -= symbolSize
		@y = if @y >= height+35*symbolSize then 0 else @y + @speed