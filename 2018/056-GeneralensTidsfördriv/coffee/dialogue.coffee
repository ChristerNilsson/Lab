dialogues = []

class Dialogue 
	constructor : (@x,@y,@textSize,@helpText='') -> 
		@buttons = []
		dialogues.push @
	add : (button) -> 
		button.dlg = @
		@buttons.push button	
	clock : (title,n,r1,r2,turn=0) ->
		for i in range n
			v = i*360/n-turn
			@add new Button '', r1*cos(v), r1*sin(v), r2, -> 
		@add new Button title,0,0,r2, -> dialogues.pop()
	show : ->
		# if @helpText != ''
		# 	noStroke()
		# 	textAlign LEFT,TOP
		# 	textSize h/10
		# 	for txt,i in @helpText.split '|'
		# 		txt = txt.split ':'
		# 		fill 0
		# 		text txt[0],0.05*h,(i+1)*h/10-0.05*h
		# 		fill 255,255,0
		# 		text txt[1],0.5*h,(i+1)*h/10-0.05*h
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
		fill 255,255,0,128
		stroke 0
		ellipse @x,@y,2*@r,2*@r
		push()
		fill 0
		noStroke()
		textAlign CENTER,CENTER
		textSize @dlg.textSize
		if 'string' == typeof @txt 
			text @txt, @x,@y
		else 
			text @txt[0], @x,@y-0.3*@r
			text @txt[1], @x,@y+0.3*@r
		pop()

	inside : (mx,my) -> @r > dist mx, my, @dlg.x + @x, @dlg.y + @y
	execute : -> @event()
