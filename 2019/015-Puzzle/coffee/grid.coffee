originalPosition = (num) ->	[(num-1) // 4, (num-1) % 4]

manhattanDist = (num, curRow, curCol) ->
	[origRow, origCol] = originalPosition(num)
	Math.abs(origRow - curRow) + Math.abs(origCol - curCol)

class Grid
	constructor: (grid=INIT_GRID, emptyPos=[3,3]) ->
		@emptyPos = emptyPos.slice()

		@grid = []
		for row in grid
			@grid.push row.slice()

	copy : ->
		new Grid @grid,@emptyPos

	validMoves: ->
		[rowNum, colNum] = @emptyPos
		valid = []
		valid.push XLEFT  if colNum != 0
		valid.push XRIGHT if colNum != 3
		valid.push XABOVE if rowNum != 0
		valid.push XBELOW if rowNum != 3
		valid

	positionToMove: (rowNum, colNum) ->
		[emptyRow, emptyCol] = @emptyPos
		if rowNum == emptyRow
			if colNum == emptyCol - 1 then return XLEFT
			if colNum == emptyCol + 1 then return XRIGHT
		if colNum == emptyCol
			if rowNum == emptyRow - 1 then return XABOVE
			if rowNum == emptyRow + 1 then return XBELOW
		null

	applyMoveFrom: (sourceDirection) ->
		[targetRow, targetCol] = @emptyPos
		[deltaRow, deltaCol] = directionToDelta sourceDirection
		emptyPos = [sourceRow, sourceCol] = [
			targetRow + deltaRow,
			targetCol + deltaCol
		]

		grid = []
		for row in @grid
			grid.push row.slice()

		grid[targetRow][targetCol] = grid[sourceRow][sourceCol]
		grid[sourceRow][sourceCol] = 0

		nextGrid = new Grid grid, emptyPos

		number = grid[targetRow][targetCol]
		nextGrid._lowerSolutionBound = @lowerSolutionBound() -
			manhattanDist(number, sourceRow, sourceCol) +
			manhattanDist(number, targetRow, targetCol)

		nextGrid

	applyMoves: (sourceDirections) ->
		nextGrid = @
		for dir in sourceDirections
			nextGrid = nextGrid.applyMoveFrom dir
		nextGrid

	lowerSolutionBound: ->
		# This calculates a lower bound on the minimum
		# number of steps required to solve the puzzle

		# This is the sum of the rectilinear distances
		# from where each number is to where it should
		# be
		if not @_lowerSolutionBound?
			moveCount = 0
			for rowNum of @grid
				for colNum of @grid[rowNum]
					number = @grid[rowNum][colNum]
					continue if number == 0
					moveCount += manhattanDist number, rowNum, colNum
			@_lowerSolutionBound = moveCount
		return @_lowerSolutionBound

	isSolved: -> @lowerSolutionBound() == 0

	log: ->
		console.log "Empty: #{@emptyPos}"
		for row in @grid
			console.log row
