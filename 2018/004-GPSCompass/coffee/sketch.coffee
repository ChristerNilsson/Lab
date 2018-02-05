bearing = 0
result = 'no lock'

setup = ->
	screen.lockOrientationUniversal = screen.lockOrientation || screen.mozLockOrientation || screen.msLockOrientation
	if screen.lockOrientationUniversal
		result = screen.lockOrientationUniversal 'portrait'
	createCanvas windowWidth,windowHeight
	window.addEventListener "deviceorientation", (event) -> 
		if event.alpha then	bearing = Math.round event.alpha
	textSize 100
	textAlign CENTER,CENTER

draw = ->
	bg 1
	text result, width/2, height/4
	text bearing, width/2, height/2
