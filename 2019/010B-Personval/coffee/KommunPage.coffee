class KommunPage extends Page

	constructor : (x,y,w,h) ->
		super x,y,w,h
		@active = true
		@init()

	init : (index=0,letters='AM') ->
		N = 16
		COLS = 10 # 7
		@buttons  = [] 
		w = @w/COLS
		h = @h/(N+1)
		keys = _.keys dbKommun
		keys.sort (a,b) -> if dbKommun[a] < dbKommun[b] then -1 else 1
		@addButton new Button 'A-M',@x+0*w,@y,w-1,h-1, -> @page.init 0,'AM'
		@addButton new Button 'L-Ö',@x+1*w,@y,w-1,h-1, -> @page.init 1,'NÖ'
		i = 0
		for key in keys			
			namn = dbKommun[key]
			if letters[0] <= namn[0] <= letters[1]
				x = i%(COLS*N)//N * w
				y = (1 + i%N) * h
				@addButton new KommunButton key,@x+x,@y+y,w-1,h-1, -> 
					rensa()
					fetchKommun @key
				i++
		@selected = @buttons[index] 

	render : ->
