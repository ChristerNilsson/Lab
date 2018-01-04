setup = ->
	createCanvas 400,400

draw = ->
	bg 0.5

mousePressed = ->
	window.location.href = "sms:+46707496800?body=Hello"