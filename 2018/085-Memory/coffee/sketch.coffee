ALFABET = "ABCDEFGHIJKLMOPQRSTUVWXYZ@0123456789"
CARDS = 3 # 3,6,9,12,15,18,21,24,27,30,33,36 
SIZE = 80

class Button
	constructor : (@title,i,j,@event) ->
		@visible = false 
		@x = (i+1) * SIZE
		@y = (j+1) * SIZE
	draw : ->
		rect @x,@y,SIZE,SIZE
		if @visible then text @title,@x,@y
	inside : (mx,my) -> @x-SIZE/2 < mx < @x+SIZE/2 and @y-SIZE/2 < my < @y+SIZE/2
	execute : -> @event()

clicks = 0
found = 0
buttons = []
clicked = []

newGame = ->
	clicks = CARDS//3*10
	found = 0
	buttons = []
	clicked = []
	s = ALFABET.substr 0,CARDS
	arr = _.shuffle (s+s).split ''
	for title,i in arr
		buttons.push new Button title,i%%6,i//6, ->
			if @visible then return else @visible = true
			if clicked.length == 0 then clicked==[]
			else if clicked.length == 1 and clicked[0] != @
				if found == CARDS-1
					CARDS += if clicks >= 0 then 3 else -3
					CARDS = constrain CARDS,3,36
					return newGame()
			else 
				if clicked[0].title == clicked[1].title
					found++
				else 
					click.visible = false for click in clicked
				clicked = []
			clicks--
			clicked.push @

setup = ->
	createCanvas (6+1)*SIZE, SIZE + 12 * SIZE
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize SIZE/2
	newGame()

draw = ->
	bg 0.5
	button.draw() for button in buttons
	text clicks,width/2,SIZE/4

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then return button.execute()