class Button
	constructor : (@x,@y,@title,@execute) -> @w=95
	draw : ->
		rect @x,@y,@w,@w
		text @title,@x,@y
	inside : (mx,my) -> @x-@w/2 < mx < @x+@w/2 and @y-@w/2 < my < @y+@w/2

[SP,X,O] = [' ','X','O']
WIN = [] 
buttons = []
message = ''

makeWIN = ->
	arr = 'abcd efgh ijkl mnop aeim bfjn cgko dhlp afkp dgjm'.split ' '
	for quad in arr
		WIN.push ('abcdefghijklmnop'.indexOf ch for ch in quad)
	print WIN

setup = ->
	createCanvas 500,500
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 100
	makeWIN()
	for i in range 4
		for j in range 4
			[x,y] = [100+100*i,100+100*j]
			buttons.push new Button x,y,SP,->
				if message != '' then return newGame()
				@title = O
				if four sel O then return message = 'human wins!'
				ai()
				if four sel X then message = 'computer wins!'
				if (sel SP).length==0 then return message = 'remi!'

newGame = ->
	for button in buttons
		button.title = SP
	message = ''

sel = (m) -> i for b,i in buttons when b.title==m

investigate = (marker) ->
	markers = sel marker 
	for i in sel SP
		if four markers.concat i
			buttons[i].title = X
			return true
	false

ai = -> # computer is X
	if investigate X then return # try winning
	if investigate O then return # avoid losing
	index = _.sample sel SP # random move
	buttons[index].title = X

four = (b) -> 
	for pattern in WIN
		if _.intersection(pattern,b).length == 4 then return true
	false

draw = ->
	bg 0.5
	button.draw() for button in buttons
	push()
	textSize 50
	fc 1,0,0
	text message,width/2,height/2
	pop()

mousePressed = ->
	for button in buttons 
		if button.inside mouseX,mouseY then button.execute()