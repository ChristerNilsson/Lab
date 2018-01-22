
setup = -> 
	createCanvas windowWidth,windowHeight
	readDeviceOrientation = ->
		if 90 == Math.abs window.orientation
			text "L " + width+' '+height,width/2,height/2
		else 
			text "P " + width+' '+height,width/2,height/2

	window.onorientationchange = readDeviceOrientation

	readDeviceOrientation()

draw = ->

