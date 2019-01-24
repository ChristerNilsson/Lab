class PersonPage extends Page

	render : ->
		@bg 0	

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
						pages.rlk.clickPersonButton [partikod,knr]
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
				pages.rlk.clickPersonButton [@partikod,@knr]

class PersonButton extends Button
	constructor : (@rkl, @partikod, knr, x,y,w,h,click = ->) ->
		super knr,x,y,w,h,click
		@knr = knr 
		person = dbPersoner[@rkl][knr]
		@title0 = person[2]
		@title1 = person[3]
		if @title1 == '' then @title1 = "#{{M:'Man', K:'Kvinna'}[person[1]]} #{person[0]} år" 
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize @ts/2
		textAlign LEFT,CENTER
		fc 1
		text @title0,@x+2,@y+2+0.3*@h
		fc 0.75
		text @title1,@x+2,@y+2+0.7*@h
