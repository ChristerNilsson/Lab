setup = ->
	createCanvas 400,400

draw = ->
	bg 1,1,0

mousePressed = ->
	#window.location.href = "sms:+46707496800&body=message" # iOS ok!
	window.location.href = "sms://+46707496800?&body=message" # 
