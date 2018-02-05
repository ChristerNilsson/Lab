bearing = 0
#result = 'no lock'
#orientation = 'unknown'

setup = ->
	#screen.lockOrientationUniversal = screen.lockOrientation || screen.mozLockOrientation || screen.msLockOrientation
	#if screen.lockOrientationUniversal
	#	result = screen.lockOrientationUniversal 'portrait'
	createCanvas windowWidth,windowHeight
	window.addEventListener "deviceorientation", (event) -> 
		if event.alpha then	bearing = Math.round event.alpha
	textSize 100
	textAlign CENTER,CENTER

	#window.addEventListener "orientationchange", (-> orientation = window.orientation), false

draw = ->
	bg 1
	#text result, 			width*0.5, height*0.25
	text bearing, 		width*0.5, height*0.50
	if window.orientation
		text window.orientation, width*0.5, height*0.75
	else
		text 'orient unknown', width*0.5, height*0.75
