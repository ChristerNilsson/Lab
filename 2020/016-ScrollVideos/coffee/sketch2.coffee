ts = 50

setup = ->
	#createCanvas windowWidth,windowHeight
	createCanvas 100,100
	textAlign CENTER,CENTER

draw = ->
	bg 0,1,0
	fr = round frameRate()
	textSize ts
	text round(ts), width/2,0.50 * height
	text fr, width/2,0.75 * height

touchStarted = -> ts++