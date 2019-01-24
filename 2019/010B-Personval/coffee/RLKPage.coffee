class RLKPage extends Page # Riksdag, Landsting, Kommun

	constructor : (x,y,w,h,cols=1) ->
		super x,y,w,h,cols
		@sbuttons = []
		@start = new Date().getTime()
		@qr = '0000000000'

		h = height/51
		@yoff = [@y+0,@y+16*h,@y+32*h,@y+48*h]

		@selectedPersons = {R:[], L:[], K:[]}

		@addButton new RLKButton 'R', 'Riksdag',@x,@yoff[0],@w-0,3*h-3, -> 
			pages.partier.select 'R',dbTree.R
			@page.selected = @

		@addButton new RLKButton 'L', dbName.L, @x,@yoff[1],@w-0,3*h-3, ->
			pages.partier.select 'L',dbTree.L
			@page.selected = @

		@addButton new RLKButton 'K', dbName.K, @x,@yoff[2],@w-0,3*h-3, ->
			pages.partier.select 'K',dbTree.K
			@page.selected = @

		@addButton new Button 'Utskrift', @x,@yoff[3],@w/3-2,3*h-3, ->
			pageStack.push pages.utskrift
			pages.utskrift.stopMeasuringTime()

			@page.qr = @page.getQR()
			qrcode = new QRCode document.getElementById("qrcode"),
				text: @page.qr
				width: 0.25*width
				height: 0.25*width
				colorDark : "#000000"
				colorLight : "#ffffff"
				correctLevel : QRCode.CorrectLevel.L # Low Medium Q High

		@addButton new Button 'Rensa', @x+@w/3,@yoff[3],@w/3-2,3*h-3, ->
			rensa()

		@addButton new Button 'Byt kommun', @x+2*@w/3,@yoff[3],@w/3-0,3*h-3, -> 
			pageStack.push pages.kommun

	addsButton : (button) -> 
		button.page = @
		@sbuttons.push button

	getQR : ->
		s = kommunkod 
		slump = int random 1000000
		s += slump.toString().padStart 6,0 # to increase probability of uniqueness 
		for rlk of @selectedPersons
			persons = @selectedPersons[rlk]
			for i in range VOTES
				if i < persons.length 
					[partikod,knr] = persons[i]
					if knr == 0 
						s += '99' + partikod.padStart 4,'0'
					else
						s += knr.padStart 6,'0'
				else
					s += '000000'
		assert s.length,4+6+15*6
		s

	render : ->
		@bg 0
		if @selected != null
			push()
			fc 1
			textAlign LEFT,CENTER
			textSize 0.4 * pages.personer.h/17
			sc()
			[x,y] = [pages.partier.x, pages.partier.y+pages.partier.h/34]
			if @selected.rlk == 'R' then text 'Riksdag',x,y
			if @selected.rlk == 'L' then text dbName.L, x,y
			if @selected.rlk == 'K' then text dbName.K, x,y
			pop()
		@showSelectedPersons()

	clickDelete : (rlk,index) ->
		@selectedPersons[rlk].splice index,1 	
		@createSelectButtons()

	clickSwap : (rlk,index) ->
		arr = @selectedPersons[rlk]
		[arr[index],arr[index-1]] = [arr[index-1],arr[index]]
		@createSelectButtons()

	createSelectButtons : ->
		@sbuttons = []
		w = @w
		dw = 0.02 * width
		dh = 0.025 * height
		h = height/51

		for rlk,persons of @selectedPersons
			index = "RLK".indexOf rlk
			for person,i in persons
				x1 = @x + dw
				x2 = @x + 0.93 * @w
				y = @yoff[index] + 4.7*h + 13*h/5*i
				y1 = y - 2.3 * h
				y2 = y - 0.9 * h
				do (rlk,i) =>
					if i>0 then @addsButton new Button 'byt',x1, y1,dw,dh, => @clickSwap   rlk,i
					@addsButton             new Button ' x ',x2, y2,dw,dh, => @clickDelete rlk,i

	clickPersonButton : (person) -> # av typen [partikod,knr]
		persons = @selectedPersons[@selected.rlk]
		for pair,i in persons 
			if pair[0] == person[0] # Finns partiet redan? I så fall: ersätt denna person med den nya.
				persons[i][1] = person[1]
				return 
		if persons.length < VOTES
			persons.push person
			@createSelectButtons()

	clickPartiButton : (button) ->
		persons = @selectedPersons[@selected.rlk]
		for pair,i in persons 
			[partikod,knr] = pair
			if partikod == button.partikod then return 
		if persons.length < VOTES
			persons.push [button.partikod, 0]
			@createSelectButtons()

	sample : (hash,n) -> _.object ([key,hash[key]] for key in _.sample _.keys(hash),n)

	slumpa : ->
		for rlk,partier of dbTree
			@selectedPersons[rlk] = []
			parties = @sample partier,5
			for partikod,knrs of parties
				if random() < 0.2 # Vote for a party
					pair = [partikod,0]
				else # Vote for a person
					knr = _.sample knrs
					pair = [partikod,knr]
				@selectedPersons[rlk].push pair
	
	showSelectedPersons : ->
		push()
		textAlign LEFT,CENTER
		textSize 0.025 * height
		for rlk,i in 'RLK'
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

			for pair,j in @selectedPersons[rlk]
				y = y0 + 4.5*h + 13*h/5*j
				[partikod,knr] = pair
				parti = dbPartier[rlk][partikod][0]
				namn = if knr == 0 then dbPartier[rlk][partikod][1] else dbPersoner[rlk][knr][2]
				text "#{j+1} #{parti} - #{namn}",@x+10,y
		pop()

		for button in @sbuttons
			button.draw()

	mousePressed : ->
		for button in @sbuttons
			if button.inside()
				button.click()
				return true
		super()

class RLKButton extends Button
	constructor : (@rlk, title,x,y,w,h,click = ->) ->
		super title, x,y,w,h,click
