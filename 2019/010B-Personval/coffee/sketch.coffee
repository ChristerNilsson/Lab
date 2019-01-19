# Beskrivning av kolumner i kandidaturer.js:
VALTYP = 0
VALOMRÅDESKOD = 1
VALOMRÅDESNAMN = 2
VALKRETSKOD = 3
VALKRETSNAMN = 4
PARTIBETECKNING = 5
PARTIFÖRKORTNING = 6
PARTIKOD = 7
VALSEDELSSTATUS = 8
LISTNUMMER = 9
ORDNING = 10
ANMKAND = 11
ANMDELTAGANDE = 12
SAMTYCKE = 13
FÖRKLARING = 14
KANDIDATNUMMER = 15
NAMN = 16
ÅLDER_PÅ_VALDAGEN = 17
KÖN = 18
FOLKBOKFÖRINGSORT = 19
VALSEDELSUPPGIFT = 20
ANT_BEST_VALS = 21
VALBAR_PÅ_VALDAGEN = 22
GILTIG = 23

PERSONS_PER_PAGE = 32
GAP = 2

VOTES = 5

kommunkod = null
länskod = null

tree = {}

#qrcode = null
qr = null

dictionary = {} 
	# S -> Socialdemokraterna
	# 01 -> Stockholms läns landsting
	# 0180 -> Stockholm

pages = {}
utskrift = null

gruppera = (letters,n=32) ->
	res = {}
	group = ''
	count = 0
	for letter,m of letters
		if count + m <= n
			group += letter
			count += m
		else
			if count > 0 then res[group] = count
			group = letter
			count = m
	if count > 0 then res[group] = count
	res
assert {AB:25,C:14,D:57}, gruppera {A:12, B:13, C:14, D:57}
assert {ABDEF:28, GH:25}, gruppera {A:2, B:1, D:3,E:10,F:12,G:13,H:12}
assert {ABDEF:28, NO:32}, gruppera {A:2, B:1, D:3,E:10,F:12,N:20,O:12}

class Page
	constructor : (@x,@y,@w,@h,@cols=1) ->
		@selected = null # anger vilken knapp man klickat på
		@buttons  = [] 
		@active = true

	clear : ->
		@selected = null
		@buttons = []

	addButton : (button) -> 
		button.page = @
		@buttons.push button

	draw : ->
		if @active 
			@render()
			for button in @buttons
				button.draw()

	mousePressed : ->
		if @active 
			for button in @buttons
				if button.inside mouseX,mouseY then button.click()

class PartiPage extends Page
	render : ->
		if @selected != null
			push()
			textAlign CENTER,CENTER
			textSize 20 # 0.5 * pages.personer.h/17
			text dictionary[@selected.title][0], pages.personer.x + pages.personer.w/2, pages.personer.y + pages.personer.h/34
			pop()

	select : (partier) ->
		N = 16
		w = @w/2
		h = @h/(N+1)
		keys = _.keys partier
		keys.sort (a,b) -> _.size(partier[b]) - _.size(partier[a])
		@buttons = []

		pages.partier.clear()
		pages.letters.clear()
		pages.personer.clear()

		for key,i in keys
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			do (key) => @addButton new PartiButton key,x,y,w-2,h-2, -> 
				@page.selected = @
				if PERSONS_PER_PAGE < _.size partier[key]
					pages.letters.makeLetters @, partier[key]
					pages.personer.buttons = []
				else
					pages.letters.buttons = []
					pages.personer.makePersons @, partier[key]
				pages.typ.clickPartiButton @				

class LetterPage extends Page
	render : ->

	makeFreq : (personer) ->
		res = {}
		keys = (person[NAMN] for key,person of personer)
		keys.sort()
		for key in keys
			letter = key[0]
			res[letter] = if res[letter] == undefined then 1 else res[letter] + 1
		res

	makeLetters : (button, personer) ->
		N = 16
		h = @h/(N+1)
		w = @w/2
		@selected = button 
		@buttons = []

		print _.size personer

		i = 0
		for letters,n of gruppera @makeFreq personer
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) => @addButton new LetterButton title,x,y,w-2,h-2,n, -> 
				@page.selected = @
				pages.personer.clickLetterButton @, letters, personer
			i++

