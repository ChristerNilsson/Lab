grid = null
x = 0
y = 0
dir = 0
N = 1 # 4 # 1
count = 0

setup = ->
	createCanvas 200*N, 200*N
	grid = Array width/N
	for i in range width/N
		grid[i] = []
		for j in range height/N
			grid[i][j] = 0
	x = width/N/2
	y = height/N/2
	dir = 0
	bg 1,0,0

draw = ->
	for i in range 100
		state = grid[x][y]
		if state == 0 then dir++ else dir--
		dir %%= 4
		grid[x][y] = 1-state
		sc 1-state
		fc 1-state
		rect N*x,N*y,N,N
		x += [0,1,0,-1][dir]
		y += [1,0,-1,0][dir]
		x = x %% 200
		y = y %% 200
	count+=100
	print count 
