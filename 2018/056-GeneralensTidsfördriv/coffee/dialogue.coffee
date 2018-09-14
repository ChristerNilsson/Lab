dialogues = []

class Dialogue 
	constructor : (@number,@x,@y,@textSize,@col='#ff08') -> 
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
		if @txt == '' 
			noFill()
		else	
			fill @dlg.col
		stroke 0
		ellipse @x,@y,2*@r,2*@r
		push()
		fill 0
		noStroke()
		textAlign CENTER,CENTER
		textSize @dlg.textSize
		arr = @txt.split ' '
		if arr.length == 1 
			text arr[0], @x,@y
		else 
			text arr[0], @x,@y-0.3*@r
			text arr[1], @x,@y+0.3*@r
		pop()

	inside : (mx,my) -> if @txt == '' then false else @r > dist mx, my, @dlg.x + @x, @dlg.y + @y 
	execute : -> @event()
