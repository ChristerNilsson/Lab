buttons = []
grid = null
originalGrid = null
current = 0

class Button
	constructor : (@title,@x,@y,@w,@h,@click) ->
		@active = true
	draw : ->
		textAlign CENTER,CENTER
		textSize 30
		if @title == 0 then fill 128 else fill 255
		rect @x,@y,@w,@h
		if @active then fill 0 else fill 128
		if @title != 0 then text @title,@x+@w/2,@y+@h/2
	inside : -> @active and @x < mouseX < @x+@w and @y < mouseY < @y+@h 

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

prevNext = (value) ->
	buttons[18].active = value
	buttons[19].active = value 

setup = ->
	createCanvas 200+1,350+1

	for i in range 16
		x = i%4
		y = i//4
		buttons.push new Button i,50*x,50*y,50,50,->

	buttons.push new Button 'Shuffle',0,250,100,50,->
		window.solution = []
		grid = grid.applyMoves randomMoveList grid,25
		transfer()
		prevNext false 
		#print grid.lowerSolutionBound()

	buttons.push new Button 'Solve',100,250,100,50,->
		prevNext false
		window.solution = []
		originalGrid = grid.copy()
		solve grid

	buttons.push new Button 'Prev',0,300,100,50,-> update -1
	buttons.push new Button 'Next',100,300,100,50,-> update +1

	prevNext false

	grid = new Grid INIT_GRID, [3,3]
	transfer()

draw = ->
	background 128
	for button in buttons
		button.draw()
	if solution.length > 0
		textAlign CENTER,CENTER
		fill 255
		text "#{current} of #{solution.length}", 100,225

mousePressed = ->
	for button in buttons
		if button.inside() then button.click()
