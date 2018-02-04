words = null
index = 0
word = ''
angle = 0
storlek = null

radius1 = null # avstånd till gul cirkels mittpunkt
radius2 = null # gul cirkels radie
radius3 = null # avstånd till siffra
radius4 = null # gräns mellan siffror och bokstäver
radius5 = null # siffrans radie

possibleWords = []
solution = ""
dt = 0 
released = true 

setup = ->
	createCanvas windowWidth,windowHeight
	storlek = min width,height
	radius2 = storlek/12
	radius1 = 0.5*storlek-radius2 
	radius3 = 0.6*radius1
	radius4 = radius1 - radius2
	radius5 = 0.05*storlek
	radius6 = 0.59*storlek 
	ordlista = getParameters()
	if not ordlista.words then ordlista = 'ADAM,BERTIL'
	words = _.shuffle ordlista.words.split ','
	textAlign CENTER,CENTER
	newGame()

newGame = ->
	word = words[index]
	index++
	index = index % words.length
	if 0.5 < random() then word = reverseString word
	angle = 360 * random()
	false # to prevent double click on Android

draw = ->
	bg 0.5
	push()
	translate width/2,height/2
	textSize 0.06 * storlek 
	text solution, 0, 0
	pop()

	translate width/2,height/2
	n = word.length
	dAngle = 360/n
	rd angle
	textSize storlek/10
	for ch,i in word
		push()
		translate radius1,0
		rd 90
		fc 1,1,0
		circle 0,0,radius2
		fc 0
		text ch,0,0
		pop()
		rd dAngle
	angle += (millis()-dt)/50
	dt = millis()

handleMousePressed = ->
	if released then released = false else return # to make Android work 
	n = word.length
	dword = word + word
	for ch,i in word
		x = width/2  + radius1 * cos radians angle + i/n * 360
		y = height/2 + radius1 * sin radians angle + i/n * 360
		if radius2 > dist mouseX,mouseY,x,y 
			w = dword.slice i,i+n
			rw = reverseString(dword).slice n-i-1,n-i+n-1
			solution = w + "\n" + rw
			return newGame()

reverseString = (str) -> str.split("").reverse().join ""

mousePressed = ->
	handleMousePressed()
	false # to prevent double click on Android

touchStarted = ->
	handleMousePressed()
	false # to prevent double click on Android

mouseReleased = ->
	released = true 
	false # to prevent double click on Android

touchEnded = ->
	released = true 
	false # to prevent double click on Android
