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

VOTES = 5

kommunkod = null
länskod = null

tree = {}

canvas = null
qrcode = null
qr = null

dictionary = {} 
	# S -> Socialdemokraterna
	# 01 -> Stockholms läns landsting
	# 0180 -> Stockholm

state = 0 # 0=normal 1=qrcode
pages = []

selectedPersons = {R:[], L:[], K:[]}

selectedButton = null
selectedPartiButton = null
selectedLetterButton = null
selectedPersonButton = null

class Page
	constructor : (@render = ->) ->
		@buttons  = [] 

	add : (button) -> 
		@buttons.push button
		button

	draw : ->
		@render()
		for button in @buttons
			button.draw()

	mousePressed : ->
		for button in @buttons
			if button.inside mouseX,mouseY then button.click()

class Page0 extends Page
	constructor : (@render = ->) ->
		super()
		@rbuttons = [] # RKL
		@init()

	radd : (button) -> @rbuttons.push button
	padd : (button) -> @pbuttons.push button
	ladd : (button) -> @lbuttons.push button
	kadd : (button) -> @kbuttons.push button
	sadd : (button) -> @sbuttons.push button

	allButtons : -> @rbuttons.concat @pbuttons.concat @lbuttons.concat @kbuttons.concat @sbuttons

	init : ->
		@pbuttons = [] # parti
		@lbuttons = [] # letters
		@kbuttons = [] # kandidater
		@sbuttons = [] # Del, Up, Down

	draw : ->
		@render()
		for button in @allButtons()
			button.draw()

	mousePressed : ->
		for button in @allButtons()
			if button.inside mouseX,mouseY then button.click()

class Page1 extends Page

class Button
	constructor : (@title, @x,@y,@w,@h,@click = ->) ->
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize 20
		textAlign CENTER,CENTER
		if selectedButton==@ then fc 1,1,0 else fc 1
		text @title,@x,@y
	inside : (mx,my) -> @x-@w/2 < mx < @x+@w/2 and @y-@h/2 < my < @y+@h/2

class PartiButton extends Button 
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize if @title in 'S C MP L M V SD KD'.split ' ' then 28 else 20
		textAlign CENTER,CENTER
		if selectedPartiButton==@ then fc 1,1,0 else fc 1
		text @title,@x,@y

class PersonButton extends Button
	constructor : (person, x,y,w,h,click = ->) ->
		title = "#{person[NAMN]} - #{person[VALSEDELSUPPGIFT]}"
		super title,x,y,w,h,click
		@person = person
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize 12
		textAlign LEFT,CENTER
		fc 1
		text @title,@x-@w/2+5,@y

class LetterButton extends Button 
	constructor : (title,x,y,w,h,@antal,click) ->
		super title,x,y,w,h,click
		@page = -1
		@pages = 1 + @antal // PERSONS_PER_PAGE
		if @antal % PERSONS_PER_PAGE == 0 then @pages--
	draw : ->
		fc 0.5
		rect @x,@y,@w,@h
		textSize 20
		textAlign CENTER,CENTER
		if selectedLetterButton==@ then fc 1,1,0 else fc 1
		text @title,@x,@y
		push()
		@pageIndicator()
		pop()
	pageIndicator : ->
		if @pages <= 1 then return 
		dx = @w//(@pages+1)
		for i in range @pages
			if i==@page then fc 1 else fc 0
			circle @x + i*dx - dx//2*(@pages-1), @y+15, 3

spara = (lista,key,value) ->
	current = tree
	for name in lista
		a = current[name]
		if a == undefined then current[name] = {}
		current = current[name]
	current[key] = value

antal = (letter,personer) ->
	lst = (1 for key,person of personer when letter == person[NAMN][0])
	lst.length

createSelectButtons = ->
	pages[0].sbuttons = []
	for typ,persons of selectedPersons
		for person,i in persons
			x = 770
			y = {R:100-20,L:310+50-20,K:570+50-20}[typ] + i*40
			do (typ,i) ->
				pages[0].sadd             new Button ' x ',x+ 0,y,   40,30, -> clickDelete typ,i
				if i>0 then pages[0].sadd new Button 'byt',x+45,y-20,40,30, -> clickSwap   typ,i

clickDelete = (typ,index) ->
	selectedPersons[typ].splice index,1 	
	createSelectButtons()

clickSwap = (typ,index) ->
	arr = selectedPersons[typ]
	[arr[index],arr[index-1]] = [arr[index-1],arr[index]]
	createSelectButtons()

clickRensa = ->
	selectedPersons = {R:[], L:[], K:[]}
	createSelectButtons()	
	pages[0].init()
	selectedButton = null
	selectedPartiButton = null
	selectedLetterButton = null
	selectedPersonButton = null
	qr = ''

clickPersonButton = (person) ->
	persons = selectedPersons[selectedButton.title[0]]
	# Finns partiet redan? I så fall: ersätt denna person med den nya.
	for p,i in persons 
		if p[PARTIKOD] == person[PARTIKOD]
			persons[i] = person
			return 
	if persons.length < VOTES
		persons.push person 
		createSelectButtons()

clickLetterButton = (button,letters,personer) ->
	N = PERSONS_PER_PAGE
	selectedLetterButton = button
	button.page = (button.page + 1) % button.pages
	pages[0].kbuttons = []
	keys = _.keys personer 
	keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
	j = 0
	for key in keys
		person = personer[key]
		if person[NAMN][0] in letters
			if j // N == button.page 
				x = 505
				y = 38+25*(j%N)
				do (person) -> pages[0].kadd new PersonButton person,x,y,400,20, -> clickPersonButton person
			j++

