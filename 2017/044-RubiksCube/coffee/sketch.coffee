board = []
memory = null
state = 0 # unmarked
level = 0
turns = []
buttons = [[40,140,level], [160,140,"new"]]

tiles=[[0,1,42,41,40,   2,3,9,16,15,    4,5,20,19,18,   6,7,31,30,29]
			[9,10,40,39,38,  11,12,49,48,47, 13,14,22,21,20, 15,16,4,3,2]
			[18,19,6,5,4,    20,21,15,14,13, 22,23,47,46,45, 24,25,33,32,31]
			[27,28,36,43,42, 29,30,0,7,6,    31,32,18,25,24, 33,34,45,52,51]
			[36,37,51,50,49, 38,39,11,10,9,  40,41,2,1,0,    42,43,29,28,27]
			[45,46,24,23,22, 47,48,13,12,11, 49,50,38,37,36, 51,52,27,34,33]]

newGame = () ->
	level = level + if level==turns.length then 1 else -1
	level = constrain level,1,100
	turns = []
	board = []
	board.push i for i in range 54
	lastSide = -1
	for i in range level
		side = lastSide
		while lastSide==side
			side = _.sample range 6
		op side, _.sample [-1,1]
		lastSide = side

undo = () ->
	if turns.length==0 then return
	[k,d] = turns.pop()
	op k,-d

turn = (a,b) -> # a,b in 0..54
	if int(a/9) != int(b/9) then return
	d = (a%9 - b%9)/2
	if d in [-3,3] then d = -d/3
	if d not in [-1,1] then return
	k = int a/9
	op k,d
	turns.push [k,d]

op = (k,d) -> # 0..5, [-1,1]
	arr = tiles[k]
	carr = (board[i] for i in arr)
	limit = if d==1 then 5 else 15
	carr = carr[limit..20].concat carr[0..limit]
	board[arr[i]] = carr[i] for i in range 20

setup = ->
	createCanvas 200,200
	textAlign CENTER,CENTER
	newGame()

colorize = (index) ->
	k = int board[index] / 9
	[r,g,b] = [[1,1,1],[0,0,1],[1,0,0],[0,1,0],[0.97, 0.57, 0],[1,1,0]][k]
	fc r,g,b

textcolorize = (index) -> fc [0,1,1,0,0,0][int board[index] / 9]

rita = (x,y,index,tilt) ->
	a = 16
	b = 9
	colorize index
	if tilt == 0 then quad x-a,y, x,y-b, x+a,y, x,y+b
	if tilt == 1 then quad x+a/2,y-b/2, x-a/2,y-3*b/2, x-a/2,y+b/2, x+a/2,y+3*b/2
	if tilt == 2 then quad x-a/2,y-b/2, x+a/2,y-3*b/2, x+a/2,y+b/2, x-a/2,y+3*b/2
	textcolorize index
	text board[index],x,y
	if index == memory and state == 1 then circle x,y,4
	false

sense = (x,y,index,tilt) -> dist(x,y,mouseX,mouseY) < 9

draw = ->
	bg 0.5
	textSize 12
	traverse rita
	fc 1,1,0
	textSize 20
	buttons[0][2] = level - turns.length
	text txt,x,y for [x,y,txt] in buttons

traverse = (f) ->
	a = 16
	b = 9
	y0 = 60

	for index in range 54
		side = int index / 9

		if side==0 # vit
			i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
			j = [0,1,2,2,2,1,0,0,1][index % 9]
			if f 100+a*(i+j-1),y0+b*(i-j+1), index, 0 then return index
		if side==1 # blå
			i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
			j = [0,1,2,2,2,1,0,0,1][index % 9]
			if f 100+a*(i+4.5),y0+b*(2*j+i-3.5), index, 1 then return index
		if side==2 # röd
			i = [-1,0,1,1,1,0,-1,-1,0][index % 9]
			j = [0,0,0,1,2,2,2,1,1][index % 9]
			if f 100+a*(i+1.5),y0+b*(2*j-i+2.5), index, 2 then return index
		if side==3 # grön
			i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
			j = [2,1,0,0,0,1,2,2,1][index % 9]
			if f 100+a*(i-1.5),y0+b*(2*j+i+2.5), index, 1 then return index
		if side==4 # orange
			i = [-1, 0, 1, 1, 1, 0,-1,-1, 0][index % 9]
			j = [ 2, 2, 2, 1, 0, 0, 0, 1, 1][index % 9]
			if f 100+a*(i-4.5),y0+b*(2*j-i-3.5), index, 2 then return index
		if side==5 # gul
			i = [ 1, 1, 1, 0,-1,-1,-1, 0, 0][index % 9]
			j = [ 0, 1, 2, 2, 2, 1, 0, 0, 1][index % 9]
			if f 100+a*(i+j-1),y0+b*(i-j+13), index, 0 then return index

mousePressed = ->
	for [x,y,txt],i in buttons
		if dist(mouseX,mouseY,x,y) < 10
			if i==0 then return undo()
			if i==1 then return newGame()

	if state == 0
		memory = traverse sense
		if memory? and memory%9!=8 then state = 1
	else
		index = traverse sense
		if index? then turn memory,index
		state = 0