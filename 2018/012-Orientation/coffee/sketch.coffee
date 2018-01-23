canvas = null
orientation = null

setup = -> 
	canvas = createCanvas windowWidth,windowHeight
	canvas.position 0, 0
	textAlign CENTER,CENTER
	textSize 20
	readDeviceOrientation = ->
		if 90 == Math.abs window.orientation
			resizeCanvas windowWidth/2,windowHeight/2 
			orientation = 'L'
		else 
			resizeCanvas windowWidth/2,windowHeight/2
			orientation = 'P'

	window.onorientationchange = readDeviceOrientation

	readDeviceOrientation()

draw = ->
	bg 0.5
	text windowWidth+' '+windowHeight,0.5*width,0.25*height
	text orientation + ' ' + width+' '+height,0.5*width,0.5*height
