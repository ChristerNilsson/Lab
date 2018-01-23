canvas = null
mode = 'P'

setup = -> 
	canvas = createCanvas windowWidth,windowHeight
	# textAlign CENTER,CENTER
	# textSize 20
	# readDeviceOrientation = ->
	# 	resizeCanvas round(windowWidth/2),round(windowHeight/2) 
	# 	if 90 == abs window.orientation
	# 		#resizeCanvas round(windowWidth/2),round(windowHeight/2) 
	# 		#canvas.position 0, 0
	# 		mode = 'L'
	# 	else 
	# 		#resizeCanvas round(windowWidth/2),round(windowHeight/2) 
	# 		#canvas.position 0, 0
	# 		mode = 'P'

	# window.onorientationchange = readDeviceOrientation

	# readDeviceOrientation()

draw = ->
	bg 0.5
	text windowWidth + ' ' + windowHeight, width/2,height/4
	text mode + ' ' + width+' '+height,    width/2,height/2
