class Button
	constructor : (@title,@x,@y) -> 
		@state = HIDDEN
		@w=50
		@h=50
	inside : (x,y) ->
		@x-@w/2< x < @x+@w/2 and @y-@h/2< y < @y+@h/2
	draw : ->
		if @state!=DONE then rect @x,@y,@w,@h
		if @state==VISIBLE then text @title,@x,@y

HIDDEN = 0
VISIBLE = 1
DONE = 2

buttons = []
alfabet = 'AABBCC'

setup = ->
	createCanvas 600,600
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 42
	for i in range 6
		letter = alfabet[i]
		buttons.push new Button letter,100+50*i,100

draw = ->
	bg 0.5
	for button in buttons
		button.draw()

mousePressed = ->
	for button in buttons
		if button.inside(mouseX,mouseY) 
			button.state=VISIBLE