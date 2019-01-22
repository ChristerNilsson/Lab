
PERSONS_PER_PAGE = 32
VOTES = 5

kommunkod = null
länskod = null

dbName     = {} # T Områdesnamn
dbTree     = {} # A
dbPartier  = {} # B 
dbPersoner = {} # C
dbKommun   = {}

pages = {}

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

rensa = ->
	pages.typ.selectedPersons = {R:[], L:[], K:[]}
	pages.typ.sbuttons = [] 
	pages.typ.selected = null
	pages.partier.clear()
	pages.letters.clear()
	pages.personer.clear()
	pages.typ.qr = ''
	pages.typ.start = new Date().getTime()

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
			textAlign LEFT,CENTER
			textSize 0.4 * pages.personer.h/17
			rkl = pages.typ.selected.typ
			namn = dbPartier[rkl][@selected.partikod][1]
			s = "#{namn} (#{pages.personer.buttons.length} av #{_.size pages.personer.personer})"
			text s, pages.personer.x, pages.personer.y + pages.personer.h/34
			pop()

	select : (rkl,partier) ->
		N = 16
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
			#print 'select',dbPartier[rkl][partikod]
			do (partikod) => @addButton new PartiButton rkl,partikod,x,y,w-2,h-2, -> 
				@page.selected = @
				if PERSONS_PER_PAGE < _.size partier[partikod]
					pages.letters.makeLetters rkl, @, partikod, partier[partikod]
					pages.personer.buttons = []
				else
					pages.letters.buttons = []
					pages.personer.makePersons rkl, @, partikod, partier[partikod]
				pages.typ.clickPartiButton @	
				pages.personer.personer = partier[partikod]			

class LetterPage extends Page
	render : ->

	makeFreq : (rkl,personer) -> # personer är en lista
		res = {}
		names = (dbPersoner[rkl][key][2] for key in personer)
		names.sort()
		for name in names
			letter = name[0]
			res[letter] = if res[letter] == undefined then 1 else res[letter] + 1
		res

	makeLetters : (rkl, button, partikod, personer) ->
		N = 16
		h = @h/(N+1)
		w = @w/2
		@selected = button 
		@buttons = []

		i = 0
		for letters,n of gruppera @makeFreq rkl,personer
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) => @addButton new LetterButton title,x,y,w-2,h-2,n, -> 
				@page.selected = @
				pages.personer.clickLetterButton rkl, @, partikod, letters, personer
			i++

class PersonPage extends Page

	render : ->

	clickLetterButton : (rkl,button,partikod,letters,knrs) ->
		#print 'clickLetterButton',knrs
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
						pages.typ.clickPersonButton [partikod,knr]
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
			person = dbPersoner[rkl][knr] # [age,sex,name,uppgift]
			x = j//N * w/2
			x = x % w
			y = 2*h*(1 + j%N)
			do (partikod,knr) => @addButton new PersonButton rkl, partikod, knr, @x+x,@y+y,w/2-2,2*h-2, -> 
				@page.selected = @
				pages.typ.clickPersonButton [@partikod,@knr]