class PersonPage extends Page

	render : ->

	clickLetterButton : (button,letters,personer) ->
		N = PERSONS_PER_PAGE
		w = 0.3 * width
		h = height/(PERSONS_PER_PAGE+2)
		@selected = button
		button.pageNo = (button.pageNo + 1) % button.pages
		@buttons = []
		keys = _.keys personer 
		keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
		j = 0
		for key in keys
			person = personer[key]
			if person[NAMN][0] in letters
				if j // N == button.pageNo
					x = @x
					y = @y + h*(2+j%N)
					#print w,h
					do (person) => @addButton new PersonButton person,x,y,w-2,h-2, -> 
						@page.selected = @
						pages.typ.clickPersonButton person
				j++

	makePersons : (button, personer) ->
		N = 16
		w = 0.3 * width 
		h = height/(PERSONS_PER_PAGE+2)
		@selected = button 
		@buttons = []

		keys = _.keys personer
		keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
		for key,j in keys
			person = personer[key]
			x = @x 
			y = @y + h*(2 + j%PERSONS_PER_PAGE)
			#print w,h

			do (person) => @addButton new PersonButton person,x,y,w-2,h-2, -> 
				@page.selected = @
				pages.typ.clickPersonButton person

class TypPage extends Page

	constructor : (x,y,w,h,cols=1) ->
		super x,y,w,h,cols
		@sbuttons = []

		h = height/51
		@yoff = [@y+0,@y+16*h,@y+32*h,@y+48*h]
		#print 'yoff',@yoff

		@selectedPersons = {R:[], L:[], K:[]}
		@addButton new TypButton 'R', 'Riksdag',             @x,@yoff[0],@w-2,3*h-2, -> 
			pages.partier.select tree['R']
			@page.selected = @
		@addButton new TypButton 'L', dictionary[länskod],   @x,@yoff[1],@w-2,3*h-2, ->
			pages.partier.select tree['L']
			@page.selected = @
		@addButton new TypButton 'K', dictionary[kommunkod], @x,@yoff[2],@w-2,3*h-2, ->
			pages.partier.select tree['K']
			@page.selected = @
		@addButton new Button 'Utskrift',                    @x,@yoff[3],@w/2-2,3*h-2, ->

			#resizeCanvas windowWidth, windowHeight-256			
			pages.utskrift.active = true

			qr = @page.getQR()
			qrcode = new QRCode document.getElementById("qrcode"),
				text: qr
				width: 256
				height: 256
				colorDark : "#000000"
				colorLight : "#ffffff"
				correctLevel : QRCode.CorrectLevel.L # Low Medium Q High
		@addButton new Button 'Rensa',                       @x+@w/2,@yoff[3],@w/2-2,3*h-2, -> 
			@page.selectedPersons = {R:[], L:[], K:[]}
			@page.sbuttons = [] 

			pages.typ.selected = null
			pages.partier.clear()
			pages.letters.clear()
			pages.personer.clear()
			qr = ''

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
					person = persons[i]
					s += person[KANDIDATNUMMER].padStart 6,'0'
				else
					s += '000000'
		assert s.length,4+6+15*6 # 100
		s

	render : ->
		if @selected != null
			push()
			textAlign CENTER,CENTER
			textSize 20
			sc()
			[x,y] = [pages.partier.x+pages.partier.w/2, pages.partier.y+pages.partier.h/34]
			if @selected.typ == 'R' then text 'Riksdag',            x,y
			if @selected.typ == 'L' then text dictionary[länskod],  x,y
			if @selected.typ == 'K' then text dictionary[kommunkod],x,y
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
		h = height/30
		w = @w
		d = 0.032 * height

		for typ,persons of @selectedPersons
			index = "RLK".indexOf typ
			for person,i in persons
				x1 = @x + 0.90 * @w
				x2 = @x + 0.95 * @w
				y1 = @yoff[index] + 0.061 * height + (i)*h
				y2 = @yoff[index] + 0.061 * height + (i)*h-h/2
				do (typ,i) =>
					if i>0 then @addsButton new Button 'byt',x1, y2,d,d, => @clickSwap   typ,i
					@addsButton             new Button ' x ',x2, y1,d,d, => @clickDelete typ,i

	clickPersonButton : (person) ->
		persons = @selectedPersons[@selected.typ]
		# Finns partiet redan? I så fall: ersätt denna person med den nya.
		for p,i in persons 
			if p[PARTIKOD] == person[PARTIKOD]
				persons[i] = person
				return 
		if persons.length < VOTES
			persons.push person 
			@createSelectButtons()

	clickPartiButton : (button) ->
		persons = @selectedPersons[@selected.typ]
		# Finns partiet redan? I så fall: ersätt denna person med den nya.
		person = []
		person[NAMN] = dictionary[button.title][0]
		person[PARTIKOD] = dictionary[button.title][1]
		person[PARTIFÖRKORTNING] = button.title
		person[KANDIDATNUMMER] = '99' + person[PARTIKOD].padStart 4,'0'	

		for p,i in persons 
			if p[PARTIKOD] == person[PARTIKOD]
				persons[i] = person
				return 
		if persons.length < VOTES
			persons.push person 
			@createSelectButtons()

	showSelectedPersons : ->
		push()
		textAlign LEFT,CENTER
		for typ,i in 'RLK'
			sc()
			sw 1 
			rectMode CORNER
			y0 = @yoff[i]
			if i == 0 then fc 1,1,0.5
			if i == 1 then fc 0.5,0.75,1
			if i == 2 then fc 1
			rect @x,y0+3/51*height-1, @w-2, 13/51 * height
			fc 0
			sc()
			sw 0
			for person,j in @selectedPersons[typ]
				y = y0 + 80 + 40*j
				textSize 20
				text "#{j+1}  #{person[PARTIFÖRKORTNING]} - #{person[NAMN]}",@x+10,y
		pop()

		for button in @sbuttons
			button.draw()

	mousePressed : ->
		for button in @sbuttons
			if button.inside mouseX,mouseY then button.click()
		super()

