class KommunPage extends Page

	N = 10
	COLS = 5

	constructor : (x,y,w,h) ->
		super x,y,w,h
		@grupper = gruppera _.values(dbKommun), N*COLS
		@init()

	init : (index=0) ->
		@buttons  = [] 
		ww = @w/(COLS+1)
		w = ww#/2
		h = @h/N
		keys = _.keys dbKommun
		keys.sort (a,b) -> if dbKommun[a] < dbKommun[b] then -1 else 1

		for key,i in _.keys @grupper
			first = key[0]
			last  = _.last key
			if i==index then letters = "#{first}#{last}"
			title = if first==last then first else title = "#{first}-#{last}"
			do (i) => @addButton new Button title,@x,@y+i*h,w-1,h-1, -> @page.init i

		@addButton new Button 'Avbryt',@x,@y+(N-1)*h,w-1,h-1, -> pageStack.pop()

		i = 0
		for key in keys			
			namn = dbKommun[key]
			if letters[0] <= namn[0] <= letters[1]
				x = w+i%(COLS*N)//N * ww
				y = (i%N) * h
				@addButton new KommunButton key,@x+x,@y+y,ww-1,h-1, -> 
					rensa()
					fetchKommun @key
					pageStack.pop()
				i++
		@selected = @buttons[index] 

	render : ->
		@bg 0
		push()
		sc 1,1,1
		sw 1
		rect @x,@y,@w,@h
		pop()

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
