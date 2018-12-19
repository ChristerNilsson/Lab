stack = []

setup = ->
	createCanvas 750,750
	background 128
	noFill()
	scale 15
	circle 15,20,15
	circle 30,15,15
	circle 25,35,15

floodFill = (x,y,c2) ->
	add = (x,y) ->
		if _.isEqual c1, get x,y
			stack.push [x,y] 

	stack.push [x,y]
	c1 = get x,y
	start = new Date()
	while stack.length > 0
		[x,y] = stack.pop()
		set x,y,c2
		add x+1,y
		add x-1,y
		add x,y-1
		add x,y+1
	updatePixels()

mousePressed = -> floodFill mouseX,mouseY,[255,0,0,255]