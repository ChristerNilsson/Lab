canvas = null
mode = 'P'
ratio = 1
w=null
h=null

setup = -> 
	#c = document.createElement 'canvas'
	#context = c.getContext '2d'
	#document.body.appendChild c
	#devicePixelRatio = window.devicePixelRatio || 1
	#backingStoreRatio = context.webkitBackingStorePixelRatio || context.mozBackingStorePixelRatio || context.msBackingStorePixelRatio || context.oBackingStorePixelRatio || context.backingStorePixelRatio || 1
	#ratio = devicePixelRatio / backingStoreRatio

	w = window.innerWidth
	h = window.innerHeight
	#c.width = w * ratio
	#c.height = h * ratio
	#c.style.width = w + 'px'
	#c.style.height = h + 'px'
	ratio = 1

	canvas = createCanvas w,h
	#canvas.parent = c

	textAlign CENTER,CENTER
	textSize 20
	readDeviceOrientation = ->
		h = window.innerWidth
		w = window.innerHeight
		if window.orientation in [-90,90]
			resizeCanvas h*ratio/2,w*ratio/2
			#canvas.position 0, 0
			mode = 'L'
		else 
			resizeCanvas h*ratio,w*ratio
			#canvas.position 0, 0
			mode = 'P'

	window.onorientationchange = ->
		window.setTimeout readDeviceOrientation, 300

	readDeviceOrientation()

draw = ->
	bg 0.5
	text window.devicePixelRatio, width/2,0.10*height
	text window.innerWidth + ' ' + window.innerHeight,   width/2,0.20*height
	text mode + ' ' + width+' '+height,      width/2,0.30*height
	text screen.width + ' ' + screen.height, width/2,0.40*height
	if window.orientation 
		text window.orientation, width/2,0.50*height
