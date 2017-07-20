EMPTY = ' '
MARKERS = 'XO'
WINNERS = [1+2+4,8+16+32,64+128+256,1+8+64,2+16+128,4+32+256,1+16+256,4+16+64]

marks = null
state = null
hist = null

ai = -> _.sample _.difference range(9), hist

drawOnce = ->
	for index in range 9
		[x,y] = [100 * (index%3), 100 * int index/3]
		fc 1
		rect x,y,100,100
		fc 0
		if index in hist then text MARKERS[hist.indexOf(index)%2], x+50,y+50
	fc 1,0,0
	text state,150,150

mousePressed = ->
	if state != '' then return newGame()
	index = (int mouseX/100) + 3 * int mouseY/100
	if index not in hist
		move 0,index
		if hist.length==9 then state = 'draw!' else move 1,ai()
		drawOnce()

move = (player,position) ->
	if state != '' then return
	hist.push position
	marks[player] |= 1 << position
	for winner in WINNERS
		if (winner & marks[player]) == winner then state = MARKERS[player] + ' wins!'

newGame = ->
	marks = [0,0]
	state = ''
	hist = []
	drawOnce()

setup = ->
	createCanvas 400,400
	textAlign CENTER,CENTER
	textSize 90
	newGame()