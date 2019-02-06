N = 100
buttons = []
grid = null
originalGrid = null
current = 0
level = 1
state = 0 # 0=Go 1=Solve 2=Go/Prev/Next

class Button
	constructor : (@title,@x,@y,@w,@h,@textSize,@click) ->
		@active = true
	draw : ->
		textAlign CENTER,CENTER
		textSize @textSize
		if @title == 0 then fill 0 
		else if @title =='Go' and @active then fill 0,255,0 else fill 255
		rect N*@x,N*@y,@w,@h
		if @active
			fill 0
		else
			fill 128
		if @title != 0 then text @title,N*@x+@w/2,N*@y+@h/2
	inside : -> 
		#(width-4*N)/2,(height-5*N)/2
		x = mouseX - (width-4*N)/2
		y = mouseY - (height-5*N)/2
		@active and N*@x < x < N*@x+@w and N*@y < y < N*@y+@h 

randomMoveList = (grid, nMoves, moveList=[]) ->
	if moveList.length == nMoves then return moveList

	validMoves = grid.validMoves()

	if moveList.length > 0
		# Don't just revert the last move
		last = _.last moveList
		[ldr, ldc] = directionToDelta last
		validMoves = _.filter validMoves, (m) ->
			not directionsAreOpposites last, m

	sourceDirection = _.shuffle(validMoves)[0]
	nextGrid = grid.applyMoveFrom sourceDirection
	moveList.push sourceDirection

	randomMoveList nextGrid, nMoves, moveList

transfer = ->
	for i in range 16
		buttons[i].title = grid.grid[i//4][i%%4]

update = (delta) ->
	current = constrain current+delta,0,window.solution.length
	grid = originalGrid.applyMoves window.solution.slice 0,current
	transfer()

goalReached = -> grid.isSolved()

goState = (newState) ->
	state = newState
	values = "1000 0100 1011".split ' '
	for button,i in buttons.slice 16,20
		button.active = values[state][i] == '1'

windowResized = -> resizeCanvas windowWidth, windowHeight

setup = ->
	canvas = createCanvas windowWidth,windowHeight #4*N+1,5.5*N+1
	canvas.position 0,0

	for i in range 16
		x = i%4
		y = i//4
		buttons.push new Button i,x,y,N,N,60,->
			[y0,x0] = grid.emptyPos
			for move in grid.validMoves()
				dx = x0-@x
				dy = y0-@y
				if abs(dx) + abs(dy) == 1
					if move == grid.positionToMove @y,@x
						grid = grid.applyMoveFrom move
						other = buttons[x0+4*y0]
						[other.title,@title] = [@title,other.title]
			if goalReached() 
				goState 0
				level++

	buttons.push new Button 'Go',0,5,N,N/2,30,->
		goState 1
		window.solution = []
		grid = grid.applyMoves randomMoveList grid,level
		transfer()

	buttons.push new Button 'Solve',1,5,N,N/2,30,->
		if level > 1 then level--
		window.solution = []
		originalGrid = grid.copy()
		solve grid
		goState 2

	buttons.push new Button 'Prev',2,5,N,N/2,30,-> update -1
	buttons.push new Button 'Next',3,5,N,N/2,30,-> update +1

	goState 0

	grid = new Grid INIT_GRID, [3,3]
	transfer()

draw = ->
	translate (width-4*N)/2,(height-5*N)/2
	background 128
	for button in buttons
		button.draw()
	if solution.length > 0
		textAlign CENTER,CENTER
		fill 255
		text "#{current} of #{solution.length}", 3*N,4.5*N
	fill 255
	text level,N,4.5*N

mousePressed = ->
	for button,i in buttons
		if button.inside() 
			if (state==1 and i<16) or i>=16
				button.click()
