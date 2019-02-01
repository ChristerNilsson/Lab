grid = null
cols = null
rows = null
w = 20
totalBees = 40
images = {}
count = 0

loop2 = (f) -> f i,j for j in range rows for i in range cols

preload = ->
	images = {}
	for file in '1 2 3 4 5 6 7 8 bomb flag tile tile_depressed'.split ' '
		images[file] = loadImage "graphics/#{file}.png"

setup = ->
	createCanvas 410, 410
	textAlign CENTER,CENTER
	textSize w
	rectMode CENTER
	cols = width // w
	rows = height // w
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
	if count == cols*rows then text 'Game Over',width/2,height/2

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
			if mouseButton == LEFT 
				grid[i][j].reveal()
				if grid[i][j].bee then gameOver()
			else if mouseButton == RIGHT then grid[i][j].toggle()
