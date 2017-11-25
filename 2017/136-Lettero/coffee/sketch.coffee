words = null
word = ''
level = -1
angle = 0
direction = 1
size = null
radius1 = null
radius2 = null
clickedWords = []
correctWord = null

setup = ->
	createCanvas windowWidth,windowHeight
	size = min windowWidth,windowHeight
	radius2 = size/10
	radius1 = size/2-radius2 
	words = ordlista.split ' '
	textAlign CENTER,CENTER
	#listCircular()
	newGame 1

newGame = (dLevel) ->
	if clickedWords.length==0 then clickedWords.push correctWord
	direction = dLevel
	extra = int level/10 # straffa med 10% av level.
	if dLevel < 0 and extra != 0 then dLevel *= extra
	level += dLevel
	if level < 0 then level = 0
	correctWord = _.sample words
	word = correctWord.toUpperCase()
	if 0.5 < random() then word = reverseString word
	angle = 360 * random()
	false # to prevent double click on Android

draw = ->
	bg 0.5
	textSize size/10
	text clickedWords.join(' '), width/2,height-size/10
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
	angle += 0.5

handleMousePressed = ->
	n = word.length
	dword = (word+word).toLowerCase()
	for ch,i in word
		x = width/2  + radius1 * cos radians angle + i/n * 360
		y = height/2 + radius1 * sin radians angle + i/n * 360
		if radius2 > dist mouseX,mouseY,x,y 
			w = dword.slice i,i+n
			rw = reverseString(dword).slice n-i-1,n-i+n-1
			clickedWords = []
			if w in words then clickedWords.push w 
			if rw in words then clickedWords.push rw
			return newGame if clickedWords.length==0 then -1 else 1
	false # to prevent double click on Android

reverseString = (str) -> str.split("").reverse().join ""
mousePressed = ->	handleMousePressed()
touchStarted = -> handleMousePressed()

listCircular = () ->
	print words.length
	antal = 0 
	for word in words
		n = word.length
		dword = (word+word).toLowerCase()
		res = []
		for ch,i in word
			w = dword.slice i,i+n
			if w in words then res.push w
		if res.length == 2
			antal++
	print antal