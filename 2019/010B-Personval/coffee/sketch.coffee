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
pageStack = new PageStack()

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
	pages.rlk.selectedPersons = {R:[], L:[], K:[]}
	pages.rlk.sbuttons = [] 
	pages.rlk.selected = null
	pages.partier.clear()
	pages.letters.clear()
	pages.personer.clear()
	pages.rlk.qr = ''
	pages.rlk.start = new Date().getTime()

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

getTxt = (rlk,filename) ->
	data = if filename == 'data\\09.txt' then '' else loadFile filename 
	dbName[rlk] = ''
	dbTree[rlk] = {}
	dbPartier[rlk] = {}
	dbPersoner[rlk] = {}
	lines = data.split '\n'
	for line in lines
		line = line.trim()
		cells = line.split '|'
		if cells[0]=='T' # T|Arjeplog
			dbName[rlk] = cells[1]
		if cells[0]=='A' # kandidaturer # A|3|208509|208510|208511|208512|208513|208514
			dbTree[rlk][cells[1]] = cells.slice 2
		if cells[0]=='B' # partier # B|4|C|Centerpartiet
			dbPartier[rlk][cells[1]] = cells.slice 2 
		if cells[0]=='C' # personer # C|10552|53|K|Britta Flinkfeldt|53 år, Arjeplog
			dbPersoner[rlk][cells[1]] = cells.slice 2 
	print 'getTxt',rlk,filename, data.length, _.size dbPersoner[rlk]

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

	pages.rlk.buttons[1].title = dbName.L
	pages.rlk.buttons[2].title = dbName.K

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
	pages.rlk      = new RLKPage     x3,0,x4-x3,height 
	pages.utskrift = new UtskriftPage 0,0,x4,height

	pageStack.push pages.partier
	pageStack.push pages.letters
	pageStack.push pages.personer
	pageStack.push pages.rlk

	pages.utskrift.modal = true 
	pages.kommun.modal = true			

	pages.rlk.buttons[1].title = dbName.L
	pages.rlk.buttons[2].title = dbName.K

	print _.keys pages 

draw = ->	pageStack.draw()
mousePressed = -> pageStack.mousePressed()
