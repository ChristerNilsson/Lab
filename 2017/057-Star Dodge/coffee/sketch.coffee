stars = []
level = x = y = 0
dd = 50

# DEPRECATED!

setup = ->
	createCanvas windowWidth,windowHeight
	startNewGame 1

startNewGame = (dlevel) ->
	if dlevel == 1
		stars = []
		d = dd/2
		for i in range 1,width/dd
			for j in range 1,height/dd
				stars.push [dd*i+int(random -d,d), dd*j+int(random -d,d)]
	level += dlevel
	x = 0
	y = height/2
	bg 0.5
	sc 0
	for [x1,y1] in stars
		circle x1,y1,level
	rect width-3, 0.4*height, 2, 0.2*height

draw = ->
	x++
	y = if keyIsDown 32 then y+1 else y-1
	sc 1
	point x,y
	if x > width and 0.4*height < y < 0.6*height then return startNewGame 1
	if y<0 or y>height or x>width then return startNewGame 0
	for [x1,y1] in stars
		if dist(x,y,x1,y1) < level then return startNewGame 0