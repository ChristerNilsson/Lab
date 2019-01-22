class PersonPage extends Page

	render : ->

	clickLetterButton : (rkl,button,partikod,letters,knrs) ->
		@personer = knrs
		N = PERSONS_PER_PAGE
		w = 0.36 * width
		h = height/(PERSONS_PER_PAGE+2)
		@selected = button
		button.pageNo = (button.pageNo + 1) % button.pages
		@buttons = []
		knrs.sort (a,b) -> if dbPersoner[rkl][a][2] < dbPersoner[rkl][b][2] then -1 else 1
		j = 0
		for knr in knrs
			person = dbPersoner[rkl][knr]
			if person[2][0] in letters
				if j // N == button.pageNo
					x = j//(N//2) * w/2
					x = x % w
					y = 2*h*(1+j%(N//2))
					do (knr) => @addButton new PersonButton rkl, partikod, knr, @x+x,@y+y,w/2-2,2*h-2, -> 
						@page.selected = @
						pages.typ.clickPersonButton [partikod,knr]
				j++

	makePersons : (rkl, button, partikod, knrs) -> # personer är en lista med knr
		@personer = knrs
		N = 16
		w = 0.36 * width 
		h = height/(PERSONS_PER_PAGE+2)
		@selected = button 
		@buttons = []

		knrs.sort (a,b) -> if dbPersoner[rkl][a][2] < dbPersoner[rkl][b][2] then -1 else 1
		for knr,j in knrs
			#person = dbPersoner[rkl][knr] # [age,sex,name,uppgift]
			x = j//N * w/2
			x = x % w
			y = 2*h*(1 + j%N)
			do (partikod,knr) => @addButton new PersonButton rkl, partikod, knr, @x+x,@y+y,w/2-2,2*h-2, -> 
				@page.selected = @
				pages.typ.clickPersonButton [@partikod,@knr]

