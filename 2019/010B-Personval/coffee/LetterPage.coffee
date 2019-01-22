class LetterPage extends Page
	render : ->

	makeFreq : (rkl,personer) -> # personer är en lista
		res = {}
		names = (dbPersoner[rkl][key][2] for key in personer)
		names.sort()
		for name in names
			letter = name[0]
			res[letter] = if res[letter] == undefined then 1 else res[letter] + 1
		res

	makeLetters : (rkl, button, partikod, personer) ->
		N = 16
		h = @h/(N+1)
		w = @w/2
		@selected = button 
		@buttons = []

		i = 0
		for letters,n of gruppera @makeFreq rkl,personer
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) => @addButton new LetterButton title,x,y,w-2,h-2,n, -> 
				@page.selected = @
				pages.personer.clickLetterButton rkl, @, partikod, letters, personer
			i++

