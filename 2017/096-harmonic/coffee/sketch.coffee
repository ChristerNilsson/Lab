angle = 0

setup = ->
	createCanvas windowWidth,windowHeight

draw = ->
	bg 0
	m = 3 # map mouseX,0,width, 1,2
	n = 4 # map mouseY,0,height, 1,2
	for i in range 360
		angle += 0.02
		x = map cos(m*angle), -1,1, 0,width
		y = map sin(n*angle), -1,1, 0,height
		circle x,y,10