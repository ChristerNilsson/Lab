setup = ->
	createCanvas 400,400

draw = ->
	bg 0.5

mousePressed = ->
	window.location.href = "smsto:+46707496800?body=Hello"