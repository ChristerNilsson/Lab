grid = null
x = 0
y = 0
dir = 0

setup = () ->
	createCanvas 200, 200
	grid = Array width
	for i in range width
		grid[i] = []
		for j in range height
			grid[i][j] = 0
	x = width/2
	y = height/2
	dir = 0
	bg 0.5

draw = () ->
	state = grid[x][y]
	if state == 0 then dir++ else dir--
	dir %%=4
	grid[x][y] = 1-state
	sc 1-state
	point x,y
	x += [0,1,0,-1][dir]
	y += [1,0,-1,0][dir]
	x = x %% width
	y = y %% height
