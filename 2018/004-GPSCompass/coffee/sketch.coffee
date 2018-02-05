bearing = 0
#result = 'no lock'
orientation = 'unknown'

centerLoginBox = ->
	if window.orientation == 90 || window.orientation == -90
		orientation = window.orientation
	else if window.orientation == 0 || window.orientation == 180
		orientation = window.orientation

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
	$(document).ready ->
		window.addEventListener "orientationchange", centerLoginBox
		window.addEventListener "load", centerLoginBox

draw = ->
	bg 1
	#text result, 			width*0.5, height*0.25
	text bearing, 		width*0.5, height*0.50
	if orientation
		text orientation, width*0.5, height*0.75
	else
		text 'orient unknown', width*0.5, height*0.75
