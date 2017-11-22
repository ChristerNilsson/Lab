words = null
word = ''
lastWord = ''
level = -1
angle = 0
radius1 = 150
radius2 = 50
direction = 1

setup = ->
	createCanvas 400,400
	words = ordlista.split ' '
	textAlign CENTER,CENTER
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
	textSize 16
	text lastWord, width/2,height-32 
	textSize 64
	if direction == 1 then fc 0,1,0 else fc 1,0,0
	text level,width/2,height/2 
	fc 0
	translate width/2,height/2
	n = word.length
	dAngle = 360/n
	rd angle
	textSize 40
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

mousePressed = ->
	n = word.length
	dword = (word+word).toLowerCase()
	for ch,i in word
		x = width/2  + radius1 * cos(radians angle + i/n * 360)
		y = height/2 + radius1 * sin(radians angle + i/n * 360)
		if radius2 > dist mouseX,mouseY,x,y 
			w = dword.slice i,i+n
			if w in words then return newGame 1
	newGame -1
