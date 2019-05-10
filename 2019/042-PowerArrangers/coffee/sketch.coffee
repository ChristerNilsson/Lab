UNREVEALED = -1
REVEALED = -2

board = null
colors = '#f00 #0f0 #00f #ff0 #fff'.split ' '
level = 3
buttons = []
messages = []

class Button
	constructor : (@prompt,@x,@y,@w,@h) ->

	draw : ->
		rectMode CENTER
		fc 0
		rect @x,@y,@w,@h
		fc 1
		text @prompt,@x,@y

	click : ->
		j = board.h-1
		for i in range board.n
			if board.m[j][i] != board.facit[j][i] 
				level = 3
				board = new Board level
				return 
		level += 1
		board = new Board level

	inside : (mx,my) ->	@x < mx+board.size/2 < @x+board.w*board.size and @y < my+board.size/2 < @y+board.h*board.size

class Board
	constructor : (@n) ->
		@w = @n
		@h = 1
		for i in range 1,@n+1
			@h *= i
		@size = height/@h
		@facit = @generate range @n
		@m = ((-1 for i in range @n) for j in range @h)
		@counter = [0,0,1,1+5,1+5+23,1+5+23+119][@n]

	generate : (arr) ->
		result = []
		permute = (arr, m=[]) => 
			if arr.length == 0
				result.push m
			else
				for i in range arr.length
					curr = arr.slice()
					next = curr.splice i, 1
					permute curr.slice(), m.concat(next)
		permute arr
		_.shuffle result

	draw : ->
		rectMode CORNER
		for i in range @w
			for j in range @h
				if @m[j][i] == UNREVEALED
					fc 0.5
					rect i*@size,j*@size,@size,@size
				else if @m[j][i] == REVEALED
						fill colors[@facit[j][i]]
						rect i*@size,j*@size,@size,@size
				else # flagged
					fill colors[@m[j][i]]
					rect i*@size,j*@size,@size,@size
					fc 0.5
					rect i*@size+3,j*@size+3,@size-6,@size-6

		fc 0
		textSize 20
		textAlign LEFT,CENTER
		for message,i in messages
			text message,600,height/2+40*i

		fc 1
		textSize 100
		textAlign CENTER,CENTER
		text @counter,600,100

	click : (i,j,keyPressed) ->
		if keyPressed 
			if @m[j][i] == REVEALED then return 
			if @m[j][i] == UNREVEALED
				@m[j][i] = 0
			else
				if @m[j][i] == @n-1
					@m[j][i] = UNREVEALED
				else
					@m[j][i] = (@m[j][i] + 1) % @n
		else
			if j<@h-1 and i<@w
				if @counter>0 and @m[j][i] != REVEALED
					@m[j][i] = REVEALED
					@counter -= 1

setup = ->
	createCanvas windowWidth,windowHeight
	board = new Board level
	buttons.push new Button 'ok',600,250
	messages = []
	messages.push 'Every row contains a unique permutation of tiles'
	messages.push 'Click to reveal a tile'
	messages.push 'Shift-Click to flag a tile'
	messages.push 'Flag all bottom row tiles'
	messages.push 'Click ok'

draw = ->
	bg 0.5
	board.draw()
	for button in buttons
		button.draw()

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY 
			button.click()
			return 
	i = mouseX//board.size
	j = mouseY//board.size
	board.click i,j,keyIsPressed
