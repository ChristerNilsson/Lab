class PartiPage extends Page
	N = 16
	
	render : ->
		@bg 0

	select : (rlk,partier) ->
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
			print partikod
			do (partikod) => @addButton new PartiButton rlk,partikod,x,y,w-2,h-2, -> 
				@page.selected = @
				if PERSONS_PER_PAGE < _.size partier[partikod]
					pages.letters.makeLetters rlk, @, partikod, partier[partikod]
					pages.personer.buttons = []
				else
					pages.letters.buttons = []
					pages.personer.makePersons rlk, @, partikod, partier[partikod]
				pages.rlk.clickPartiButton @	
				pages.personer.personer = partier[partikod]			

class PartiButton extends Button 
	constructor : (@rlk,@partikod,x,y,w,h,click = ->) ->
		super '', x,y,w,h,click
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		partinamn = dbPartier[@rlk][@partikod][0]
		if partinamn == '' then partinamn = dbPartier[@rlk][@partikod][1]

		text partinamn,@x+@w/2,@y+@h/2
