words = null
word = ''
lastWord = ''
level = -1
angle = 0
direction = 1
size = null
radius1 = null
radius2 = null
client = null

setup = ->
	createCanvas windowWidth,windowHeight
	size = min windowWidth,windowHeight
	client = info()
	radius2 = size/10
	radius1 = size/2-radius2 
	words = ordlista.split ' '
	textAlign CENTER,CENTER
	#listCircular()
	newGame 1

newGame = (dLevel) ->
	direction = dLevel
	level += dLevel
	if level < 0 then level = 0
	lastWord = word
	word = _.sample words
	word = word.toUpperCase()
	angle = 360 * random()

draw = ->
	bg 0.5
	textSize size/10
	text lastWord, width/2,height-size/10
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
			if w in words then return newGame 1
	newGame -1

mousePressed = ->
	if client.istouch_device then handleMousePressed()
	false

touchStarted = ->
	if not client.istouch_device then handleMousePressed()
	false	

info = ->
	ratio = window.devicePixelRatio || 1
	ratio : ratio
	is_touch_device : 'ontouchstart' in document.documentElement
	sw : screen.width 
	sh : screen.height
	cw : document.documentElement.clientWidth
	ch : document.documentElement.clientHeight
	rw : screen.width * ratio
	rh : screen.height * ratio

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