makeFreq = (personer) ->
	res = {}
	keys = (person[NAMN] for key,person of personer)
	keys.sort()
	for key in keys
		letter = key[0]
		res[letter] = if res[letter] == undefined then 1 else res[letter] + 1
	res

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

clickPartiButton = (button, personer) ->
	N = 16
	selectedPartiButton = button 
	pages[0].lbuttons = []
	pages[0].kbuttons = []

	if PERSONS_PER_PAGE >= _.size personer
		keys = _.keys personer
		keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
		for key,j in keys
			person = personer[key]
			x = 505
			y = 40+25*j
			do (person) -> pages[0].kadd new PersonButton person,x,y,400,20, -> clickPersonButton person

	else
		i = 0
		for letters,n of gruppera makeFreq personer
			#print letters,n
			x = 225+50*(i//N)
			y = 50+50*(i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) -> pages[0].ladd new LetterButton title,x,y,45,45,n, -> clickLetterButton @, letters, personer
			i++

	persons = selectedPersons[selectedButton.title[0]]
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
		createSelectButtons()

clickButton = (button, partier) ->
	N = 16
	selectedButton = button
	pages[0].pbuttons = []
	pages[0].lbuttons = []
	pages[0].kbuttons = []
	keys = _.keys partier
	keys.sort (a,b) -> _.size(partier[b]) - _.size(partier[a])
	for key,i in keys
		x = 50+100*(i//N)
		y = 50+50*(i%N)
		do (key) -> pages[0].padd new PartiButton key,x,y,95,45, -> clickPartiButton @, partier[key]

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

readDatabase = ->
	partikoder = {}
	partier = {}
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
		if valtyp == 'R'                           then spara ['00 - riksdagen',              parti], "#{knr}-#{namn}", cells
		if valtyp == 'L' and områdeskod==länskod   then spara [områdeskod,"#{område}",        parti], "#{knr}-#{namn}", cells
		if valtyp == 'K' and områdeskod==kommunkod then spara [områdeskod.slice(0,2), område, parti], "#{knr}-#{namn}", cells
	print dictionary
	print partikoder
	#print partier
	for key,parti of partier
		if 1 < _.size parti then print key,parti

getParameters = (h = window.location.href) -> 
	h = decodeURI h
	arr = h.split '?'
	if arr.length != 2 then return {}
	if arr[1] == '' then return {}
	_.object(f.split '=' for f in arr[1].split '&')		

getQR = ->
	s = kommunkod 
	slump = int random 1000000
	s += slump.toString().padStart 6,0 # to increase probability of uniqueness 
	for typ of selectedPersons
		persons = selectedPersons[typ]
		for i in range VOTES
			if i < persons.length
				person = persons[i]
				s += person[KANDIDATNUMMER].padStart 6,'0'
			else
				s += '000000'
	assert s.length,4+6+15*6 # 100
	s

clickUtskrift = ->
	state = 1
	qr = getQR()
	qrcode = new QRCode document.getElementById("qrcode"),
		text: qr
		width: 256
		height: 256
		colorDark : "#000000"
		colorLight : "#ffffff"
		correctLevel : QRCode.CorrectLevel.L # Low Medium Q High

clickFortsätt = -> 
	myNode = document.getElementById "qrcode"
	myNode.innerHTML = ''
	state = 0

setup = ->
	createCanvas 1250,840

	pages.push new Page0 -> # pages[0].render()
		bg 0
		if selectedPartiButton != null
			push()
			textAlign LEFT,CENTER
			textSize 20
			text dictionary[selectedPartiButton.title][0],310,15
			pop()
		if selectedButton != null
			push()
			textAlign LEFT,CENTER
			textSize 20
			if selectedButton.title == 'Riksdag'   then text 'Riksdag',            10,15
			if selectedButton.title == 'Landsting' then text dictionary[länskod],  10,15
			if selectedButton.title == 'Kommun'    then text dictionary[kommunkod],10,15
			pop()
		showSelectedPersons 750,100-20

	pages.push new Page1 -> # pages[1].render()
		textAlign LEFT,CENTER
		bg 1
		fc 0
		text qr,50,height-20

		text 'Riksdag',            10,50+0
		text dictionary[länskod],  10,50+260
		text dictionary[kommunkod],10,50+520
		
		showSelectedPersons 400,50

	sc()

	{kommunkod} = getParameters()
	if not kommunkod then kommunkod = '0180'
	länskod = kommunkod.slice 0,2
	
	readDatabase()
	print tree

	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 20

	pages[0].radd new Button 'Riksdag',   950, 50-20,400,45, -> clickButton @, tree['00 - riksdagen'] 
	pages[0].radd new Button 'Landsting', 950,310-20,400,45, -> clickButton @, tree[länskod][dictionary[länskod]]
	pages[0].radd new Button 'Kommun',    950,570-20,400,45, -> clickButton @, tree[länskod][dictionary[kommunkod]]
	pages[0].radd new Button 'Utskrift',  850,830-20,200,45, -> clickUtskrift() 
	pages[0].radd new Button 'Rensa',    1050,830-20,195,45, -> clickRensa()

	pages[1].add new Button 'Utskrift', 490,height-60,200,45, -> window.print()
	pages[1].add new Button 'Fortsätt', 700,height-60,200,45, -> clickFortsätt()

showSelectedPersons = (xoff,yoff) ->
	push()
	textAlign LEFT,CENTER
	for typ,i in 'RLK'
		y0 = yoff+[0,260,520][i]
		for person,j in selectedPersons[typ]
			y = y0 + 40*j
			textSize 20
			text "#{j+1}.",xoff-30,y
			text "#{person[PARTIFÖRKORTNING]} - #{person[NAMN]}",xoff+100,y
	pop()

draw = ->	pages[state].draw()
mousePressed = -> pages[state].mousePressed mouseX,mouseY
