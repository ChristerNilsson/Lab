dialogues = []

calcr1r2 = (n,w,h) ->
	s = Math.min w,h
	r2 = s/7
	r1 = s/3
	if n > 6 then r2 *= 7/n
	[Math.round(r1),Math.round(r2)]
assert [200,86], calcr1r2 4,600,800
assert [200,75], calcr1r2 8,600,800

class Dialogue 

	constructor : (@x = width/2, @y = height/2) -> 
		@col = '#ff06'
		@buttons = []
		dialogues.push @

	add : (prompt,event) -> @buttons.push new Button @,prompt,event

	clock : (title= ' ', @backPop=false, turn=0) ->
		n = @buttons.length
		[r1,r2] = calcr1r2 n,width,height
		for button,i in @buttons
			v = i*360/n + turn - 90
			button.x = r1*cos v
			button.y = r1*sin v
			button.r = r2
		button = new Button @, title, -> 
			if @dlg.backPop then dialogues.pop() else dialogues.clear()
		button.x = 0
		button.y = 0
		button.r = r2
		@buttons.push button
		chars = _.max (button.title.length for button in @buttons)
		@textSize = if chars == 1 then 0.75*r2 else 2.5*r2/chars

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
				do (item) => @buttons.push new RectButton @, item, x,y,w,h, -> click @arr
		@buttons.push new RectButton @, ['Prev'], 0*w/3,h*n, w/3,h, -> @dlg.update -1 
		@buttons.push new RectButton @, ['Cancel'], 1*w/3,h*n, w/3,h, -> 
			if @dlg.backPop then dialogues.pop() else dialogues.clear()
		@buttons.push new RectButton @, ['Next'], 2*w/3,h*n, w/3,h, -> @dlg.update +1 

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
	constructor : (@dlg, @title, @event = -> print @txt) -> @active = true 
	info : (@title,@event) -> @active = true
	show : ->
		if @active then fill @dlg.col else fill "#fff8"
		stroke 0
		ellipse @x,@y,2*@r,2*@r
		push()
		if @active then fill 0 else fill "#888"
		noStroke()
		textAlign CENTER,CENTER
		textSize @dlg.textSize
		arr = @title.split ' '
		if arr.length == 1 
			text arr[0], @x,@y
		else 
			text arr[0], @x,@y-0.3*@r
			text arr[1], @x,@y+0.3*@r
		pop()

	inside : (mx,my) ->  @r > dist mx, my, @dlg.x + @x, @dlg.y + @y 
	execute : -> 
		dump.store "Button #{@title} #{@active}"
		if @active then @event()

class RectButton 
	constructor : (@dlg, @arr, @x, @y, @w, @h, @event = -> print @item) -> @active = true 
	info : (@arr,@event) -> @active = true
	show : ->
		col = '#ff0'

		if @active then fill col else fill "#fff8"
		stroke 0
		rect @x,@y,@w,@h
		push()
		if @active then fill 0 else fill "#888"
		noStroke()
		textSize @dlg.textSize
		if @arr.length == 1
			textAlign CENTER,CENTER
			text @arr[0], @x+@w/2,@y+@h/2			
		if @arr.length == 2
			textAlign LEFT,CENTER
			text @arr[0], @x+10,@y+@h/2
			textAlign RIGHT,CENTER
			text @arr[1], @x+@w-10,@y+@h/2
		if @arr.length == 3
			textAlign LEFT,CENTER
			text @arr[0], @x+10,@y+@h/2
			textAlign CENTER,CENTER
			text @arr[1], @x+@w/2,@y+@h/2			
			textAlign RIGHT,CENTER
			text @arr[2], @x+@w-10,@y+@h/2
		else
		pop()

	inside : (mx,my) ->  @x < mx < @x+@w and @y < my < @y+@h
	execute : -> if @active then @event()

class MenuButton
	constructor : ->
		@d = (height+width)/2/12/7
		@w = 7*@d
		@h = 7*@d
		@y = height-@h-@d
		@x = @d
	draw : ->
		fill "#fff8"
		sc 0
		sw 1
		rect @x,@y,@w,@h
		fill "#0008"
		rect @x+@d,@y+1*@d,@w-2*@d,@d
		rect @x+@d,@y+3*@d,@w-2*@d,@d
		rect @x+@d,@y+5*@d,@w-2*@d,@d
	inside : (mx,my) -> @x < mx < @x+@w and @y < my < @y+@h
	click : -> if dialogues.length == 0 then menu1() # else dialogues.clear()
