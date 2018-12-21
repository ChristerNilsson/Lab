stack = []

setup = ->
	createCanvas 750,750
	background 128
	noFill()
	scale 14
	circle 16,21,15
	circle 31,16,15
	circle 26,36,15

floodFill = (x,y,c2) ->
	add = (x,y) ->
		if _.isEqual c1, get x,y
			stack.push [x,y] 

	stack.push [x,y]
	c1 = get x,y
	while stack.length > 0
		[x,y] = stack.pop()
		set x,y,c2
		add x-1,y
		add x+1,y
		add x,y-1
		add x,y+1
	updatePixels()

mousePressed = -> 
	r = random 256
	g = random 256
	b = random 256
	floodFill mouseX,mouseY,[r,g,b,255]