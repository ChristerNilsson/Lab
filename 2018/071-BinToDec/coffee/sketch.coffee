buttons = []

class Button
	constructor : (@x,@y,@r=12.5,@value=0) -> @active = 0
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
	for i in range 8
		buttons.push new Button 188-i*25,100,12,2**i

draw = ->
	bg 0.5
	res = (button.draw() for button,i in buttons).reduce (a,b) -> a+b
	fc 0
	text res,100,150

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.toggle()