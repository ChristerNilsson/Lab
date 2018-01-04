setup = ->
	createCanvas 400,400

draw = ->
	bg 0.5

mousePressed = ->
	window.open 'sms:+46707496800?body=SUBSCRIBE', '_self'	
