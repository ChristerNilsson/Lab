class TypPage extends Page

	constructor : (x,y,w,h,cols=1) ->
		super x,y,w,h,cols
		@sbuttons = []
		@start = new Date().getTime()
		@qr= '0000000000'

		h = height/51
		@yoff = [@y+0,@y+16*h,@y+32*h,@y+48*h]

		@selectedPersons = {R:[], L:[], K:[]}

		@addButton new TypButton 'R', 'Riksdag',@x,@yoff[0],@w-0,3*h-3, -> 
			pages.partier.select 'R',dbTree.R
			@page.selected = @

		@addButton new TypButton 'L', dbName.L, @x,@yoff[1],@w-0,3*h-3, ->
			pages.partier.select 'L',dbTree.L
			@page.selected = @

		@addButton new TypButton 'K', dbName.K, @x,@yoff[2],@w-0,3*h-3, ->
			pages.partier.select 'K',dbTree.K
			@page.selected = @

		@addButton new Button 'Utskrift', @x,@yoff[3],@w/3-2,3*h-3, ->
			pages.utskrift.active = true
			pages.utskrift.stopMeasuringTime()

			@page.qr = @page.getQR()
			qrcode = new QRCode document.getElementById("qrcode"),
				text: @page.qr
				width: 0.25*width
				height: 0.25*width
				colorDark : "#000000"
				colorLight : "#ffffff"
				correctLevel : QRCode.CorrectLevel.L # Low Medium Q High

		@addButton new Button 'Rensa', @x+@w/3,@yoff[3],@w/3-2,3*h-3, -> rensa()

		@addButton new Button 'Byt kommun', @x+2*@w/3,@yoff[3],@w/3-0,3*h-3, -> 
			for page in pages
				page.active = false 
			pages.kommun.active = true

	addsButton : (button) -> 
		button.page = @
		@sbuttons.push button

	getQR : ->
		s = kommunkod 
		slump = int random 1000000
		s += slump.toString().padStart 6,0 # to increase probability of uniqueness 
		for typ of @selectedPersons
			persons = @selectedPersons[typ]
			for i in range VOTES
				if i < persons.length 
					[partikod,knr] = persons[i]
					if knr == 0 
						s += '99' + partikod.padStart 4,'0'
					else
						s += knr.padStart 6,'0'
				else
					s += '000000'
		assert s.length,4+6+15*6 # 100
		s

	render : ->
		if @selected != null
			push()
			textAlign LEFT,CENTER
			textSize 20
			sc()
			[x,y] = [pages.partier.x, pages.partier.y+pages.partier.h/34]
			if @selected.typ == 'R' then text 'Riksdag',x,y
			if @selected.typ == 'L' then text dbName.L, x,y
			if @selected.typ == 'K' then text dbName.K, x,y
			pop()
		@showSelectedPersons() # 750,100-20

	clickDelete : (typ,index) ->
		@selectedPersons[typ].splice index,1 	
		@createSelectButtons()

	clickSwap : (typ,index) ->
		arr = @selectedPersons[typ]
		[arr[index],arr[index-1]] = [arr[index-1],arr[index]]
		@createSelectButtons()

	createSelectButtons : ->
		@sbuttons = []
		w = @w
		dw = 0.02 * width
		dh = 0.025 * height
		h = height/51

		for typ,persons of @selectedPersons
			index = "RLK".indexOf typ
			for person,i in persons
				x1 = @x + dw
				x2 = @x + 0.93 * @w
				y = @yoff[index] + 4.7*h + 13*h/5*i
				y1 = y - 2.3 * h
				y2 = y - 0.9 * h
				do (typ,i) =>
					if i>0 then @addsButton new Button 'byt',x1, y1,dw,dh, => @clickSwap   typ,i
					@addsButton             new Button ' x ',x2, y2,dw,dh, => @clickDelete typ,i

	clickPersonButton : (person) -> # av typen [partikod,knr]
		persons = @selectedPersons[@selected.typ]
		# Finns partiet redan? I så fall: ersätt denna person med den nya.
		for pair,i in persons 
			if pair[0] == person[0]
				persons[i][1] = person[1]
				return 
		if persons.length < VOTES
			persons.push person
			@createSelectButtons()

	clickPartiButton : (button) ->
		persons = @selectedPersons[@selected.typ]
		for pair,i in persons 
			[partikod,knr] = pair
			if partikod == button.partikod then return 
		if persons.length < VOTES
			persons.push [button.partikod, 0]
			@createSelectButtons()

	sample : (hash,n) -> _.object ([key,hash[key]] for key in _.sample _.keys(hash),n)

	slumpa : ->
		for rkl,partier of dbTree
			@selectedPersons[rkl] = []
			parties = @sample partier,5
			for partikod,knrs of parties
				if random() < 0.2 # Vote for a party
					pair = [partikod,0]
				else # Vote for a person
					knr = _.sample knrs
					pair = [partikod,knr]
				@selectedPersons[rkl].push pair
	
	showSelectedPersons : ->
		push()
		textAlign LEFT,CENTER
		textSize 0.025 * height
		for typ,i in 'RLK'
			sc()
			sw 1 
			rectMode CORNER
			y0 = @yoff[i]
			if i == 0 then fc 1,1,0.5
			if i == 1 then fc 0.5,0.75,1
			if i == 2 then fc 1
			h = height/51
			rect @x, y0+3*h-1, @w, 13*h-1
			fc 0
			sc()
			sw 0

			for pair,j in @selectedPersons[typ]
				y = y0 + 4.5*h + 13*h/5*j
				[partikod,knr] = pair
				parti = dbPartier[typ][partikod][0]
				namn = if knr == 0 then dbPartier[typ][partikod][1] else dbPersoner[typ][knr][2]
				text "#{j+1} #{parti} - #{namn}",@x+10,y
		pop()

		for button in @sbuttons
			button.draw()

	mousePressed : ->
		for button in @sbuttons
			if button.inside mouseX,mouseY then button.click()
		super()

