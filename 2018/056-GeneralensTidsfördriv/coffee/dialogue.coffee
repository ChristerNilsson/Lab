dialogues = []

class Dialogue 
	constructor : (@x,@y,@textSize) -> 
		@buttons = []
		dialogues.push @
	add : (button) -> 
		button.dlg = @
		@buttons.push button	
	clock : (n,r1,r2,turn=0) ->
		for i in range n
			v = i*360/n-turn
			@add new Button '', r1*cos(v), r1*sin(v), r2, -> 
		@add new Button 'Back',0,0,r2, -> dialogues.pop()
	show : ->
		fill 255,128
		push()
		translate @x,@y
		textSize @textSize
		for button in @buttons
			button.show @
		pop()
	execute : (mx,my) ->
		for button in @buttons
			if button.inside mx,my,@
				button.execute()
				return true
		false 

class Button 
	constructor : (@txt, @x, @y, @r, @event = -> print @txt) ->
	info : (@txt,@event) ->
	show : ->
		fill 256-16
		stroke 0
		ellipse @x,@y,2*@r,2*@r
		push()
		fill 128
		noStroke()
		textAlign CENTER,CENTER
		textSize @dlg.textSize
		if 'string' == typeof @txt 
			text @txt, @x,@y
		else 
			text @txt[0], @x,@y-0.4*@r
			text @txt[1], @x,@y+0.4*@r

		pop()
	inside : (mx,my) -> @r > dist mx, my, @dlg.x + @x, @dlg.y + @y
	execute : -> @event()
