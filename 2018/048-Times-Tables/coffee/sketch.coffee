times = 0
n = null

setup = -> 
	createCanvas windowWidth, windowHeight
	n = round height * 0.49
	angleMode DEGREES
	sw 1/n

draw = ->
	bg 1
	translate width/2, height/2	
	scale n
	for i in range 360
		x1 = cos i
		y1 = sin i
		x2 = cos i * times/2000
		y2 = sin i * times/2000
		line x1, y1, x2, y2
	times++
