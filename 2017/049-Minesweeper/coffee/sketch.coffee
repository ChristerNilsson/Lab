grid = null
cols = null
rows = null
w = 20
totalBees = 10

loop2 = (f) -> f i,j for j in range rows for i in range cols

setup = ->
	createCanvas 201, 201
	textAlign CENTER,CENTER
	textSize w
	rectMode CENTER
	cols = floor width / w
	rows = floor height / w
	grid = make2DArray cols, rows, (i,j) -> new Cell i, j, w

	n = 0
	while n < totalBees
		cell = grid[int random cols][int random rows]
		if not cell.bee
			cell.bee = true
			n++

	loop2 (i,j) -> grid[i][j].countBees()

draw = ->
	background 255
	loop2 (i,j) -> grid[i][j].show()

make2DArray = (cols, rows, f) ->
	arr = new Array cols
	for i in range arr.length
		arr[i] = new Array rows
		for j in range cols
			arr[i][j] = f i,j
	arr

gameOver = () -> loop2 (i,j) -> grid[i][j].revealed = true

mousePressed = ->
	loop2 (i,j) ->
		if grid[i][j].contains mouseX, mouseY
			grid[i][j].reveal()
			if grid[i][j].bee then gameOver()