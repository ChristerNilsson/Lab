thinkingTime = 10 # 10 milliseconds is ok
UCB = 2

SIZE = 600/(N+1)
level = 0
list = null
moves = null
board = null
delta = 0
montecarlo = null
antal = 0

setup = ->
	createCanvas 600,600
	newGame()
	textAlign CENTER,CENTER
	textSize SIZE/2

newGame = () ->
	antal = 0
	print ' '
	level += delta
	if level < 0 then level = 0
	delta = -2

	board = new Board()
	list = ([] for i in range 7)
	moves = []
	montecarlo = null
	#computerMove()

draw = ->
	bg 0
	fc()
	sc 0.1,0.3,1
	sw 0.2 * SIZE
	for i in range N
		x = SIZE + i*SIZE
		for j in range M
			y = height-SIZE - SIZE*j
			circle x, y, SIZE/2

	for column,i in list
		x = SIZE + i*SIZE
		for nr,j in column
			y = height-SIZE - SIZE*j
			fc 1,nr%2,0
			sw 1
			circle x, y, SIZE*0.4
			fc 0
			sc()
			text nr, x, y+4
	sc()
	fc 1
	msg = ['','Datorn vann!','Remis!','Du vann!'][delta+2]
	text msg,width/2,SIZE/2-10
	text level,SIZE/2,SIZE/2-10
	#text UCB,width-50,SIZE/2-10

computerMove = ->
	if moves.length < 2 
		montecarlo = new MonteCarlo new Node null,null,board
	else
		human = moves[moves.length-1]
		dator = moves[moves.length-2]
		montecarlo.root = montecarlo.root.children[dator].children[human]
		montecarlo.root.parent = null

	start = Date.now()
	result = montecarlo.runSearch 2**level
	print 'ms=',Date.now()-start, 'games='+montecarlo.root.n, 'nodes='+antal
	print montecarlo	

	#montecarlo.dump montecarlo.root
	#print ''

	m = montecarlo.bestPlay montecarlo.root
	moves.push m
	board.move m
	list[m].push moves.length
	if board.done() then return delta = -1
	if board.moves.length == M*N then delta = 0	

mousePressed = ->
	antal=0
	if delta != -2 then return newGame()
	if mouseX<SIZE/2 or mouseX>=width-SIZE/2 or mouseY>=height then return
	nr = int (mouseX-SIZE/2)/SIZE

	if 0 <= nr <= N
		if list[nr].length == M then return
		moves.push nr
		board.move nr
		list[nr].push moves.length

	if board.done() then return delta = 1

	computerMove()

undo : -> if moves.length > 0 then list[moves.pop()].pop()

######

	# board = new Board '3233224445230330044022166666'
	# print board
	# moves = [3, 2, 3, 3, 2, 2, 4, 4, 4, 5, 2, 3, 0, 3, 3, 0, 0, 4, 4, 0, 2, 2, 1, 6, 6, 6, 6, 6]
	# list = []
	# list.push [13,16,17,20]
	# list.push [23]
	# list.push [2,5,6,11,21,22]
	# list.push [1,3,4,12,14,15]
	# list.push [7,8,9,18,19]
	# list.push [10]
	# list.push [24,25,26,27,28]

	#montecarlo = new MonteCarlo new Node null,null,board
