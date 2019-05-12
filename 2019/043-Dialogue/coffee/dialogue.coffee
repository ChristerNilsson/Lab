dialogues = []

class Dialogue 

	constructor : (@number,@x,@y,@textSize) -> 
		@col = '#ff08'
		@buttons = []
		dialogues.push @

	add : (button) -> 
		button.dlg = @
		@buttons.push button	

	clock : (title,n,r1,r2, @backPop=true, turn=0) ->
		for i in range n
			v = i*360/n-turn
			@add new Button '', r1*cos(v), r1*sin(v), r2, -> 
		@add new Button title,0,0,r2, -> 
			if @dlg.backPop then dialogues.pop() else dialogues.clear()

	update : (delta) -> # -1 eller +1
		if 0 <= @pageStart + delta * @pageSize < @lst.length
			@pageStart += delta * @pageSize
			for i in range @pageSize
				if @pageStart + i < @lst.length
					@buttons[i].arr = @lst[@pageStart + i] 
				else
					@buttons[i].arr = []

	list : (@lst, @pageSize=10, @backPop=true, click = (arr) -> print arr[0]) ->
		@pageStart = 0
		n = @pageSize
		x = 0
		w = width
		h = height/(@pageSize+1)
		@buttons.clear()
		for i in range @pageStart,@pageStart + n
			if i < @lst.length
				item = @lst[i]
				y = i*h
				do (item) => @add new RectButton item, x,y,w,h, -> click @arr
		@add new RectButton [-1,'Prev'],   0*w/3,h*n, w/3,h, -> @dlg.update -1 
		@add new RectButton [-1,'Cancel'], 1*w/3,h*n, w/3,h, -> 
			if @dlg.backPop then dialogues.pop() else dialogues.clear()
		@add new RectButton [-1,'Next'],   2*w/3,h*n, w/3,h, -> @dlg.update +1 

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
	constructor : (@txt, @x, @y, @r, @event = -> print @txt) -> @active = true 
	info : (@txt,@active,@event) ->
	show : ->
		if @active then fill @dlg.col else fill "#fff8"
		stroke 0
		ellipse @x,@y,2*@r,2*@r
		push()
		if @active then fill 0 else fill "#888"
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

	inside : (mx,my) ->  @r > dist mx, my, @dlg.x + @x, @dlg.y + @y 
	execute : -> if @active then @event()

class RectButton 
	constructor : (@arr, @x, @y, @w, @h, @event = -> print @item) -> @active = true 
	info : (@arr,@active,@event) ->
	show : ->
		if @active then fill @dlg.col else fill "#fff8"
		stroke 0
		rect @x,@y,@w,@h
		push()
		if @active then fill 0 else fill "#888"
		noStroke()
		textSize @dlg.textSize
		if @arr.length == 1+1
			textAlign CENTER,CENTER
			text @arr[1], @x+@w/2,@y+@h/2			
		if @arr.length == 1+2
			textAlign LEFT,CENTER
			text @arr[1], @x+10,@y+@h/2
			textAlign RIGHT,CENTER
			text @arr[2], @x+@w-10,@y+@h/2
		if @arr.length == 1+3
			textAlign LEFT,CENTER
			text @arr[1], @x+10,@y+@h/2
			textAlign CENTER,CENTER
			text @arr[2], @x+@w/2,@y+@h/2			
			textAlign RIGHT,CENTER
			text @arr[3], @x+@w-10,@y+@h/2
		else
		pop()

	inside : (mx,my) ->  @x < mx < @x+@w and @y < my < @y+@h
	execute : -> if @active then @event()
