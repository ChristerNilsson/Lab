ts = 50

setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER

draw = ->
	bg 0.5
	fr = round frameRate()
	textSize ts
	text ts, width/2,0.50 * height
	text fr, width/2,0.75 * height

touchStarted = -> ts++