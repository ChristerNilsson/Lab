class Button
	constructor : (@title, @x,@y,@w,@h,@click = ->) ->
		@ts = 0.6 * @h
	draw : ->
		fc 0.5
		push()
		sc()
		rect @x,@y,@w,@h
		pop()
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+@w/2,@y+@h/2
	inside : -> @x < mouseX < @x+@w and @y < mouseY < @y+@h
