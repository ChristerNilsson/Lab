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
state = 0 # 0=normal 1=qrcode

canvas = null
qrcode = null

dictionary = {} 
	# S -> Socialdemokraterna
	# 01 -> Stockholms läns landsting
	# 0180 -> Stockholm

buttons = [] # RKL
pbuttons = [] # parti
lbuttons = [] # letters
kbuttons = [] # kandidater
sbuttons = [] # Del, Up, Down

selectedPersons = {R:[], L:[], K:[]}

selectedButton = null
selectedPartiButton = null
selectedLetterButton = null
selectedPersonButton = null

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
	sbuttons = []
	for typ,persons of selectedPersons
		print persons
		for person,i in persons
			print person
			x = 770
			y = {R:100,L:370,K:640}[typ] + i*40
			do (typ,i) ->
				sbuttons.push                            new Button ' x ',x+ 0,y,40,30, -> clickDelete @,typ,i
				if i>0                then sbuttons.push new Button 'upp',x+45,y,40,30, -> clickUp     @,typ,i
				if i<persons.length-1 then sbuttons.push new Button 'ner',x+90,y,40,30, -> clickDown   @,typ,i

clickDelete = (button,typ,index) ->
	selectedPersons[typ].splice index,1 	
	createSelectButtons()

clickUp = (button,typ,index) ->
	arr = selectedPersons[typ]
	if index == 0 then return
	[item] = arr.splice index,1 	
	arr.splice index-1,0,item 	
	createSelectButtons()

clickDown = (button,typ,index) ->
	arr = selectedPersons[typ]
	if index == arr.length-1 then return
	[item] = arr.splice index,1 	
	arr.splice index+1,0,item 	
	createSelectButtons()

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
	kbuttons = []
	keys = _.keys personer 
	keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
	j = 0
	for key in keys
		person = personer[key]
		if person[NAMN][0] in letters
			if j // N == button.page 
				x = 505
				y = 38+25*(j%N)
				do (person) -> kbuttons.push new PersonButton person,x,y,400,20, -> clickPersonButton person
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
	lbuttons = []
	kbuttons = []

	if PERSONS_PER_PAGE >= _.size personer
		keys = _.keys personer
		keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
		for key,j in keys
			person = personer[key]
			x = 505
			y = 40+25*j
			do (person) -> kbuttons.push new PersonButton person,x,y,400,20, -> clickPersonButton person

	else
		i = 0
		for letters,n of gruppera makeFreq personer
			#print letters,n
			x = 225+50*(i//N)
			y = 50+50*(i%N)
			title = if letters.length == 1 then letters else "#{letters[0]}-#{_.last letters}"
			do (letters,title) -> lbuttons.push new LetterButton title,x,y,45,45,n, -> clickLetterButton @, letters, personer
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
	pbuttons = []
	lbuttons = []
	kbuttons = []
	keys = _.keys partier
	keys.sort (a,b) -> _.size(partier[b]) - _.size(partier[a])
	for key,i in keys
		x = 50+100*(i//N)
		y = 50+50*(i%N)
		do (key) -> pbuttons.push new PartiButton key,x,y,95,45, -> clickPartiButton @, partier[key]

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
	print s
	s

clickUtskrift = ->
	state = 1
	qrcode = new QRCode document.getElementById("qrcode"),
		text: getQR()
		width: 256
		height: 256
		colorDark : "#000000"
		colorLight : "#ffffff"
		correctLevel : QRCode.CorrectLevel.L # Low Medium Q High

setup = ->
	createCanvas 1250,840
	sc()

	{kommunkod} = getParameters()
	if not kommunkod then kommunkod = '0180'
	länskod = kommunkod.slice 0,2
	
	readDatabase()
	print tree

	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 20

	buttons.push new Button 'Riksdag',  950, 50,400,45, -> clickButton @, tree['00 - riksdagen'] 
	buttons.push new Button 'Landsting',950,310,400,45, -> clickButton @, tree[länskod][dictionary[länskod]]
	buttons.push new Button 'Kommun',   950,570,400,45, -> clickButton @, tree[länskod][dictionary[kommunkod]]

	buttons.push new Button 'Utskrift', 950,830,400,45, -> clickUtskrift() # @, tree[länskod][dictionary[kommunkod]]

showSelectedPersons = ->
	x = 720
	push()
	textAlign LEFT,CENTER
	for typ,i in 'RLK'
		y0 = [100,370,640][i]
		#textSize 28
		#text buttons[i].title,x,y0
		for person,j in selectedPersons[typ]
			y = y0 + 40*j
			textSize 20
			text "#{j+1}.",x,y
			text "#{person[PARTIFÖRKORTNING]} - #{person[NAMN]}",x+170,y
	pop()

draw = ->
	if state == 0
		bg 0
		for button in buttons.concat pbuttons.concat lbuttons.concat kbuttons.concat sbuttons
			button.draw()
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
		showSelectedPersons()
	if state == 1
		bg 1
		#Drawing.draw qrcode 

mousePressed = ->
	for button in buttons.concat pbuttons.concat lbuttons.concat kbuttons.concat sbuttons
		if button.inside mouseX,mouseY then button.click()
