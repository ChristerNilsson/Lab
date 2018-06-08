counter = 0
messages = []
released = true

setup = ->
	createCanvas windowWidth, windowHeight

draw = ->
	bg 1
	textSize 50
	for message,i in messages
		text message,100,50*(i+1)


#mouseTouched = -> messages.push 'mouseTouched'
mouseReleased = ->
	released = true
	messages.push 'mouseReleased'
	false

mousePressed = ->
	if not released then return false
	released = false 
	counter += 1
	messages.push "mousePressed #{counter}"
	false
