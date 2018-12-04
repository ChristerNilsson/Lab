class Button
	constructor : (@x,@y) ->
		@r = 50
		@active = false 
		@found = false 
	draw : ->
		if @active then fc 1 else fc 0
		sc()
		circle @x,@y,@r
		if @found 
			fc 1,1,0
			circle @x,@y,@r/2
	inside : (x,y) -> @r > dist x,y,@x,@y
	click : -> @active = not @active

buttons = []
clicks = 0

setup = ->
	createCanvas 600,600
	angleMode DEGREES
	textSize 200
	textAlign CENTER,CENTER
	for i in range 12
		x =  width/2+250*cos 30*i-90
		y = height/2+250*sin 30*i-90
		buttons.push new Button x,y
	buttons[1].found  = true
	buttons[11].found = true

drawCenterOfGravity = ->
	fc()
	sc 1,0,0
	sw 2
	x = 0
	y = 0
	count = 0
	for button in buttons
		if button.active 
			x+=button.x
			y+=button.y
			count++
	if count > 0
		x /= count
		y /= count
		circle x,y,25	
		if x==width/2 and y==height/2 
			buttons[count%12].found = true

draw = ->
	count = 0
	for button in buttons
		if button.found then count++
	if count==12 then bg 0,1,0 else bg 0.5
	fc 1,1,0
	sc()
	text clicks,width/2,height/2
	sc 0
	fc()
	circle width/2,height/2,10
	for button in buttons
		button.draw()
	drawCenterOfGravity()

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY 
			button.click()
			clicks++