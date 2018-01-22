canvas = null

setup = -> 
	canvas = createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	readDeviceOrientation = ->
		if 90 == Math.abs window.orientation
			resizeCanvas windowWidth/2,windowHeight/2 
			x = width # (windowWidth - width) / 2;
			y = 0 #(windowHeight - height) / 2;
			canvas.position x, y
			#text "L " + width+' '+height,width/2,height/2
			text "L " + width+' '+height,100,100
		else 
			resizeCanvas windowWidth/2,windowHeight/2
			x = width # (windowWidth - width) / 2;
			y = 0 #(windowHeight - height) / 2;
			canvas.position x, y
			#text "P " + width+' '+height,width/2,height/2
			text "P " + width+' '+height,100,100

	window.onorientationchange = readDeviceOrientation

	readDeviceOrientation()

draw = ->
	bg 0.5

