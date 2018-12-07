class Button
	constructor : (@title,@x,@y) -> 
		@state = HIDDEN
		@w=50
		@h=50
	inside : (x,y) ->
		@x-@w/2< x < @x+@w/2 and @y-@h/2< y < @y+@h/2
	draw : ->
		if @state!=DONE then rect @x,@y,@w,@h
		if @state==VISIBLE then text @title,@x,@y

N = 6
HIDDEN = 0
VISIBLE = 1
DONE = 2

done = 0
buttons = []
alfabet = 'AABBCC'
visible = []

setup = ->
	createCanvas 600,600
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 42
	newGame()

newGame = ->
	alfabet = _.shuffle alfabet
	buttons = []
	done = 0
	for i in range N
		letter = alfabet[i]
		buttons.push new Button letter,100+50*i,100

draw = ->
	bg 0.5
	for button in buttons
		button.draw()

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY
			if button.state != HIDDEN then return 
			button.state = VISIBLE
			switch visible.length
				when 0
					visible.push button					
				when 1
					a = button
					b = visible[0]
					if a.title == b.title
						a.state = DONE
						b.state = DONE
						done += 2
						visible=[]
						if done==N then newGame()
					else
						visible.push button					
				when 2
					for b in visible
						b.state = HIDDEN
					visible = [button]
