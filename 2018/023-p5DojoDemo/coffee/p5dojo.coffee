# todo: Code Mirror hanterar inte toggleComment via Ctrl+/

# if the renew button is available, a new version of the b code is available.
# Clicking renew prints the current b code on the console as a backup.

INTERVAL = 1000

myCodeMirror = null
msg = null

kwl = {}
kwlinks = []

gap = 0
block = 0
buffer = [[],[],[]]

meny = null

# setMsg = (e,nr) ->
# 	if e == ''
# 		msg.val ""
# 		msg.hide()
# 	else
# 		s = e.toString()
# 		p = s.indexOf ':'
# 		s = s.substr p+1 if p!=-1

# 		s = s.replace /\t/g,'  '

# 		msg.val s + ' (' + e.name + ')' + if nr==1 then " (in A)" else ""
# 		msg.show()
# 	msg.css 'background-color', if e == '' then '#FFFFFF' else '#FF0000'

grid = ->
	push()
	bg 0.25
	sc 0.5
	for i in range 11
		line 0, 20 * i, 200, 20 * i
		line 20 * i, 0, 20 * i, 200
	pop()

myprint = -> print Array.prototype.slice.call(arguments).join(" ")

co = -> fixColor arguments

ip = (y1,y2,x,x1,x2) ->
	if arguments.length == 3
		x1=0
		x2=9
	map x,x1,x2,y1,y2

fixColor = (args) ->
	n = args.length
	r=0
	g=0
	b=0
	a=1
	if n == 1
		r = args[0]
		g = r
		b = r
	else if n == 3
		r = args[0]
		g = args[1]
		b = args[2]
	else if n == 4
		r = args[0]
		g = args[1]
		b = args[2]
		a = args[3]
	color 255 * r, 255 * g, 255 * b, 255 * a

bg = -> background fixColor arguments

fc = ->
	n = arguments.length
	if n == 0
		noFill()
	else
		fill fixColor arguments

sc = ->
	n = arguments.length
	if n == 0
		noStroke()
	else
		stroke fixColor arguments

#b g c = (cc) -> bg cc%2, int(cc/2)%2, int(cc/4)
#f c c = (cc) -> fc cc%2, int(cc/2)%2, int(cc/4)
#s c c = (cc) -> sc cc%2, int(cc/2)%2, int(cc/4)
#t c c = (cc) -> f c c [7,7,0,0,7,0,0,0][cc]

cc = (n) -> # https://github.com/jonasjacek/colors with modifications
	helper = (n,big) -> [n%2*big, int(n/2)%2*big, int(n/4)*big]
	if n<8 then helper n,255
	else if n==8 then [192,192,192]
	else if n<16 then helper n-8,128
	else if n==16 then [64,64,64]
	else if n<232
		n-=16
		r=n%6; n//=6
		g=n%6; n//=6
		b=n
		lst = [0,95,135,175,215,255]
		[lst[r],lst[g],lst[b]]
	else
		n-=232
		z = lerp 8,18,n
		[z,z,z]

cct = (n) -> # makes text visible
	[r,g,b] = cc n
	if r+g+b >= 3*128 then [0,0,0] else [255,255,255]

sw = (n) -> strokeWeight n

circle = (x,y,r) -> ellipse x,y,2*r,2*r
rd = (vinkel) -> rotate radians vinkel
range = _.range

fillSelect = (sel, dict) ->
	sel.empty()
	for key of dict
		sel.append($("<option>").attr('value', key).text(key))

buildLink = (keyword) ->
	if keyword.indexOf('_.')==0 then keyword = keyword.replace('_.','')
	nr = kwl[keyword]
	if nr == undefined then return
	if nr==0 then keyword = keyword.toLowerCase()
	if nr==null
		null
	else
		keyword = keyword.replace('[]','array')
		keyword = keyword.replace('""','string')
		keyword = keyword.replace('{}','object')
		keyword = keyword.replace('->','pil')
		keyword = keyword.replace('@','this')
		keyword = keyword.replace('...','exclusiverange')
		keyword = keyword.replace('..','inclusiverange')
		keyword = keyword.replace('HSB','colorMode')
		kwlinks[nr].replace('{}',keyword)

buildKeywordLink = ->
	kwl = {}
	kwlinks = []
	kwlinks.push 'https://github.com/ChristerNilsson/p5Dojo/blob/master/README.md#{}'
	kwlinks.push 'https://p5js.org/reference/#/p5/{}'
	kwlinks.push 'https://www.w3schools.com/jsref/jsref_{}.asp'
	kwlinks.push 'https://github.com/ChristerNilsson/p5Dojo/blob/master/_.md#{}'
	save = (index,words) -> kwl[word] = index for word in words.split ' '
	save 0,'[] "" {} .. ... @ -> class text textSize textAlign textFont operators comparisons logical if bg fc sc sw'
	save 0,'range circle for while angleMode readText readInt readFloat'
	save 0,'PI sqrt atan2 abs cos sin log10 Date arc rect ellipse point line triangle quad arguments'
	save 0,'parseInt parseFloat dist nf constrain int round map lerp radians rotate reduce'
	save 1,'rectMode translate scale push pop random millis colorMode HSB strokeCap'
	save 2,'break return'
	save 3,'contains filter countBy isEqual last max min pairs sortBy findIndex'

