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

pressed = false 

makeFreq = (words) -> # personer är en lista
	res = {}
	words.sort()
	for word in words
		letter = word[0]
		res[letter] = if res[letter] == undefined then 1 else res[letter] + 1
	res
assert {a:5, b:9, c:4}, makeFreq 'ababcbabcbcbabcbab'.split ''

gruppera = (words, n=32) -> # words är en lista med ord
	letters = makeFreq words
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
assert {abc:18}, gruppera 'cababbabcbcbabcbab'.split ''
assert {AB:7,C:5,D:9}, gruppera 'DBDCDADBDADCDBDADCBCC'.split(''), 8

rensa = ->
	pages.typ.selectedPersons = {R:[], L:[], K:[]}
	pages.typ.sbuttons = [] 
	pages.typ.selected = null
	pages.partier.clear()
	pages.letters.clear()
	pages.personer.clear()
	pages.typ.qr = ''
	pages.typ.start = new Date().getTime()

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
	data = if filename == 'data\\09.txt' then '' else loadFile filename 
	dbName[rkl] = ''
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
	print 'getTxt',rkl,filename, data.length, _.size dbPersoner[rkl]
	#print 'Partier:', _.size dbTree[rkl] 
	#print 'Partier:', _.size dbPartier[rkl]
	#print 'Personer:', _.size dbPersoner[rkl]

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
	pages.kommun   = new KommunPage   0,0,x4,height 
	pages.typ      = new TypPage     x3,0,x4-x3,height 
	pages.utskrift = new UtskriftPage 0,0,x4,height

	pages.utskrift.active = false 
	pages.kommun.active = false			

	pages.typ.buttons[1].title = dbName.L
	pages.typ.buttons[2].title = dbName.K

	print _.keys pages 

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

# Denna konstruktion nödvändig eftersom klick på Motala ger Utskrift.
# Dvs ett klick tolkas som två. 
mousePressed = -> 
	ps = (page for key,page of pages when page.active)
	for page in ps
		if page.mousePressed() then return
