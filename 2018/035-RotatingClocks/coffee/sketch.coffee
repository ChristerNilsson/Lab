clocks = []
rotation = 0
N = 60
total = 0

setup = ->
	createCanvas 600,600
	textAlign CENTER,CENTER 
	angleMode DEGREES
	textSize 50
	clocks.push new Clock 100,100,2,0
	clocks.push new Clock 100,200,3,1
	clocks.push new Clock 100,300,5,3
	clocks.push new Clock 100,400,7,5
	clocks.push new Clock 100,500,11,5

class Clock
	constructor : (@x,@y,@ticks,@value) ->
		@oldValue = 0
		@delta = @value
		@n = N
		@radius = 45
	draw : ->
		push()
		translate @x,@y
		if @n < N then @n++
		sw 1
		circle 0,0,@radius
		rotate (@oldValue + @n/N * @delta) / @ticks * 360 
		@drawTicks()
		text @ticks,0,0
		pop()
	add : (delta) ->
		@delta = delta 
		@oldValue = @value
		@value += delta
		@n = 0
	mousePressed : ->
		if dist(mouseX,mouseY,@x,@y) < @radius 
			for clock in clocks
				clock.add @ticks 
			total += @ticks
	drawTicks : ->
		push()
		rotate @value/@ticks*360 - 90
		for j in range @ticks
			sw 7
			point @radius,0
			sw 5
			if (j+@value) % @ticks == 0 then line 25,0,@radius-10,0
			rotate 360/@ticks
		pop()

draw = ->
	bg 0.5
	text total,300,300
	for clock in clocks
		clock.draw()
		if rotation > 0 then rotation--

mousePressed = ->
	for clock in clocks
		clock.mousePressed()
