ts = 50

setup = ->
	createCanvas windowWidth,windowHeight # 10 fps på Android
	#createCanvas 100,100 # 60 fps
	textAlign CENTER,CENTER
	frameRate 1

draw = ->
	bg 0.5
	fr = frameRate()
	textSize ts
	text round(ts), width/2,0.50 * height
	text round(fr), width/2,0.75 * height

touchStarted = -> ts++