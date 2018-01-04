setup = ->
	createCanvas 400,400

draw = ->
	bg 1,0,0

mousePressed = ->
	window.open 'sms:+46707496800?body=SUBSCRIBE' # , '_self'	