# mousePressed = ->
# 	if meny.chapter=='' or meny.exercise=='' then return
# 	p = null
# 	if 0 <= mouseX-5 <= 200 and 0 <= mouseY-5 <= 200 then p = [mouseX-5,mouseY-5]
# 	if 0 <= mouseX-5 <= 200 and 0 <= mouseY-210 <= 200 then p = [mouseX-5,mouseY-210]
# 	if p
# 		dict = data[meny.chapter][meny.exercise].c
# 		if dict?
# 			objekt = _.keys(dict)[0]
# 			code = objekt + ".mousePressed(#{p[0]},#{p[1]}); " + objekt + ".draw(); " + objekt + ".store()"
# 			if run1(code) == true
# 				run0(code)
# 				compare()

decorate = (dict) -> # {klocka: "draw|incr_hour"}
	if dict==undefined then return {}
	if dict==null then return {}
	res = {}
	for objekt, s of dict
		methods = s.split "|"
		res["draw()"] = objekt + ".draw(); " + objekt + ".store()"
		res[method] = objekt + "." + method + "; " + objekt + ".draw(); " + objekt + ".store()" for method in methods
	res

changeLayout = ->
	w = $(window).width()
	$(".CodeMirror").width w-425
	$("#canvas").css {top: 0, left: 205, position:'absolute'}
	$("#msg").width w-430
	$("#input").width w-218

resizeTimer = 0
$(window).resize ->
		clearTimeout resizeTimer
		resizeTimer = setTimeout changeLayout, 10

updateTables = ->
	meny.rensa()
	meny.traverse()

items = []

demo = () -> 
	[chapter,exercise,cmd] = items.pop()
	document.getElementById("chapter").innerHTML = chapter
	document.getElementById("exercise").innerHTML = exercise
	document.getElementById("command").innerHTML = cmd
	print items.length,chapter,exercise,cmd
	meny = {exercise : exercise}
	calls = decorate data[chapter][exercise].c
	if cmd != ''
		if cmd in calls then code = calls[cmd]
		else code = "app.#{cmd}; app.draw()" # ; app.store()
		run1 chapter, exercise, code
	else
		run1 chapter, exercise, ""
	sleepTimer = 0
	clearTimeout sleepTimer
	delay = INTERVAL
	#if items.length>500 then delay = 50 
	#if cmd == '' then delay = 50 

	sleepTimer = setTimeout demo, delay

setup = ->

	#meny = new Menu data, document.getElementById "meny"
	#updateTables()

	timestamp = millis()
	c = createCanvas 3*201+10, 3*201+10

	#buildKeywordLink()

	gap = 5 * width * 4
	block = 201 * width * 4

	pixelDensity 1
	c.parent 'canvas'

	bg 0

	items = []
	for chapter,item1 of data
		if chapter not in ['Information','Exhibition']
			for exercise,item2 of item1
				if item2.d
					cmds = item2.d.split '|'
					for cmd in cmds 
						items.push [chapter,exercise,cmd]
				else
					items.push [chapter,exercise,'']
	items.reverse()
	demo()

window.onbeforeunload = ->
	return if document.URL.indexOf("record") == -1
	res = []
	for key1,chapter of data
		for key2,exercise of chapter
			if exercise.d
				res.push "### #{key1} ### #{key2}\n"
				for s,i in exercise.d
					res.push "=== #{i}\n"
					res.push s+"\n"
	blob = new Blob res, {type: "text/plain;charset=utf-8"}
	saveAs blob, "recording.txt"
	true

window.onload = ->

	# ta = document.getElementById "code"

	# myCodeMirror = CodeMirror.fromTextArea document.getElementById("code"), {
	# 	lineNumbers: true,
	# 	mode: "coffeescript",
	# 	keyMap: "sublime",
	# 	theme: "dracula",
	# 	autoCloseBrackets: true,
	# 	lineWiseCopyCut: true,
	# 	tabSize: 2,
	# 	indentWithTabs: true,
	# 	matchBrackets : true,
	# }

	# $(".CodeMirror").css 'font-size',"16pt"
	# myCodeMirror.on "change", editor_change

	# meny.chapter = ""
	# meny.exercise = ""

	# myCodeMirror.setValue '# Klicka först på L1:\n# Klicka därefter på Background1'

	# myCodeMirror.focus()
	# window.resizeTo 1000,750
	# changeLayout()
	# meny.setState 0

