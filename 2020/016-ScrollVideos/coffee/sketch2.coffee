setup = ->
	createCanvas 200,200

draw = ->
	bg 0.5
	textSize 100
	textAlign CENTER,CENTER
	text round(frameRate()),100,100