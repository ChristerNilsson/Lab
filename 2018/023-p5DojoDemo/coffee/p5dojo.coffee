# todo: Code Mirror hanterar inte toggleComment via Ctrl+/

# if the renew button is available, a new version of the b code is available.
# Clicking renew prints the current b code on the console as a backup.

INTERVAL = 1000
currentItem = 0
chapter = ''
exercise = ''
cmd = ''
delay = 59
demoState = 1

myCodeMirror = null
msg = null

kwl = {}
kwlinks = []

gap = 0
block = 0
buffer = [[],[],[]]

meny = null

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

showText = ->
	[chapter,exercise,cmd] = items[currentItem] #.pop()
	document.getElementById("chapter").innerHTML  = "   Level: " + chapter
	document.getElementById("exercise").innerHTML = "Exercise: " + exercise
	document.getElementById("command").innerHTML  = " Command: " + cmd
	document.getElementById("seconds").innerHTML  = "   Frame: " + currentItem + " " + ["(Paused)",""][demoState]
	document.getElementById("info").innerHTML  = "Use Left, Right and Space keys"

draw = -> 
	#print items.length,chapter,exercise,cmd
	showText()
	meny = {exercise : exercise}
	calls = decorate data[chapter][exercise].c

	if delay == 60
		code = "app.#{cmd}; app.draw(); app.store()"
		if demoState == 1 then currentItem++
		delay--
	else 
		code = 'app.draw()'
		delay--
	if delay==0 then delay = 60
	if demoState == 1 then run1 chapter, exercise, code

keyPressed = ->
	if keyCode == 32 then demoState = 1 - demoState
	if keyCode == 37 then currentItem--
	if keyCode == 39 then currentItem++
	currentItem %%= items.length

setup = ->

	timestamp = millis()
	c = createCanvas 3*201+10, 3*201+10

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

saveToKeyStorage = (b) ->
	s = ""
	for line in b.split '\n'
		if line.indexOf("#") != 0
			s += line
	place = data[meny.chapter][meny.exercise]
	if !place.d
		place.d = []
	place.d.push s

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

	try
		code = transpile coffee

		try
			eval code
			buffer[1-_n] = store()
			pop()
			return true
		catch e
			pop()
			return false
	catch e
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