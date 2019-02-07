N = 150
KEY = '015'
buttons = []
grid = null
originalGrid = null
current = 0
level = null
state = 0 # 0=Go 1=Solve 2=Go/Prev/Next
released = true 

class Button
	constructor : (@title,@x,@y,@w,@h,@textSize,@click) ->
		@active = true
	draw : ->
		textAlign CENTER,CENTER
		textSize @textSize
		if @title == 0 then fill 0
		else if @title =='Go' and @active then fill 0,255,0 else fill 255
		rect N*@x+2,N*@y+2,@w-4,@h-4,15
		fill if @active then 0 else 128
		if @title != 0 
			text @title,N*@x+@w/2,N*@y+@h/2
	setxy : (@x,@y) ->
	inside : -> 
		if deviceOrientation == LANDSCAPE
			factor = min width/6/N,height/4/N
		else # PORTRAIT or undefined
			factor = min width/4/N,height/6/N

		x = mouseX / factor
		y = mouseY / factor
		@active and N*@x < x < N*@x+@w and N*@y < y < N*@y+@h

randomMoveList = (grid, nMoves, moveList=[]) ->
	if moveList.length == nMoves 
		print moveList
		return moveList

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
deviceTurned  = -> resizeCanvas windowWidth, windowHeight

setup = ->
	createCanvas windowWidth,windowHeight

	level = localStorage[KEY]
	level = if level? then parseInt level else 1
	#level = 15

	for i in range 16
		x = i%4
		y = i//4
		buttons.push new Button i,x,y,N,N,100,->
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

	buttons.push new Button 'Go',0,5,N,N,50,->
		goState 1
		grid = new Grid INIT_GRID, [3,3]
		window.solution = []
		grid = grid.applyMoves randomMoveList grid,level
		transfer()

	buttons.push new Button 'Solve',1,5,N,N,50,->
		if level > 1 then level--
		window.solution = []
		originalGrid = grid.copy()
		solve grid
		current = 0
		goState 2

	buttons.push new Button 'Prev',2,5,N,N,50,-> update -1
	buttons.push new Button 'Next',3,5,N,N,50,-> update +1

	goState 0

	grid = new Grid INIT_GRID, [3,3]
	transfer()

draw = ->

	if deviceOrientation == LANDSCAPE
		scale min width/6/N,height/4/N
		buttons[16].setxy 4,0 
		buttons[17].setxy 5,0 
		buttons[18].setxy 4,3 
		buttons[19].setxy 5,3 
	else # PORTRAIT or undefined
		scale min width/4/N,height/6/N
		buttons[16].setxy 0,5 
		buttons[17].setxy 1,5 
		buttons[18].setxy 2,5 
		buttons[19].setxy 3,5 

	background 128
	for button in buttons
		button.draw()
	if solution.length > 0
		textAlign CENTER,CENTER
		fill 255
		if deviceOrientation == LANDSCAPE
			text "#{current} of #{solution.length}", 5*N,2.5*N
		else # PORTRAIT or undefined
			text "#{current} of #{solution.length}", 3*N,4.5*N
	fill 255
	if deviceOrientation == LANDSCAPE
		text level,5*N,1.5*N
	else # PORTRAIT or undefined
		text level,N,4.5*N
	fill 0

toggleFullscreen = ->
	elem = document.querySelector "#fullscreen"
	if !document.fullscreenElement
		elem.requestFullscreen() #.catch (err) -> alert "Error: #{err.message} (#{err.name})"
	else 
		document.exitFullscreen()

mouseReleased = ->
	released = true
	false
mousePressed = ->
	if not released then return false
	released = false 

	for button,i in buttons
		if button.inside() 
			if button.title == 0 then toggleFullscreen()
			if (state==1 and i<16) or i>=16
				button.click()
				localStorage[KEY] = level
				return false 
	false 



