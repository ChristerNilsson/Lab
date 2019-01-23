class LetterPage extends Page

	makeLetters : (rkl, button, partikod, personer) ->
		N = 16
		h = @h/(N+1)
		w = @w/2
		@selected = button 
		@buttons = []

		i = 0
		words = (dbPersoner[rkl][key][2] for key in personer)
		for letters,n of gruppera words,N+N
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) => @addButton new LetterButton title,x,y,w-2,h-2,n, -> 
				@page.selected = @
				pages.personer.clickLetterButton rkl, @, partikod, letters, personer
			i++