class UtskriftPage extends Page
	constructor : (x,y,w,h) ->
		super x,y,w,h
		@selected = null
		@buttons = []
		@addButton new Button 'Utskrift', 100,height-382,270,45, -> window.print()
		@addButton new Button 'Fortsätt', 400,height-382,270,45, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pages.utskrift.active = false 
			pages.typ.createSelectButtons()

	showSelectedPersons : ->
		push()
		textAlign LEFT,CENTER
		fc 0
		sc()
		textSize 20
		for typ,i in 'RLK'
			for person,j in pages.typ.selectedPersons[typ]
				y = [0,260,520][i] + 50 + 40*j
				text "#{j+1}  #{person[PARTIFÖRKORTNING]} - #{person[NAMN]}",width/2,y
		pop()

	render : ->
		textAlign LEFT,CENTER
		bg 1
		fc 0
		text qr,20,height-310
		text 'Riksdag',            10,50+0
		text dictionary[länskod],  10,50+260
		text dictionary[kommunkod],10,50+520
		@showSelectedPersons()
		pages.typ.sbuttons = []

class Button
	constructor : (@title, @x,@y,@w,@h,@click = ->) ->
		@ts = 0.5 * @h
	draw : ->
		fc 0.5
		push()
		sc()
		#sw 1
		rect @x,@y,@w,@h
		pop()
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+@w/2,@y+@h/2
	inside : -> @x < mouseX < @x+@w and @y < mouseY < @y+@h

class PartiButton extends Button 
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		#textSize if @title in 'S C MP L M V SD KD'.split ' ' then 28 else 20
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+@w/2,@y+@h/2

class LetterButton extends Button 
	constructor : (title,x,y,w,h,@antal,click) ->
		super title,x,y,w,h,click
		@pageNo = -1
		@pages = 1 + @antal // PERSONS_PER_PAGE
		if @antal % PERSONS_PER_PAGE == 0 then @pages--
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+@w/2,@y+@h/2
		push()
		@pageIndicator()
		pop()
	pageIndicator : ->
		if @pages <= 1 then return 
		dx = @w//(@pages+1)
		for i in range @pages
			if i==@pageNo then fc 1 else fc 0
			circle @x + (i+1)*dx , @y+0.85*@h, 3  

class PersonButton extends Button
	constructor : (person, x,y,w,h,click = ->) ->
		title = "#{person[NAMN]} - #{person[VALSEDELSUPPGIFT]}"
		super title,x,y,w,h,click
		@person = person
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize @ts
		textAlign LEFT,CENTER
		fc 1
		text @title,@x+GAP,@y+2+@h/2

class TypButton extends Button
	constructor : (@typ, title,x,y,w,h,click = ->) ->
		super title, x,y,w,h,click

spara = (lista,key,value) ->
	current = tree
	for name in lista
		a = current[name]
		if a == undefined then current[name] = {}
		current = current[name]
	current[key] = value
