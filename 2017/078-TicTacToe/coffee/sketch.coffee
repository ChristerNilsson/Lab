EMPTY = ' '
MARKERS = 'XO'
WINNERS = [1+2+4,8+16+32,64+128+256,1+8+64,2+16+128,4+32+256,1+16+256,4+16+64]

buttons = null
marks = null
state = null

setup = ->
	createCanvas 400,400
	textAlign CENTER,CENTER
	textSize 90
	newGame()

newGame = ->
	buttons = (EMPTY for i in range 9)
	marks = [0,0]
	state = ''

ai = -> _.sample (i for owner,i in buttons when owner == EMPTY)

draw = ->
	for owner,index in buttons
		[x,y] = [100 * (index%3), 100 * int index/3]
		fc 1
		rect x,y,100,100
		fc 0
		text owner,x+50,y+50
	fc 1,0,0
	text state,150,150

check = (player,index) ->
	if state != '' then return
	buttons[index] = MARKERS[player]
	marks[player] |= 1 << index
	for winner in WINNERS
		if (winner & marks[player]) == winner then state = MARKERS[player] + ' wins!'

mousePressed = ->
	if state != '' then return newGame()
	index = (int mouseX/100) + 3 * int mouseY/100
	if buttons[index] == EMPTY
		check 0,index
		check 1,ai()