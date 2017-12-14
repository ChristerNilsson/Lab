# ordlista: sorterad sträng 
wordList = null # sorterad array, alla ord
words = null # osorterad array med word.length <= maxWord
index = 0
word = ''
level = 0
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
maxWord = 4 # 4..15
languages = 'dan eng fra ger isl ita nor rus spa swe'.split ' '
language = 9
currentLanguage = language
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
	lang = languages[language]
	s = localStorage["lettero-#{lang}"]
	if s 
		arr = s.split ' '
		maxWord = parseInt arr[0]
		level = parseInt arr[1]
	else
		maxWord = 4
		level = 0

saveToLocalStorage = -> 
	lang = languages[language]
	localStorage["lettero-#{lang}"] = "#{maxWord} #{level}"

setup = ->

	language = languages.indexOf document.title.toLowerCase().split(' ')[1] 
	currentLanguage = language

	fetchFromLocalStorage()

	createCanvas windowWidth,windowHeight
	size = min width,height
	radius2 = size/12
	radius1 = 0.5*size-radius2 
	radius3 = 0.6*radius1
	radius4 = radius1 - radius2
	radius5 = 0.05*size
	radius6 = 0.59*size 

	wordList = ordlista.split ' '
	wordList.sort() 
	words = selectWords()

	textAlign CENTER,CENTER
	buttons.push new Button '15',  radius6, 45,     radius2, () => maxWordSize 1 
	buttons.push new Button '4',   radius6, 45+90,  radius2, () => maxWordSize -1
	buttons.push new Button 'spa', radius6, 45+270, radius2, () => selLanguage 1
	buttons.push new Button 'dan', radius6, 45+180, radius2, () => selLanguage -1
	newGame 0

maxWordSize = (d) ->
	maxWord = 4 + (maxWord-4+d) %% (15-4+1) 
	saveToLocalStorage()
	words = selectWords()

selLanguage = (d) ->
	n = languages.length
	language = (language+d) %% n 

newGame = (dLevel) ->
	if language != currentLanguage 
		# go to another html file
		window.location.href = "#{languages[language]}.html"

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

	saveToLocalStorage()

	false # to prevent double click on Android

wrap = (first,last,value) -> first + (value-first) %% (last-first+1)

draw = ->
	bg 0.5

	push()
	translate width/2,height/2

	buttons[0].txt = wrap(4,15,maxWord+1)
	buttons[1].txt = wrap(4,15,maxWord-1)
	n = languages.length
	buttons[2].txt = languages[(language+1)%%n]
	buttons[3].txt = languages[(language-1)%%n]	

	textSize 0.09 * size 
	for button in buttons
		button.draw()
		
	textSize 0.11 * size 
	text "#{languages[language]}-#{maxWord}",0,-0.2*size 
	textSize 0.06 * size 
	text solution, 0, 0.18*size

	pop()

	#text solution + '|' + possibleWords.join(' '), width/2,height-size/10

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
	index = 0
	_.shuffle (w for w in wordList when w.length <= maxWord)

showWordInfo = -> 
	arr = solution.split ' '
	if arr.length == 0 then return 
	released = true 
	url = ''
	lan = languages[language] 
	if lan == 'swe' then url = "https://svenska.se/tre/?sok=#{arr[0]}"
	#if lan == 'eng' then url = "https://en.oxforddictionaries.com/definition/#{arr[0]}"
	if url != '' then window.open url, '_blank' 

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
		if wordList.binaryIndexOf(w) != -1 then res.push w
		if wordList.binaryIndexOf(rw)!= -1 then res.push rw
	_.uniq res

Array.prototype.binaryIndexOf = (item) ->
	'use strict'
	minIndex = 0
	maxIndex = @length - 1
	while minIndex <= maxIndex
		currIndex = (minIndex + maxIndex) / 2 | 0
		currItem = @[currIndex]
		if currItem < item then minIndex = currIndex + 1
		else if currItem > item then maxIndex = currIndex - 1
		else return currIndex
	-1
