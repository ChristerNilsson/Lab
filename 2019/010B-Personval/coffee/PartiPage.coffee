class PartiPage extends Page
	render : ->
		if @selected != null
			push()
			textAlign LEFT,CENTER
			textSize 0.4 * pages.personer.h/17
			rkl = pages.typ.selected.typ
			namn = dbPartier[rkl][@selected.partikod][1]
			s = "#{namn} (#{pages.personer.buttons.length} av #{_.size pages.personer.personer})"
			text s, pages.personer.x, pages.personer.y + pages.personer.h/34
			pop()

	select : (rkl,partier) ->
		N = 16
		w = @w/2
		h = @h/(N+1)
		partikoder = _.keys partier
		partikoder.sort (a,b) -> _.size(partier[b]) - _.size(partier[a])
		@buttons = []

		pages.partier.clear()
		pages.letters.clear()
		pages.personer.clear()

		for partikod,i in partikoder
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			do (partikod) => @addButton new PartiButton rkl,partikod,x,y,w-2,h-2, -> 
				@page.selected = @
				if PERSONS_PER_PAGE < _.size partier[partikod]
					pages.letters.makeLetters rkl, @, partikod, partier[partikod]
					pages.personer.buttons = []
				else
					pages.letters.buttons = []
					pages.personer.makePersons rkl, @, partikod, partier[partikod]
				pages.typ.clickPartiButton @	
				pages.personer.personer = partier[partikod]			

