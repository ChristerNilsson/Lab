stars = []
level = 0
dd = 50
x = 0
y = 0

setup = ->
	createCanvas windowWidth,windowHeight
	startNewGame 1

startNewGame = (dlevel) ->
	if dlevel == 1
		stars = []
		d = dd/2
		for i in range 1,width/dd
			for j in range 1,height/dd
				star = [dd*i+int(random -d,d), dd*j+int(random -d,d)]
				stars.push star
	level += dlevel
	x = 0
	y = height/2
	bg 0.5
	sc 0
	for star in stars
		[x1,y1] = star
		circle x1,y1,level
	rect width-3, 0.4*height, 2, 0.2*height

draw = ->
	x++
	if keyIsDown 32
		y = y+1
	else
		y = y-1
	sc 1
	point x,y
	if x > width and 0.4*height < y < 0.6*height
		return startNewGame 1
	if y<0 or y>height or x>width
		return startNewGame 0
	for star in stars
		[x1,y1] = star
		if dist(x,y,x1,y1) < level
			return startNewGame 0