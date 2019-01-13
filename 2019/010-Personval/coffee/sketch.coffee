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

kommunkod = null
länskod = null

tree = {}

dictionary = {} 
	# S -> Socialdemokraterna
	# 01 -> Stockholms läns landsting
	# 0180 -> Stockholm

buttons = []
pbuttons = []
lbuttons = []
kbuttons = []

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
		@pages = 1 + @antal // 30
		if @antal==0 then @pages = 0 
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
		if @pages < 1 then return 
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
	#print letter,personer
	lst = (1 for key,person of personer when letter == person[NAMN][0])
	lst.length

clickLetterButton = (button,letter,personer) ->
	N = PERSONS_PER_PAGE
	selectedLetterButton = button
	button.page = (button.page + 1) % button.pages
	#print 'visaPersoner',button.page
	kbuttons = []
	keys = _.keys personer 
	keys.sort (a,b) -> if a.slice(a.indexOf('-')) < b.slice(b.indexOf('-')) then -1 else 1
	#print _.size keys
	j = 0
	for key in keys
		person = personer[key]
		if letter == person[NAMN][0]
			if j // N == button.page 
				x = 605 
				y = 38+25*(j%N)
				do (key) -> kbuttons.push new PersonButton "#{person[NAMN]} - #{person[VALSEDELSUPPGIFT]}",x,y,400,20, -> print key
			j++

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
			x = 605
			y = 40+25*j
			do (key) -> kbuttons.push new PersonButton "#{person[NAMN]} - #{person[VALSEDELSUPPGIFT]}",x,y,400,20, -> print key

	else
		for letter,i in 'ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ'
			x = 325+50*(i//N)
			y = 50+50*(i%N)
			n = antal letter,personer
			title = letter
			do (letter,title) -> lbuttons.push new LetterButton title,x,y,45,45,n, -> clickLetterButton @, letter, personer

clickButton = (button, partier) ->
	N = 16
	selectedButton = button
	#print button
	pbuttons = []
	lbuttons = []
	kbuttons = []
	keys = _.keys partier
	keys.sort (a,b) -> _.size(partier[b]) - _.size(partier[a])
	for key,i in keys
		x = 150+100*(i//N)
		y = 50+50*(i%N)
		do (key) -> pbuttons.push new PartiButton key,x,y,95,45, -> clickPartiButton @, partier[key]

readDatabase = ->
	lines = db.split '\n'
	for line in lines
		cells = line.split ';'
		valtyp = cells[VALTYP]
		områdeskod = cells[VALOMRÅDESKOD]
		område = cells[VALOMRÅDESNAMN]
		parti = cells[PARTIFÖRKORTNING]
		#if parti=='' then parti = cells[PARTIKOD]
		knr = cells[KANDIDATNUMMER]
		namn = cells[NAMN]

		if namn == undefined then continue
		if parti == '' then continue

		dictionary[parti] = cells[PARTIBETECKNING]
		dictionary[områdeskod] = område # hanterar både kommun och landsting
		# S -> Socialdemokraterna
		# 01 -> 01 - Stockholms läns landsting
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

setup = ->
	createCanvas 1400,840
	sc()

	# från urlen:
	#kommunkod = '0180' # Stockholm
	#kommunkod = '1275' # Perstorp
	kommunkod = '1276' # Klippan

	länskod = kommunkod.slice 0,2
	
	readDatabase()
	print tree

	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 20

	buttons.push new Button 'Riksdag',  50, 50,95,45, -> clickButton @, tree['00 - riksdagen'] 
	buttons.push new Button 'Landsting',50,100,95,45, -> clickButton @, tree[länskod][dictionary[länskod]]
	buttons.push new Button 'Kommun',   50,150,95,45, -> clickButton @, tree[länskod][dictionary[kommunkod]]

draw = ->
	bg 0
	for button in buttons.concat pbuttons.concat lbuttons.concat kbuttons
		button.draw()
	if selectedPartiButton != null
		push()
		textAlign LEFT,CENTER
		textSize 20
		text dictionary[selectedPartiButton.title],410,15
		pop()
	if selectedButton != null
		push()
		textAlign LEFT,CENTER
		textSize 20
		if selectedButton.title == 'Riksdag'   then text 'Riksdag',            110,15
		if selectedButton.title == 'Landsting' then text dictionary[länskod],  110,15
		if selectedButton.title == 'Kommun'    then text dictionary[kommunkod],110,15
		pop()

mousePressed = ->
	for button in buttons.concat pbuttons.concat lbuttons.concat kbuttons
		if button.inside mouseX,mouseY then button.click()
