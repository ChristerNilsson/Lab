canvas = null
mode = 'P'
ratio = 1

setup = -> 
	c = document.createElement 'canvas'
	context = c.getContext '2d'
	document.body.appendChild c
	canvas = createCanvas window.innerWidth/2,window.innerHeight/2
	devicePixelRatio = window.devicePixelRatio || 1
	backingStoreRatio = context.webkitBackingStorePixelRatio || context.mozBackingStorePixelRatio || context.msBackingStorePixelRatio || context.oBackingStorePixelRatio || context.backingStorePixelRatio || 1
	ratio = devicePixelRatio / backingStoreRatio

	textAlign CENTER,CENTER
	textSize 20
	readDeviceOrientation = ->
		if window.orientation in [-90,90]
			resizeCanvas window.innerHeight/2*ratio,window.innerWidth/2*ratio
			canvas.position 0, 0
			mode = 'L'
		else 
			resizeCanvas window.innerWidth/2*ratio,window.innerHeight/2*ratio
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
	text ratio, width/2,0.85*height
