class PersonPage extends Page

	N = 16

	render : ->
		@bg 0	
		selected = pages.partier.selected
		pp = pages.personer
		if selected != null
			push()
			textAlign LEFT,CENTER
			textSize 0.4 * pp.h/(N+1)
			rlk = pages.rlk.selected.rlk
			namn = dbPartier[rlk][selected.partikod][PARTI_BETECKNING]
			s = "#{namn} (#{pp.buttons.length} av #{_.size pp.personer})"
			fc 1
			text s, pp.x, pp.y + pp.h/34
			pop()

	clickLetterButton : (rlk,button,partikod,letters,knrs) ->
		@personer = knrs
		N = PERSONS_PER_PAGE
		w = @w
		h = height/(PERSONS_PER_PAGE+1)
		@selected = button
		button.pageNo = (button.pageNo + 1) % button.pages
		@buttons = []
		print PERSON_NAMN
		knrs.sort (a,b) -> if dbPersoner[rlk][a][PERSON_NAMN] < dbPersoner[rlk][b][PERSON_NAMN] then -1 else 1
		j = 0
		for knr in knrs
			person = dbPersoner[rlk][knr]
			if person[PERSON_NAMN][0] in letters
				if j // N == button.pageNo
					x = 0
					y = h*(1 + j%N)
					do (knr) => @addButton new PersonButton rlk, partikod, knr, @x+x,@y+y,w-2,h-2, -> 
						@page.selected = @
						pages.rlk.clickPersonButton [partikod,knr]
				j++

	makePersons : (rlk, button, partikod, knrs) -> # knrs är en lista med knr
		@personer = knrs
		w = @w 
		h = height/(PERSONS_PER_PAGE+1)
		@selected = button 
		@buttons = []
		knrs.sort (a,b) -> if dbPersoner[rlk][a][PERSON_NAMN] < dbPersoner[rlk][b][PERSON_NAMN] then -1 else 1
		for knr,j in knrs
			x = 0 
			y = h*(1 + j%N)
			do (knr) => @addButton new PersonButton rlk, partikod, knr, @x+x,@y+y,w-2,h-2, -> 
				@page.selected = @
				pages.rlk.clickPersonButton [partikod,knr]

class PersonButton extends Button

	constructor : (@rlk, @partikod, knr, x,y,w,h,click = ->) ->
		super knr,x,y,w,h,click
		@knr = knr 
		person = dbPersoner[@rlk][knr]
		@title0 = person[PERSON_NAMN]
		@title1 = person[PERSON_UPPGIFT]
		if @title1 == '' then @title1 = "#{{M:'Man', K:'Kvinna'}[person[1]]} #{person[0]} år" 

	draw : ->
		fc 0.5
		rect @x,@y,@w,@h

		textAlign LEFT,CENTER
		textSize 1 * @ts
		fc 1
		text @title0,@x+2,@y+2+0.3*@h

		textAlign RIGHT,CENTER
		textSize 0.6 * @ts
		fc 0.9
		text @title1,@x+@w-2,@y+3+0.75*@h
