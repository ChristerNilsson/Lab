bearing = 0

setup = ->
	createCanvas windowWidth,windowHeight
	window.addEventListener "deviceorientation", (event) -> 
		if event.alpha then	bearing = 360 - Math.round event.alpha
	textSize 100
	textAlign CENTER,CENTER

draw = ->
	bg 1
	text bearing, width*0.5, height*0.50
	if window.orientation
		text window.orientation, width*0.5, height*0.75
	else
		text 'orient unknown', width*0.5, height*0.75
