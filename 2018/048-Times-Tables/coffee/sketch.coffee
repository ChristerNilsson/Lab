times = 0
n = null
pause = false 

setup = -> 
	createCanvas windowWidth, windowHeight
	n = round height * 0.49
	angleMode DEGREES
	sw 1/n

draw = ->
	bg 0
	sc 1,0,0,0.5
	translate width/2, height/2	
	scale n
	for i in range 360
		x1 = cos i
		y1 = sin i
		x2 = cos i * times/2000
		y2 = sin i * times/2000
		line x1, y1, x2, y2
	if not pause then times++

mousePressed = -> 
	if n > dist n,n,mouseX,mouseY 
		pause = not pause
	else if mouseX < n
		times--
	else times++		
