SIZE = 20
circles = []

dx = 0
dy = 0 
zoomPan = [0,0,1]

class Circle 
	constructor : (@x,@y,@radius,@col) ->
	draw : -> 
		fill @col
		[x,y,zoom] = zoomPan
		circle x+@x,y+@y,zoom*@radius

setup = ->
	createCanvas windowWidth,windowHeight
	circles.push new Circle 100,100,100,'#f008'
	circles.push new Circle 200,200,150,'#ff08'
	textSize SIZE

draw = ->
	bg 0.5
	for circle in circles
		circle.draw()

#touchStarted = () -> msg 0,mouseX,mouseY,touches
#touchMoved =   () -> msg height/3,mouseX,mouseY,touches
#touchEnded =   () -> msg 2*height/3,mouseX,mouseY,touches

mousePressed = ->
	dx = mouseX
	dy = mouseY

mouseDragged = ->
	if mouseIsPressed
		zoomPan[0] += mouseX-dx
		zoomPan[1] += mouseY-dy
		dx = mouseX
		dy = mouseY

mouseWheel = (event) ->
	zoomPan[2] += event.delta/10000
