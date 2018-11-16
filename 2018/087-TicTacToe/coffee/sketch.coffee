class Button
	constructor : (@x,@y,@title,@execute) -> @w=95
	draw : ->
		rect @x,@y,@w,@w
		text @title,@x,@y
	inside : (mx,my) -> @x-@w/2 < mx < @x+@w/2 and @y-@w/2 < my < @y+@w/2

N = 3
[FREE,X,O] = [' ','X','O']
WINNERS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
buttons = []
message = ''

setup = ->
	createCanvas 400,400
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 100
	for i in range N
		for j in range N
			[x,y] = [100+100*i,100+100*j]
			buttons.push new Button x,y,FREE,->
				if message != '' then return newGame()
				if @title != FREE then return
				@title = O
				if three sel O then return message = 'human wins!'
				if (sel FREE).length == 0 then return message = 'remi!'
				ai()
				if three sel X then message = 'computer wins!'

newGame = ->
	for button in buttons
		button.title = FREE
	message = ''

sel = (m) -> i for b,i in buttons when b.title==m

investigate = (marker) ->
	markers = sel marker 
	for i in sel FREE
		if three markers.concat i
			buttons[i].title = X
			return true
	false

ai = -> # computer is X
	if investigate X then return # try WINNERSning
	if investigate O then return # avoid losing
	index = _.sample sel FREE # random move
	buttons[index].title = X

three = (b) -> 
	for winner in WINNERS
		if _.intersection(winner,b).length == N then return true
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