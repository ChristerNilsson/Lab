class Button
	constructor : (@x,@y,@title,@execute) -> @w=95
	draw : ->
		rect @x,@y,@w,@w
		text @title,@x,@y
	inside : (mx,my) -> @x-@w/2 < mx < @x+@w/2 and @y-@w/2 < my < @y+@w/2

N = 5 
[FREE,X,O] = [' ','X','O']
WINNERS = [] 
buttons = []
message = ''

makeWINNERS = ->
	#arr = 'abcd bcde fghi ghij klmn lmno pqrs qrst uvwx vwxy afkp fkpu bglq glqv chmr hmrw dins insx ejot joty agms gmsy bhnt flrx eimqu dhlp jnrv'.split ' '
	arr = 'abcde fghij klmno pqrst uvwxy afkpu bglqv chmrw dinsx ejoty agmsy eimqu'.split ' '
	for quad in arr
		WINNERS.push ('abcdefghijklmnopqrstuvwxy'.indexOf ch for ch in quad)

setup = ->
	createCanvas 600,600
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 100
	makeWINNERS()
	for i in range N
		for j in range N
			[x,y] = [100+100*i,100+100*j]
			buttons.push new Button x,y,FREE,->
				if message != '' then return newGame()
				@title = O
				if four sel O then return message = 'human wins!'
				ai()
				if four sel X then message = 'computer wins!'
				if (sel FREE).length==0 then return message = 'remi!'

newGame = ->
	for button in buttons
		button.title = FREE
	message = ''

sel = (m) -> i for b,i in buttons when b.title==m

investigate = (marker) ->
	markers = sel marker 
	for i in sel FREE
		if four markers.concat i
			buttons[i].title = X
			return true
	false

ai = -> # computer is X
	if investigate X then return # try winning
	if investigate O then return # avoid losing
	index = _.sample sel FREE # random move
	buttons[index].title = X

four = (b) -> 
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