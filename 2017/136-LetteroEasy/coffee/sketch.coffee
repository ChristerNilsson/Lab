wordList = null
words = null
index = 0
word = ''
level = 0
angle = 0
direction = 1
size = null
group = 0 # 1 av 25 om cirka 200 ord 

radius1 = null # avstånd till gul cirkels mittpunkt
radius2 = null # gul cirkels radie
radius3 = null # avstånd till siffra
radius4 = null # gräns mellan siffror och bokstäver
radius5 = null # siffrans radie

possibleWords = []
solution = ""
dt = 0 
released = true 
buttons = []

class Button
	constructor : (@txt,@r1,@degrees,@r2,@f) ->
		@x = @r1 * cos radians @degrees
		@y = @r1 * sin radians @degrees

	draw : ->
		fc 0.45
		circle @x,@y,@r2
		fc 0
		text @txt,@x,@y

	mousePressed : (mx,my) -> if @r2 > dist(mx,my,width/2+@x,height/2+@y) then @f()

fetchFromLocalStorage = ->
	s = localStorage["letteroEasy-#{group}"]
	if s 
		arr = s.split ' '
		level = parseInt arr[0]
	else
		level = 0
	#print 'fetch',group,level

saveToLocalStorage = -> 
	#print 'save',group,level
	localStorage["letteroEasy-#{group}"] = "#{level}"

setup = ->

	for grupp,i in ordlista
		ordlista[i] = grupp.split ' '

	fetchFromLocalStorage()

	createCanvas windowWidth,windowHeight
	size = min width,height
	radius2 = size/12
	radius1 = 0.5*size-radius2 
	radius3 = 0.6*radius1
	radius4 = radius1 - radius2
	radius5 = 0.05*size
	radius6 = 0.59*size 
	wordList = _.shuffle ordlista[group]
	words = selectWords()
	for word,i in words
		words[i] = words[i].toLowerCase()
	textAlign CENTER,CENTER

	buttons.push new Button '+', radius6, 45,    radius2, () => selGroup 1 
	buttons.push new Button '-', radius6, 45+90, radius2, () => selGroup -1
	newGame 0

selGroup = (d) ->
	saveToLocalStorage()
	group = (group + d) %% ordlista.length
	fetchFromLocalStorage()
	words = selectWords()

newGame = (dLevel) ->
	solution = possibleWords.join ' '
	direction = dLevel
	extra = int level/10 # straffa med 10% av level.
	if dLevel < 0 and extra != 0 then dLevel *= extra
	level += dLevel
	if level < 0 then level = 0
	word = words[index]
	index = (index+1) % words.length
	possibleWords = findWords word
	if 0.5 < random() then word = reverseString word
	word = word.toUpperCase()
	angle = 360 * random()
	saveToLocalStorage()
	false # to prevent double click on Android

wrap = (first,last,value) -> first + (value-first) %% (last-first+1)

draw = ->
	bg 0.5

	push()
	translate width/2,height/2

	textSize 0.09 * size 
	for button in buttons
		button.draw()
		
	textSize 0.11 * size 
	text "#{1+200*group}-#{200*(group+1)}",0,-0.2*size 
	textSize 0.06 * size 
	text solution, 0, 0.18*size

	pop()

	textSize size/4
	if direction == 1 then fc 0,1,0 else fc 1,0,0
	text level,width/2,height/2 
	fc 0
	translate width/2,height/2
	n = word.length
	dAngle = 360/n
	rd angle
	textSize size/10
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

selectWords = -> _.shuffle ordlista[group]

handleMousePressed = ->
	if released then released = false else return # to make Android work 
	if dist(mouseX,mouseY,width/2,height/2) < radius2 
		showWordInfo()
	else if dist(mouseX,mouseY,width/2,height/2) > radius1+radius2 
		for button in buttons
			button.mousePressed mouseX,mouseY
	else
		# letter	
		n = word.length
		dword = (word+word).toLowerCase()
		for ch,i in word
			x = width/2  + radius1 * cos radians angle + i/n * 360
			y = height/2 + radius1 * sin radians angle + i/n * 360
			if radius2 > dist mouseX,mouseY,x,y 
				w = dword.slice i,i+n
				rw = reverseString(dword).slice n-i-1,n-i+n-1
				if w in possibleWords or rw in possibleWords
					return newGame 1
				else
					return newGame -1

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

findWords = (word) ->
	n = word.length
	dword = (word+word).toLowerCase()
	res = []
	for ch,i in word
		w = dword.slice i,i+n
		rw = reverseString(dword).slice n-i-1,n-i+n-1
		if w in words then res.push w
		if rw in words then res.push rw
	_.uniq res
