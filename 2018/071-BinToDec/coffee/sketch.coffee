buttons = []

class Button
	constructor : (@x,@y,@r,@value) -> @active = 0
	draw : -> 
		fc @active
		circle @x,@y,@r
		fc 0.5
		text @value,@x,@y
		@active * @value
	toggle : -> @active = 1 - @active
	inside : (mx,my) -> @r > dist mx,my,@x,@y

setup = ->
	createCanvas 200,200
	textAlign CENTER,CENTER
	textSize 24
	r = 70
	for i in range 8
		angle = PI/4*i
		x = 100+r*cos angle
		y = 100+r*sin angle
		buttons.push new Button x,y,25,2**i

draw = ->
	bg 0.5
	lst = (button.draw() for button in buttons)
	res = lst.reduce (a,b) -> a+b
	fc 0
	text res,100,100

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.toggle()