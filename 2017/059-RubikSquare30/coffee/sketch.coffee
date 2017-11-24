# 3x3x1, två sidor, 192 positioner. Max 8 drag.
# 3x3x2 + 4x3 = 30 tiles
# http://news.mit.edu/2011/rubiks-cube-0629

rs = null
buttons = []
sida = null
released = true 
START = [0,0,0, 0,0,0, 0,0,0, 1,1,1, 1,1,1, 1,1,1, 2,2,2, 3,3,3, 4,4,4, 5,5,5]

class Button
	constructor : (@x,@y,@action = -> ) ->
	draw : (col) ->
		[r,g,b] = [[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[0,1,1]][col]
		fc r,g,b
		rect @x,@y,sida,sida
	inside : (mx,my) -> @x-sida/2 < mx < @x+sida/2 and @y-sida/2 < my < @y+sida/2

class RS30
	constructor : () ->
		@level = 0
		@generate()
		@square = START
		@startNewGame 1

	draw : ->
		textAlign CENTER,CENTER
		textSize 50
		for index,k in [6,7,8, 11,12,13, 16,17,18, 0,0,0, 0,0,0, 0,0,0, 1,2,3, 9,14,19, 23,22,21, 15,10,5]
			if index!=0 then buttons[index].draw @square[k]
		fc 0
		text @level - @history.length,width/2,height/2

	startNewGame : (dlevel) ->
		@state = 0
		if @level < 8 then @level += dlevel
		@history = []
		@square = _.sample @positions[@level]

	mousePressed : (mx,my) ->
		if @state > 0 then @startNewGame @state-1
		else
			for button in buttons
				if button.inside mx,my then	button.action()

	undo : -> if @history.length > 0 then @square = @history.pop()

	move : (index) ->
		@history.push @square
		@square = @moveOne index, @square
		if _.isEqual @square,START then @state = if @level==@history.length then 2 else 1

	moveOne : (index,square) ->
		if index == 0 then return @gen square,[[0,11],[1,10],[2,9],[21,29],[18,20]]
		if index == 1 then return @gen square,[[0,15],[3,12],[6,9],[18,26],[27,29]]
		if index == 2 then return @gen square,[[2,17],[5,14],[8,11],[20,24,],[21,23]]
		if index == 3 then return @gen square,[[6,17],[7,16],[8,15],[23,27],[24,26]]

	generate : () ->
		@positions = [[],[],[],[],[],[],[],[],[]]
		hash = {}
		queue = []
		sq = START
		@positions[0].push sq
		queue.push sq
		hash[sq.join ''] = 0 #['',0]
		while queue.length > 0
			square = queue.shift()
			generation = hash[square.join '']
			res = []
			for i in range 4
				res.push @moveOne i, square
			for sq in res
				key = sq.join ''
				if key not in _.keys hash
					hash[key] = generation + 1
					@positions[generation + 1].push sq
					queue.push sq

	gen : (square,moves) ->
		res = square.slice()
		for [i,j] in moves
			[res[i],res[j]] = [res[j],res[i]]
		res

setup = ->
	createCanvas windowWidth,windowHeight
	rectMode CENTER
	buttons = []
	sida = min(width,height)/6
	for j in range 5
		for i in range 5
			buttons.push new Button width/2 + sida*(j-2), height/2 + sida*(i-2)
	buttons[ 7].action = -> rs.move 0
	buttons[11].action = -> rs.move 1
	buttons[13].action = -> rs.move 2
	buttons[17].action = -> rs.move 3
	buttons[12].action = -> rs.undo()
	rs = new RS30

draw = -> rs.draw()

mouseReleased = ->
	released = true
	false

mousePressed = ->
	if not released then return
	released = false 
	rs.mousePressed mouseX,mouseY