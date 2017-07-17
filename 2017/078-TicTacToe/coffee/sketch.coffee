MARKERS = 'XO'
WINNERS = [7,56,448,73,146,292,273,84]

buttons = null
marks = [0,0]
state = ''

setup = ->
	createCanvas 400,400
	textAlign CENTER,CENTER
	textSize 90
	newGame()

newGame = ->
	buttons = [[0,0,''],[0,1,''],[0,2,''],[1,0,''],[1,1,''],[1,2,''],[2,0,''],[2,1,''],[2,2,'']]
	marks = [0,0]
	state = ''

ai = -> _.sample (i for button,i in buttons when button[2] == '')

draw = ->
	for [x,y,txt] in buttons
		fc 1
		rect 100*x,100*y,100,100
		fc 0
		text txt,100*x+50,100*y+50
		fc 1,0,0
		text state,150,150

check = (player,index) ->
	if state != '' then return
	buttons[index][2] = MARKERS[player]
	marks[player] |= 1 << index
	for winner in WINNERS
		if (winner & marks[player]) == winner
			state = MARKERS[player] + ' wins!'

mousePressed = ->
	if state != '' then return newGame()
	mx = int mouseX/100
	my = int mouseY/100
	for [x,y,txt] in buttons
		index = 3*x+y
		if mx==x and my==y and txt==''
			check 0,index
			check 1,ai()