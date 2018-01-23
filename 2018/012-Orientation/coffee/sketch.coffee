canvas = null
mode = 'P'

setup = -> 
	canvas = createCanvas window.innerWidth/2,window.innerHeight/2
	textAlign CENTER,CENTER
	textSize 20
	readDeviceOrientation = ->
		if window.orientation in [-90,90]
			resizeCanvas window.innerHeight/2,window.innerWidth/2
			canvas.position 0, 0
			mode = 'L'
		else 
			resizeCanvas window.innerWidth/2,window.innerHeight/2
			canvas.position 0, 0
			mode = 'P'

	window.onorientationchange = readDeviceOrientation #

	readDeviceOrientation()

draw = ->
	bg 0.5
	text window.devicePixelRatio, width/2,0.15*height
	text window.innerWidth + ' ' + window.innerHeight,   width/2,0.25*height
	text mode + ' ' + width+' '+height,      width/2,0.50*height
	text screen.width + ' ' + screen.height, width/2,0.75*height