class LetterKommunPage extends Page
	render : ->

	makeFreq : (rkl,personer) -> # personer är en lista
		res = {}
		names = (dbPersoner[rkl][key][2] for key in personer)
		names.sort()
		for name in names
			letter = name[0]
			res[letter] = if res[letter] == undefined then 1 else res[letter] + 1
		res

	makeLetters : (rkl, button, partikod, personer) ->
		N = 16
		h = @h/(N+1)
		w = @w/2
		@selected = button 
		@buttons = []

		i = 0
		for letters,n of gruppera @makeFreq rkl,personer
			x = @x + w*(i//N)
			y = @y + h*(1+i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) => @addButton new LetterButton title,x,y,w-2,h-2,n, -> 
				@page.selected = @
				pages.personer.clickLetterButton rkl, @, partikod, letters, personer
			i++

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
					#print @key
					rensa()
					fetchKommun @key
				i++
		@selected = @buttons[index] 

	render : ->

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
				width: 256
				height: 256
				colorDark : "#000000"
				colorLight : "#ffffff"
				correctLevel : QRCode.CorrectLevel.L # Low Medium Q High

		@addButton new Button 'Rensa', @x+@w/3,@yoff[3],@w/3-2,3*h-3, -> rensa()

		@addButton new Button 'Byt kommun', @x+2*@w/3,@yoff[3],@w/3-0,3*h-3, -> 
			#print 'Byt kommun'
			for page in pages
				page.active = false 
			pages.kommun.active = true
			#@page.selectedPersons = {R:[], L:[], K:[]}
			#@page.sbuttons = [] 

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
		#print person,persons
		# Finns partiet redan? I så fall: ersätt denna person med den nya.
		for pair,i in persons 
			if pair[0] == person[0]
				persons[i][1] = person[1]
				#print persons
				return 
		if persons.length < VOTES
			pair = person
			#print person
			persons.push pair
			#print persons 
			@createSelectButtons()

	clickPartiButton : (button) ->
		persons = @selectedPersons[@selected.typ]
		# Finns partiet redan? I så fall: ersätt denna person med den nya.
		#person = []
		#person[NAMN] = dbPartier[@selected.typ][button.partikod][0]
		#person[PARTIKOD] = button.partikod # dictionary[button.title][1]
		#person[PARTIFÖRKORTNING] = dbPartier[@selected.typ][button.partikod][0] # button.title
		#person[KANDIDATNUMMER] = '99' + person[PARTIKOD].padStart 4,'0'	

		for p,i in persons 
			if p.partikod == button.partikod
				persons[i].knr = 0 
				return 
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
					#person = []
					#person[NAMN] = dictionary[name][0]
					#person[PARTIKOD] = dictionary[name][1]
					#person[PARTIFÖRKORTNING] = name
					#person[KANDIDATNUMMER] = '99' + person[PARTIKOD].padStart 4,'0'	
					pair = [partikod,0]
				else # Vote for a person
					knr = _.sample knrs
					pair = [partikod,knr]
				@selectedPersons[rkl].push pair
		#print @selectedPersons
	
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

		#person = []
		#person[NAMN] = dbPartier[@selected.typ][button.partikod][0]
		#person[PARTIKOD] = button.partikod # dictionary[button.title][1]
		#person[PARTIFÖRKORTNING] = dbPartier[@selected.typ][button.partikod][0] # button.title
		#person[KANDIDATNUMMER] = '99' + person[PARTIKOD].padStart 4,'0'	

			for pair,j in @selectedPersons[typ]
				#print 'showSelectedPersons',pair,@selectedPersons[typ]
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

class UtskriftPage extends Page
	constructor : (x,y,w,h) ->
		super x,y,w,h
		@selected = null
		@buttons = []
		@addButton new Button 'Utskrift', 50,height-382,270,45, -> window.print()
		@addButton new Button 'Fortsätt', 350,height-382,270,45, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pages.utskrift.active = false 
			pages.typ.createSelectButtons()
		@addButton new Button 'Slump', 650,height-382,270,45, -> 
			myNode = document.getElementById "qrcode"
			myNode.innerHTML = ''
			pages.utskrift.active = false 
			pages.typ.slumpa()
			pages.typ.createSelectButtons()

	stopMeasuringTime : ->
		@crc = @getCRC pages.typ.qr
		@cpu = new Date().getTime() - pages.typ.start

	getCRC : (qr) ->
		res = 0
		for char,i in qr
			index = '0123456789'.indexOf char
			res += (i+1) * (index+1)
			res %= 1000000
		res

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
		text 'Riksdag',10,50+0
		text dbName.L, 10,50+260
		text dbName.R, 10,50+520
		#text pages.typ.qr,20,height-310
		text "#{'crc: ' + @getCRC pages.typ.qr.slice 10} #{'tid: '+@cpu}",20,height-310
		@showSelectedPersons()
		pages.typ.sbuttons = []

class Button
	constructor : (@title, @x,@y,@w,@h,@click = ->) ->
		@ts = 0.6 * @h
	draw : ->
		fc 0.5
		push()
		sc()
		rect @x,@y,@w,@h
		pop()
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		text @title,@x+@w/2,@y+@h/2
	inside : -> @x < mouseX < @x+@w and @y < mouseY < @y+@h

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

class PartiButton extends Button 
	constructor : (@rkl,@partikod,x,y,w,h,click = ->) ->
		super '', x,y,w,h,click
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize @ts
		textAlign CENTER,CENTER
		if @page.selected == @ then fc 1,1,0 else fc 1
		#print @rkl,@partikod
		partinamn = dbPartier[@rkl][@partikod][0]
		if partinamn == '' then partinamn = dbPartier[@rkl][@partikod][1]

		text partinamn,@x+@w/2,@y+@h/2

class LetterButton extends Button 
	constructor : (title,x,y,w,h,@antal,click) ->
		super title,x,y,w,h,click
		@pageNo = -1
		@pages = 1 + @antal // PERSONS_PER_PAGE
		if @antal % PERSONS_PER_PAGE == 0 then @pages--
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize 0.8 * @ts
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
			if i==@pageNo and @page.selected == @ then fc 1 else fc 0
			circle @x + (i+1)*dx , @y+0.85*@h, 3  

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

class TypButton extends Button
	constructor : (@typ, title,x,y,w,h,click = ->) ->
		super title, x,y,w,h,click

getParameters = (h = window.location.href) -> 
	h = decodeURI h
	arr = h.split '?'
	if arr.length != 2 then return {}
	if arr[1] == '' then return {}
	_.object(f.split '=' for f in arr[1].split '&')		

loadFile = (filePath) ->
  result = null
  xmlhttp = new XMLHttpRequest()
  xmlhttp.open "GET", filePath, false
  xmlhttp.send()
  if xmlhttp.status==200 then result = xmlhttp.responseText  
  result

getTxt = (rkl,filename) ->
	data = loadFile filename 
	dbTree[rkl] = {}
	dbPartier[rkl] = {}
	dbPersoner[rkl] = {}
	lines = data.split '\n'
	for line in lines
		line = line.trim()
		cells = line.split '|'
		if cells[0]=='T' # T|Arjeplog
			dbName[rkl] = cells[1]
		if cells[0]=='A' # kandidaturer # A|3|208509|208510|208511|208512|208513|208514
			dbTree[rkl][cells[1]] = cells.slice 2
		if cells[0]=='B' # partier # B|4|C|Centerpartiet
			dbPartier[rkl][cells[1]] = cells.slice 2 
		if cells[0]=='C' # personer # C|10552|53|K|Britta Flinkfeldt|53 år, Arjeplog
			dbPersoner[rkl][cells[1]] = cells.slice 2 
	print 'getTxt',rkl,filename,data.length
	print 'Partier:', _.size dbTree[rkl] 
	print 'Partier:', _.size dbPartier[rkl]
	print 'Personer:', _.size dbPersoner[rkl]

getKommun = (filename) ->
	data = loadFile filename 
	dbKommun = {}
	lines = data.split '\n'
	for line in lines
		line = line.trim()
		cells = line.split '|'
		kod = cells[0]
		namn = cells[1]
		if kod.length==4
			dbKommun[kod] = namn
	print 'getKommun', _.size dbKommun

preload = ->
	{kommun} = getParameters()
	if not kommun then kommun = '0180'
	kommunkod = kommun
	länskod = kommunkod.slice 0,2	

	getTxt 'R','data\\00.txt'
	getTxt 'L',"data\\#{länskod}.txt"
	getTxt 'K',"data\\#{kommunkod}.txt"
	getKommun 'data\\omraden.txt'

fetchKommun = (kommun) -> # t ex '0180'
	start = new Date().getTime()

	if länskod != kommun.slice 0,2	
		länskod = kommun.slice 0,2	
		getTxt 'L',"data\\#{länskod}.txt"
	if kommunkod != kommun
		kommunkod = kommun
		getTxt 'K',"data\\#{kommunkod}.txt"
	#getKommun 'data\\omraden.txt'

	for page in pages
		page.active = true
	pages.kommun.active = false
	pages.utskrift.active = false

	pages.typ.buttons[1].title = dbName.L
	pages.typ.buttons[2].title = dbName.K

	print 'time', new Date().getTime() - start

setup = ->
	createCanvas windowWidth,windowHeight-1
	sc()
	textAlign CENTER,CENTER
	textSize 20

	x0 = 0
	x1 = 0.18*width
	x2 = 0.28*width
	x3 = 0.64*width
	x4 = 1.00*width

	pages.partier  = new PartiPage    0,0,x1-x0,height 
	pages.letters  = new LetterPage  x1,0,x2-x1,height 
	pages.personer = new PersonPage  x2,0,x3-x2,height 
	pages.kommun   = new KommunPage  0,0,width,height 
	pages.typ      = new TypPage     x3,0,x4-x3,height 
	pages.utskrift = new UtskriftPage 0,0,x4,height

	pages.utskrift.active = false 
	pages.kommun.active = false			

	pages.typ.buttons[1].title=dbName.L
	pages.typ.buttons[2].title=dbName.K

draw = ->	
	bg 0
	if _.size pages < 6 then return 
	if pages.utskrift == undefined then return
	if pages.utskrift.active 
		pages.utskrift.draw()
	else if pages.kommun.active 
		pages.kommun.draw()
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

# spara = (lista,key,value) ->
# 	current = tree
# 	for name in lista
# 		a = current[name]
# 		if a == undefined then current[name] = {}
# 		current = current[name]
# 	current[key] = value
# readDatabase = ->


# 	partikoder = {}
# 	#partier = {}
# 	lines = db.split '\n'

# 	#clowner = getClowner lines

# 	for line in lines
# 		cells = line.split ';'
# 		valtyp = cells[VALTYP]
# 		områdeskod = cells[VALOMRÅDESKOD]
# 		område = cells[VALOMRÅDESNAMN]
# 		parti = cells[PARTIFÖRKORTNING]
# 		#if parti=='' then parti = cells[PARTIKOD]
# 		knr = cells[KANDIDATNUMMER]
# 		namn = cells[NAMN]

# 		partikoder[cells[PARTIKOD]]=parti

# 		#if knr in clowner then continue
# 		if namn == undefined then continue
# 		if parti == '' then continue

# 		dictionary[parti] = [cells[PARTIBETECKNING],cells[PARTIKOD]]
# 		dictionary[områdeskod] = område # hanterar både kommun och landsting
# 		# S -> ['Socialdemokraterna','1234']
# 		# 01 -> '01 - Stockholms läns landsting'
# 		# 0180 -> Stockholm

# 		arr = namn.split ', '
# 		if arr.length == 2
# 			namn = arr[1] + ' ' + arr[0] 
# 			cells[NAMN] = namn

# 		if parti == '' or namn == '[inte lämnat förklaring]' then continue
# 		if valtyp == 'R'                           then spara [valtyp, parti], "#{knr}-#{namn}", cells
# 		if valtyp == 'L' and områdeskod==länskod   then spara [valtyp, parti], "#{knr}-#{namn}", cells
# 		if valtyp == 'K' and områdeskod==kommunkod then spara [valtyp, parti], "#{knr}-#{namn}", cells

	#print dictionary
	#print partikoder

	#print partier
	#for key,parti of partier
	#	if 1 < _.size parti then print key,parti

