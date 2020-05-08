VERSION = 11
bakgrund = '#888'
SCALE = 1
cx = 0
cy = 0
msg0 = VERSION
msg1 = ""
msg2 = ""
buttons = []
startX = 0
startY = 0 

class Button
	constructor : (@prompt,@x,@y,@click) -> @r=50
	draw : ->
		circle @x,@y,@r
		text @prompt,@x,@y
	inside : (x,y) -> @r > dist x,y,@x,@y

setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	textSize 50
	cx = width/2
	cy = height/2
	buttons.push new Button '+',50,50, -> SCALE *= 1.5
	buttons.push new Button '-',150,50, -> SCALE /= 1.5

draw = ->
	background bakgrund
	push()
	translate cx,cy
	scale SCALE
	circle 0,0,100
	pop()
	for button in buttons 
		button.draw()
	text msg0,width/2,height/2
	text SCALE,width/2,height/2+100
	text msg2,width/2,height/2+200

touchStarted = (event) ->
	event.preventDefault()
	startX = mouseX
	startY = mouseY
	msg0 = "started #{SCALE}"

touchEnded = (event) ->
	event.preventDefault()
	for button in buttons
		if button.inside mouseX,mouseY then return button.click()
	cx += mouseX-startX
	cy += mouseY-startY
	startX = 0
	startY = 0
	msg2 = "ended #{SCALE}"

