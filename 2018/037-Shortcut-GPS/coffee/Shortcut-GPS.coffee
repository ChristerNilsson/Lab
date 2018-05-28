buttons = []
w = null
h = null

class Button
	constructor : (@txt,@x,@y,@radius,@event) ->
	draw : -> text @txt,@x,@y
	inside : (mx,my) -> @x-w/2 < mx < @x+w/2 and @y-h/2 < my < @y+h/2

setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	w = width/1
	h = height/7
	textSize h
	sc()
	for txt,i in "Instructions 10m 20m 50m 100m 200m 500m".split ' '
		button = new Button txt,width/2,h/2+i*h,txt
		buttons.push button
		if i == 0
			button.event = -> window.open 'https://github.com/ChristerNilsson/Lab/blob/master/2018/037-Shortcut-GPS/README.md#shortcut-gps' 
		else
			button.event = ->	window.open 'Shortcut-GPS2.html?size=' + @radius

draw = ->
	bg 1
	for button in buttons 
		button.draw()

mousePressed = (mx,my) ->
	for button in buttons
		if button.inside mouseX,mouseY
			button.event()