saveToKeyStorage = (b) ->
	s = ""
	for line in b.split '\n'
		if line.indexOf("#") != 0
			s += line
	place = data[meny.chapter][meny.exercise]
	if !place.d
		place.d = []
	place.d.push s

editor_change = ->
	reset()
	if meny.exercise=='' then return
	if 0 == _.size meny.calls
		code = ""
	else # transpile, draw
		code = meny.calls["draw()"]

	dce = data[meny.chapter][meny.exercise]
	if dce and dce.a and _.size(dce.a.c) > 0
		if false == run1 code then return # bör normalt vara true
	res = run0 code

	#if res # spara källkod EFTER exekvering
	saveSourceCode()
	compare()

saveSourceCode = ->	localStorage[meny.exercise + "/d"] = myCodeMirror.getValue()

run0 = (code) ->
	if meny.exercise=="" then return false
	src = myCodeMirror.getValue()
	run 0, src + "\n" + code

run1 = (chapter,exercise,code) ->
	if exercise=="" then return
	run 1, data[chapter][exercise].a + "\n" + code

reset = ->
	resetMatrix()
	colorMode RGB,255
	angleMode RADIANS
	rectMode CORNER
	strokeCap ROUND
	textAlign LEFT,BASELINE
	smooth() # pga SuperCircle
	bg 0
	fc 0
	sc 1
	sw 1

run = (_n, coffee) ->
	reset()
	push()
	translate 5,5
	scale 3
	grid()

	#setMsg "", _n

	#if meny.exercise == "" 
	#	pop()
	#	return true

	try
		code = transpile coffee

		try
			eval code
			buffer[1-_n] = store()
			pop()
			return true
		catch e
			#setMsg e, _n
			pop()
			return false
	catch e
		#setMsg e, _n
		pop()
		return false

store = ->
	loadPixels()
	pixels[gap...gap + block]

fetch = (buffer,y0) ->
	loadPixels()
	for i in range block
		pixels[gap + (gap+block)*y0 + i] = buffer[i]
	updatePixels()

fix_frames = ->
	loadPixels()
	for k in range 4
		for i in range gap
			pixels[(gap+block)*k+i] = 128-64
	for j in range height # 3*201+20
		for i in range 20
			pixels[j*width*4+i] = 128-64
			pixels[j*width*4+206*4+i] = 128-64
	updatePixels()

compare = ->  # Lägg en timer på denna. Bör vänta någon sekund
	a = buffer[0]
	b = buffer[1]
	c = a[..]

	if msg.val() == ''
		for i in range block/4
			i4 = 4*i
			c[i4+0] = abs c[i4+0] - b[i4+0]
			c[i4+1] = abs c[i4+1] - b[i4+1]
			c[i4+2] = abs c[i4+2] - b[i4+2]
			c[i4+3] = 255

	fetch a, 0
	if msg.val() == ''
		fetch b, 1
		fetch c, 2
	fix_frames()

tableClear = -> $("#tabell tr").remove()

tableAppend = (t, call, expected, actual) -> # exakt tre rader
	row = t.insertRow -1
	cell1 = row.insertCell -1
	cell2 = row.insertCell -1
	cell1.innerHTML = call
	cell2.innerHTML = JSON.stringify(expected)
	cell2.style.backgroundColor = '#00FF00'

	if _.isEqual(expected, actual) then return

	row = t.insertRow -1
	dummy = row.insertCell -1
	cell4 = row.insertCell -1
	cell4.innerHTML = JSON.stringify(actual)
	cell4.style.backgroundColor = '#FF0000'

	row = t.insertRow -1
	dummy = row.insertCell -1
	cell6 = row.insertCell -1
	cell6.innerHTML = firstDiff cell2.innerHTML,cell4.innerHTML

firstDiff = (a,b) -> # return index and differing characters
	res = ''
	if a==b then return ''
	for i in range _.min [a.length,b.length]
		res += if a[i] == b[i] then '·' else '^'
	res

fillTable = (a,b) ->
	try
		a = JSON.parse localStorage[a]
		b = JSON.parse localStorage[b]
		tableClear()
		keys = []
		keys.push key for key,value of a
		keys.push key for key,value of b
		sort keys
		keys = _.uniq keys

		for key in keys
			if key != '_name' and  key != '_type'
				tableAppend tabell, "@" + key,unmark(a[key]),unmark(b[key])
	catch

unmark = (obj) ->
	if _.isArray(obj) then return	(unmark item for item in obj) # array
	if _.isObject obj
		res = {}
		for key,value of obj
			res[key] = unmark(value) # if key != '_type'
		return res
	obj