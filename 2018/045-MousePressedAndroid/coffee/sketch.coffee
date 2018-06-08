counter = 0
messages = []

setup = ->
	createCanvas windowWidth, windowHeight

draw = ->
	bg 1
	textSize 50
	for message,i in messages
		text message,100,50*(i+1)


mouseTouched = -> messages.push 'mouseTouched'
mouseReleased = -> messages.push 'mouseReleased'

mousePressed = ->
	counter += 1
	messages.push "mousePressed #{counter}"
