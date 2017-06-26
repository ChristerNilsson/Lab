frog = null
obstacles = []
grid_size = 50

resetGame = -> frog = new Frog width / 2, height - grid_size, grid_size, grid_size

create = (a,b,c,d,e,f) ->
	for i in range a
		x = i * b + c
		y = height - d * grid_size
		obstacles.push new Obstacle x, y, e * grid_size, grid_size, f

setup = ->
	createCanvas 700, 700
	resetGame()
	create 2,400, 10,12,4,0.5
	create 3,250, 30,11,2,-1.4
	create 2,250,100,10,3,2.2
	create 3,200, 30,9,2,-1.3
	create 2,200,100,8,3,2.3

	create 3,150, 25,6,1,1.2
	create 2,200,150,5,1,-3.5
	create 3,150, 25,4,1,1.3
	create 2,200,150,3,1,-3.4
	create 2,300,  0,2,2,2

draw = ->
	background 0
	fill 255, 100

	rect 0, 0, width, 2 * grid_size
	rect 0, height - 7 * grid_size, width, grid_size
	rect 0, height - grid_size, width, grid_size

	intersector = null
	for o in obstacles
		o.show()
		o.update()
		if frog.intersects o then intersector = o
	frog.attach null
	if frog.y >= height - grid_size * 7
		if intersector != null then resetGame()
	else if frog.y >= 2 * grid_size
		if intersector == null then resetGame() else frog.attach intersector
	frog.update()
	frog.show()

keyPressed = ->
	if keyCode == UP_ARROW    then frog.move 0, -grid_size
	if keyCode == DOWN_ARROW  then frog.move 0, grid_size
	if keyCode == LEFT_ARROW  then frog.move -grid_size, 0
	if keyCode == RIGHT_ARROW then frog.move grid_size, 0