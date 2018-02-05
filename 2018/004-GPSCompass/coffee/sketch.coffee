bearing = 0

setup = ->
	createCanvas windowWidth,windowHeight
	window.addEventListener "deviceorientation", (event) -> 
		if event.alpha then	bearing = event.alpha
	textSize 100
	textAlign CENTER,CENTER

draw = ->
	bg 1
	text bearing,width/2,height/2
