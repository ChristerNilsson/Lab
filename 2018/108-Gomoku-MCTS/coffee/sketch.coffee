thinkingTime = 1000
UCB = 2

SIZE = 600//(N+1)
level = 0
moves = null
board = null
delta = 0
montecarlo = null
antal = 0

setup = ->
	createCanvas 600,660
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
	moves = []
	montecarlo = null
	#computerMove()

showSurr = ->
	for index in board.surr
		#if index not in board.moves
		row = 1 + index//N
		col = 1 + index%%N
		sc 0,1,0
		fc()
		circle SIZE*col,SIZE*row,10

draw = ->
	bg 0
	fc()
	sc 0.1,0.3,1
	sw 0.2 * SIZE
	for index in range M*N
		r = index // N
		c = index %% N
		x = SIZE*(c+1)
		y = SIZE*(r+1)
		circle x, y, SIZE/2

	sw 1
	for index,i in moves
		r = index // N
		c = index %% N
		x = SIZE*(c+1)
		y = SIZE*(r+1)
		fc 1,i%2,0
		circle x, y, SIZE*0.4
		fc 0
		sc()
		text i, x, y+4
	sc()
	fc 1
	msg = ['','Computer Wins!','Remis!','You win!'][delta+2]
	text msg,width/2,height-SIZE/2-10
	text level,SIZE/2,height-SIZE/2-10
	#text UCB,width-50,SIZE/2-10
	showSurr()	

computerMove = ->
	montecarlo = new MonteCarlo new Node 0,0,null,board
	start = Date.now()
	result = montecarlo.runSearch 2**level
	print 'ms=',Date.now()-start, 'games='+montecarlo.root.n, 'nodes='+antal
	print montecarlo	

	#montecarlo.dump montecarlo.root
	#print ''

	m = montecarlo.bestPlay montecarlo.root
	moves.push m
	board.move m
	if board.done() then return delta = -1
	if board.moves.length == M*N then delta = 0	

mousePressed = ->
	antal = 0
	if delta != -2 then return newGame()
	row = int (mouseY - SIZE / 2) / SIZE
	col = int (mouseX - SIZE / 2) / SIZE
	if not (0 <= row < N) then return
	if not (0 <= col < N) then return
	index = row*N + col

	if 0 <= index < M*N
		moves.push index
		board.move index

	if board.done() then return delta = 1

	computerMove()

# undo : -> if moves.length > 0 then list[moves.pop()].pop()
