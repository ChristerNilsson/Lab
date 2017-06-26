# 3x3, två sidor, 96 positioner. Max sex drag.
# Klick på en av fyra mittbitar vänder på tre tiles
# Klick på mitten ger undo

rs = null
buttons = []
START = [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1]

class Button
	constructor : (@x,@y,@action = -> ) ->
	draw : (r,g,b) ->
		fc r,g,b
		rect @x,@y,100,100
	inside : (mx,my) -> @x < mx < @x+100 and @y < my < @y+100

class RS18
	constructor : ->
		@level = 0
		@generate()
		@square = START
		@startNewGame 1

	startNewGame : (dlevel) ->
		@state = 0
		if @level < 6 then @level += dlevel
		@history = []
		@square = _.sample @positions[@level]

	draw : ->
		textAlign CENTER,CENTER
		textSize 50
		for i in range 9
			if @square[i]==0 then buttons[i].draw(1,0,0) else buttons[i].draw(1,1,0)
		fc 0
		text @level - @history.length,250,250

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
		if index == 0 then return @gen square,[[0,11],[1,10],[2,9]]
		if index == 1 then return @gen square,[[0,15],[3,12],[6,9]]
		if index == 2 then return @gen square,[[2,17],[5,14],[8,11]]
		if index == 3 then return @gen square,[[6,17],[7,16],[8,15]]

	generate : () ->
		@positions = [[],[],[],[],[],[],[]]
		hash = {}
		queue = []
		sq = START
		@positions[0].push sq
		queue.push sq
		hash[sq.join ''] = 0
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
	createCanvas 500,500
	buttons = []
	for j in range 3
		for i in range 3
			buttons.push new Button 100*(j+1),100*(i+1)
	buttons[1].action = -> rs.move 0
	buttons[3].action = -> rs.move 1
	buttons[5].action = -> rs.move 2
	buttons[7].action = -> rs.move 3
	buttons[4].action = -> rs.undo()
	rs = new RS18

draw = -> rs.draw()
mousePressed = -> rs.mousePressed mouseX,mouseY