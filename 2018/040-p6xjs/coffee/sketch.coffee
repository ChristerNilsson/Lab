message = ""

moved = (m) -> @strokeWeight = if @contains m then 3 else 1

setup = ->
	createCanvas 600,600
	angleMode DEGREES
	
	p6.circle(300,300,200).fill "#ff0"
	shapes.letters = p6.group 300,300
	shapes.digits = p6.group 300,300

	alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	for letter,i in alfabet
		x = 200 * cos i*360/alfabet.length
		y = 200 * sin i*360/alfabet.length
		c = p6.circle x,y,30,shapes.letters
		c.fill "#f00"
		c.text letter
		c.moved = moved
		c.pressed = -> message += @txt

	numbers = '0123456789'
	for digit,i in numbers
		x = 260 * cos i*360/numbers.length
		y = 260 * sin i*360/numbers.length
		c = p6.circle x,y,30,shapes.digits
		c.fill "#0f0"
		c.text digit
		c.moved = moved
		c.pressed = -> message = @txt

draw = ->
	bg 0.5
	stage.draw()

	shapes.letters.rotation += 0.1
	for child in shapes.letters.children
		child.rotation -= 2.9

	shapes.digits.rotation -= 0.1
	for child in shapes.digits.children
		child.rotation += 3.1

	textSize 100
	textAlign CENTER,CENTER
	text message,300,300

mouseMoved   = ->	stage.mouseMoved() 
mousePressed = ->	stage.mousePressed()
