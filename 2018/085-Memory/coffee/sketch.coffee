SIZE = 100

class Button
	constructor : (@title,@x,@y,@event) -> @visible = false 
	draw : ->
		x = SIZE+@x*SIZE
		y = SIZE+@y*SIZE
		rect x,y,SIZE,SIZE
		if @visible then text @title,x,y
	inside : (mx,my) -> @x-1/2 < mx/SIZE-1 < @x+1/2 and @y-1/2 < my/SIZE-1 < @y+1/2
	execute : -> @event()

clicks = 0
buttons = []
clicked = []

setup = ->
	createCanvas 600,500
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 50
	arr = _.shuffle 'ABCDEFGHIJABCDEFGHIJ'.split ''
	for title,i in arr
		buttons.push new Button title,i%%5,i//5, ->
			if @found then return
			if clicked.length == 0 or clicked.length == 1 and clicked[0] != @
				clicks++
				clicked.push @
				@visible = true
			else
				if clicked[0].title == clicked[1].title			
					for click in clicked
						click.visible = true
						click.found = true
				else
					for click in clicked
						click.visible = false
				clicked = []
draw = ->
	bg 0.5
	for button in buttons
		button.draw()
	text clicks,width/2,SIZE/4

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY 
			button.execute()