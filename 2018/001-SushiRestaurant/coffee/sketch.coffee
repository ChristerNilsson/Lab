setup = ->
	createCanvas 400,400

draw = ->
	bg 0,0,1

mousePressed = ->
	window.location.href = "sms://+46707496800;?&body=message%20more%20message"
	#window.open 'sms:+46707496800?body=SUBSCRIBE' # , '_self'	
