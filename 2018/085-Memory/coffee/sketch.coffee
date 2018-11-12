ALFABET = "ABCDEFGHIJKLMOPQRSTUVWXYZ@0123456789"
CARDS = 3 # 3,6,9,12,15,18,21,24,27,30,33,36 
SIZE = 80

class Button
	constructor : (@title,i,j,@event) ->
		@visible = 0 
		@x = (i+1) * SIZE
		@y = (j+1) * SIZE
	draw : ->
		if @visible<=1 then rect @x,@y,SIZE-1,SIZE-1
		if @visible==1 then text @title,@x,@y
	inside : (mx,my) -> @x-SIZE/2 < mx < @x+SIZE/2 and @y-SIZE/2 < my < @y+SIZE/2
	execute : -> @event()

clicks = 0
found = 0
buttons = [] 
clicked = []

newGame = (cards=0) ->
	CARDS += cards 
	CARDS = constrain CARDS,3,36
	clicks = CARDS//3*10
	found = 0
	buttons = []
	clicked = []
	s = ALFABET.substr 0,CARDS
	arr = _.shuffle (s+s).split ''
	for title,i in arr
		buttons.push new Button title,i%%6,i//6, ->
			if @visible in [1,2] then return 
			@visible = 1
			clicks--
			if clicked.length == 0 
				clicked.push @
				return 
			if clicked.length == 1
				if clicked[0] == @ then return
				if clicked[0].title == @title
					clicked[0].visible = 2 
					@visible = 2
					found++
					clicked = []
					if found == CARDS
						return newGame if clicks >= 0 then 3 else -3
				else
					@visible = 1
					clicked.push @
				return
			if clicked.length == 2
				click.visible = 0 for click in clicked
				@visible = 1
				clicked = [@]

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