readDatabase = ->

	{kommun} = getParameters()
	print kommun
	kommunkod = kommun
	if not kommunkod then kommunkod = '0180'
	länskod = kommunkod.slice 0,2	

	partikoder = {}
	#partier = {}
	lines = db.split '\n'

	#clowner = getClowner lines

	for line in lines
		cells = line.split ';'
		valtyp = cells[VALTYP]
		områdeskod = cells[VALOMRÅDESKOD]
		område = cells[VALOMRÅDESNAMN]
		parti = cells[PARTIFÖRKORTNING]
		#if parti=='' then parti = cells[PARTIKOD]
		knr = cells[KANDIDATNUMMER]
		namn = cells[NAMN]

		partikoder[cells[PARTIKOD]]=parti

		#if knr in clowner then continue
		if namn == undefined then continue
		if parti == '' then continue

		dictionary[parti] = [cells[PARTIBETECKNING],cells[PARTIKOD]]
		dictionary[områdeskod] = område # hanterar både kommun och landsting
		# S -> ['Socialdemokraterna','1234']
		# 01 -> '01 - Stockholms läns landsting'
		# 0180 -> Stockholm

		arr = namn.split ', '
		if arr.length == 2
			namn = arr[1] + ' ' + arr[0] 
			cells[NAMN] = namn

		if parti == '' or namn == '[inte lämnat förklaring]' then continue
		if valtyp == 'R'                           then spara [valtyp, parti], "#{knr}-#{namn}", cells
		if valtyp == 'L' and områdeskod==länskod   then spara [valtyp, parti], "#{knr}-#{namn}", cells
		if valtyp == 'K' and områdeskod==kommunkod then spara [valtyp, parti], "#{knr}-#{namn}", cells
	print dictionary
	print partikoder
	#print partier
	#for key,parti of partier
	#	if 1 < _.size parti then print key,parti

getParameters = (h = window.location.href) -> 
	h = decodeURI h
	arr = h.split '?'
	if arr.length != 2 then return {}
	if arr[1] == '' then return {}
	_.object(f.split '=' for f in arr[1].split '&')		

setup = ->
	createCanvas windowWidth,windowHeight

	readDatabase()
	print tree

	x0 = 0
	x1 = 0.2*width
	x2 = 0.27*width
	x3 = 0.57*width
	x4 = 1.00*width
	pages.typ      = new TypPage     x3,0,x4-x3,height 
	pages.partier  = new PartiPage    0,0,x1-x0,height 
	pages.letters  = new LetterPage  x1,0,x2-x1,height 
	pages.personer = new PersonPage  x2,0,x3-x2,height 
	pages.utskrift = new UtskriftPage 0,0,x4,height
	pages.utskrift.active = false 

	sc()

	textAlign CENTER,CENTER
	textSize 20

draw = ->	
	bg 0
	if pages.utskrift.active 
		pages.utskrift.draw()
	else 
		for key,page of pages 
			page.draw()

mousePressed = -> 
	for key,page of pages 
		page.mousePressed()

#windowResized = -> resizeCanvas windowWidth, windowHeight


######

	# constructor : (@render = ->) ->
	# 	super()
	# 	@rbuttons = [] # RKL
	# 	@init()

	# radd : (button) -> @rbuttons.push button
	# padd : (button) -> @pbuttons.push button
	# ladd : (button) -> @lbuttons.push button
	# kadd : (button) -> @kbuttons.push button
	# sadd : (button) -> @sbuttons.push button

	# allButtons : -> @pbuttons.concat @lbuttons.concat @kbuttons.concat @sbuttons.concat @rbuttons 

	# init : ->
	# 	@pbuttons = [] # parti
	# 	@lbuttons = [] # letters
	# 	@kbuttons = [] # kandidater
	# 	@sbuttons = [] # Del, Up, Down

	# draw : ->
	# 	bg 0
	# 	@render()
	# 	for button in @allButtons()
	# 		button.draw()

	# mousePressed : ->
	# 	for button in @allButtons()
	# 		if button.inside() then button.click()


# class Page1 extends Page




# antal = (letter,personer) ->
# 	lst = (1 for key,person of personer when letter == person[NAMN][0])
# 	lst.length


# getClowner = (lines) -> # tag fram alla personer som representerar flera partier i samma valtyp
# 	res = []
# 	partier = {}
# 	for line in lines 
# 		cells = line.split ';'
# 		knr = cells[KANDIDATNUMMER]
# 		if partier[knr] == undefined then partier[knr] = {}
# 		partier[knr][cells[PARTIKOD]] = cells
# 	for knr,lista of partier
# 		if 1 == _.size lista then continue
# 		klr = {R:0,K:0,L:0}
# 		for key,item of lista
# 			klr[item[VALTYP]]++
# 		if klr.R>1 or klr.K>1 or klr.L>1 then res.push knr
# 	print 'Borttagna kandidater pga flera partier i samma valtyp: ',res
# 	res

