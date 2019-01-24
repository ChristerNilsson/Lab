class PersonPage extends Page

	N = 16

	render : ->
		@bg 0	
		selected = pages.partier.selected
		pp = pages.personer
		if selected != null
			push()
			textAlign LEFT,CENTER
			textSize 0.4 * pp.h/17
			rlk = pages.rlk.selected.rlk
			namn = dbPartier[rlk][selected.partikod][1]
			s = "#{namn} (#{pp.buttons.length} av #{_.size pp.personer})"
			fc 1
			text s, pp.x, pp.y + pp.h/34
			pop()

	clickLetterButton : (rlk,button,partikod,letters,knrs) ->
		@personer = knrs
		N = PERSONS_PER_PAGE
		w = 0.72 * width
		h = height/(PERSONS_PER_PAGE+1)
		@selected = button
		button.pageNo = (button.pageNo + 1) % button.pages
		@buttons = []
		knrs.sort (a,b) -> if dbPersoner[rlk][a][2] < dbPersoner[rlk][b][2] then -1 else 1
		j = 0
		for knr in knrs
			person = dbPersoner[rlk][knr]
			if person[2][0] in letters
				if j // N == button.pageNo
					x = j//N * w
					x = x % w
					y = h*(1 + j%N)
					do (knr) => @addButton new PersonButton rlk, partikod, knr, @x+x,@y+y,w/2-2,h-2, -> 
						@page.selected = @
						pages.rlk.clickPersonButton [partikod,knr]
				j++

	makePersons : (rlk, button, partikod, knrs) -> # personer är en lista med knr
		@personer = knrs
		w = 0.72 * width 
		h = height/(PERSONS_PER_PAGE+1)
		@selected = button 
		@buttons = []
		knrs.sort (a,b) -> if dbPersoner[rlk][a][2] < dbPersoner[rlk][b][2] then -1 else 1
		for knr,j in knrs
			x = j//N * w
			x = x % w
			y = h*(1 + j%N)
			do (knr) => @addButton new PersonButton rlk, partikod, knr, @x+x,@y+y,w/2-2,h-2, -> 
				@page.selected = @
				pages.rlk.clickPersonButton [partikod,knr]

class PersonButton extends Button

	constructor : (@rlk, @partikod, knr, x,y,w,h,click = ->) ->
		super knr,x,y,w,h,click
		@knr = knr 
		person = dbPersoner[@rlk][knr]
		@title0 = person[2]
		@title1 = person[3]
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
