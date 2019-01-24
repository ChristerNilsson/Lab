class KommunPage extends Page

	N = 16
	COLS = 10

	constructor : (x,y,w,h) ->
		super x,y,w,h
		#@active = true
		@grupper = gruppera _.values(dbKommun), N*COLS
		@init()

	init : (index=0) ->
		@buttons  = [] 
		w = @w/COLS
		h = @h/(N+1)
		keys = _.keys dbKommun
		keys.sort (a,b) -> if dbKommun[a] < dbKommun[b] then -1 else 1

		for key,i in _.keys @grupper
			first = key[0]
			last  = _.last key
			if i==index then letters = "#{first}#{last}"
			do (i) => @addButton new Button "#{first}-#{last}",@x+i*w,@y,w-1,h-1, -> @page.init i

		i = 0
		for key in keys			
			namn = dbKommun[key]
			if letters[0] <= namn[0] <= letters[1]
				x = i%(COLS*N)//N * w
				y = (1 + i%N) * h
				@addButton new KommunButton key,@x+x,@y+y,w-1,h-1, -> 
					rensa()
					fetchKommun @key
					pageStack.pop()
				i++
		@selected = @buttons[index] 

	render : ->
		bg 0

class KommunButton extends Button 

	constructor : (key, x,y,w,h,click = ->) ->
		super dbKommun[key],x,y,w,h,click
		@key = key 

	draw : ->
		fc 0.5
		push()
		sc()
		rect @x,@y,@w,@h
		pop()
		textSize 0.65 * @ts
		textAlign LEFT,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+0.025*@w,@y+@h/2
