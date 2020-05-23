ts = 50

setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER

draw = ->
	bg 1,0,0
	fr = round frameRate()
	textSize ts
	text round(ts), width/2,0.50 * height
	text fr, width/2,0.75 * height
	#ts += 0.1

touchStarted = -> ts++