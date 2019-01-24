class LetterPage extends Page

	render : ->
		@bg 0

	makeLetters : (rlk, button, partikod, personer) ->
		N = 16
		h = @h/(N+1)
		w = @w/2
		@selected = button 
		@buttons = []

		i = 0
		words = (dbPersoner[rlk][key][PERSON_NAMN] for key in personer)
		print gruppera words,N
		for letters,n of gruppera words,N
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) => @addButton new LetterButton title,x,y,w-2,h-2,n, -> 
				@page.selected = @
				pages.personer.clickLetterButton rlk, @, partikod, letters, personer
			i++

class LetterButton extends Button 

	constructor : (title,x,y,w,h,@antal,click) ->
		super title,x,y,w,h,click
		@pageNo = -1
		@pages = 1 + @antal // PERSONS_PER_PAGE
		if @antal % PERSONS_PER_PAGE == 0 then @pages--

	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize 0.8 * @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+@w/2,@y+@h/2
		push()
		@pageIndicator()
		pop()

	pageIndicator : ->
		if @pages <= 1 then return 
		r = 0.003 * height
		dx = (@w-2*r*@pages)/(@pages+1)
		for i in range @pages
			if i==@pageNo and @page.selected == @ then fc 1 else fc 0
			circle @x - r + (i+1)*(dx+2*r) , @y+0.85*@h, r
