# Originalkod i 136-Lettero
# Kopieras till 140-LetteroEng

wordList = null
words = null
index = 0
word = ''
level = -1
angle = 0
direction = 1
size = null

radius1 = null # avstånd till gul cirkels mittpunkt
radius2 = null # gul cirkels radie
radius3 = null # avstånd till siffra
radius4 = null # gräns mellan siffror och bokstäver
radius5 = null # siffrans radie

possibleWords = []
solution = ""
dt = 0 
maxWords = [4,5,6,7,8,9]
maxWord = 0

setup = ->
	createCanvas windowWidth,windowHeight
	size = min width,height
	radius2 = size/10
	radius1 = size/2-radius2 
	radius3 = 0.6*radius1
	radius4 = radius1 - radius2
	radius5 = size/20
	wordList = _.shuffle ordlista.split ' '
	words = selectWords()
	textAlign CENTER,CENTER
	#listCircular()
	print wordList.length
	newGame 1

newGame = (dLevel) ->
	solution = possibleWords.join ' '
	direction = dLevel
	extra = int level/10 # straffa med 10% av level.
	if dLevel < 0 and extra != 0 then dLevel *= extra
	level += dLevel
	if level < 0 then level = 0
	word = words[index]
	index++
	index %= words.length
	possibleWords = findWords word
	if 0.5 < random() then word = reverseString word
	word = word.toUpperCase()
	angle = 360 * random()
	false # to prevent double click on Android

drawMaxWord = ->
	push()
	translate width/2,height/2
	textSize 2 * radius5
	for ch,i in maxWords
		push()
		translate radius3,0
		rd 90
		if maxWord == i then fc 1 else fc 0
		text ch,0,0
		pop()
		rd 60
	pop()

draw = ->
	bg 0.5
	drawMaxWord()
	textSize size/12
	text solution, width/2,height-size/10
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

selectWords = -> 
	wordList = _.shuffle ordlista.split ' '
	index = 0
	w for w in wordList when w.length <= maxWords[maxWord]

handleMousePressed = ->
	if dist(mouseX,mouseY,width/2,height/2) < radius1-radius2 
		# digit
		n = maxWords.length
		for i in range n
			x = width/2  + radius3 * cos radians i/n * 360
			y = height/2 + radius3 * sin radians i/n * 360
			if radius5 > dist mouseX,mouseY,x,y
				maxWord = i
				words = selectWords()
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
	false # to prevent double click on Android

reverseString = (str) -> str.split("").reverse().join ""
mousePressed = ->	handleMousePressed()
touchStarted = -> handleMousePressed()

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

# listCircular = () ->
# 	print words.length
# 	antal = 0
# 	for word in words
# 		res = findWords word
# 		if res.length==2
# 			print res.join ' '
# 			antal++
# 	print antal