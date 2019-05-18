N = 6
HIDDEN = 0
VISIBLE = 1
DONE = 2

done = 0
buttons = []
alfabet = 'AABBCC'
visible = []

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
	click : ->
		if @state != HIDDEN then return 
		@state = VISIBLE
		switch visible.length
			when 0
				visible.push @
			when 1
				a = @
				b = visible[0]
				if a.title == b.title
					a.state = DONE
					b.state = DONE
					done += 2
					visible=[]
					if done==N then newGame()
				else
					visible.push @
			when 2
				for b in visible
					b.state = HIDDEN
				visible = [@]

setup = ->
	createCanvas 600,600
	test()
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
		if button.inside mouseX,mouseY then button.click()

test = ->
	a = new Button 'A',0,0
	b = new Button 'A',0,0
	c = new Button 'B',0,0
	d = new Button 'B',0,0
	e = new Button 'C',0,0
	f = new Button 'C',0,0
	visible = []

	          # ______ startläge
	assert 'A',a.title
	assert HIDDEN,a.state
	assert 0, visible.length

	a.click() # A_____
	assert VISIBLE, a.state
	assert 1, visible.length
	assert 'A',visible[0].title
	assert VISIBLE, visible[0].state
	
	a.click() # A_____ Klick på redan synlig, inget ska hända
	assert VISIBLE, a.state
	assert 1, visible.length
	assert 'A',visible[0].title
	assert VISIBLE, visible[0].state

	b.click()	#   ____ AA klickat
	assert DONE, a.state
	assert DONE, b.state
	assert 0, visible.length

	c.click() #   B___
	e.click() #   B_C_ BC klickat
	assert VISIBLE, c.state
	assert VISIBLE, e.state
	assert 2, visible.length
	assert 'B',visible[0].title
	assert 'C',visible[1].title

	d.click() #   _B__
	assert HIDDEN, c.state
	assert VISIBLE, d.state
	assert HIDDEN, e.state
	assert 1, visible.length
	assert 'B',visible[0].title

	c.click() #     __
	assert DONE, c.state
	assert DONE, d.state
	assert 0, visible.length

	e.click() #     C_
	assert VISIBLE, e.state
	assert 1, visible.length
	assert 'C',visible[0].title

	f.click() #     
	assert DONE, e.state
	assert DONE, f.state
	assert 0, visible.length

	print 'Ready!'