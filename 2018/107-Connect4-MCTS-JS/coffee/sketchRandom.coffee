M = 6  # antal rader
N = 7  # antal kolumner

SIZE = 600/(N+1)
PROBES = 1000 # 10

level = 0
list = null
moves = null
dator = null
board = null
delta = 0

#################
game = new Game()
mcts = new MonteCarlo(game)
state = game.start()
winner = game.winner(state)
#################

setup = ->
	createCanvas 600,600
	dator = new Computer()
	newGame()
	textAlign CENTER,CENTER
	textSize SIZE/2

newGame = () ->
	level += delta
	if level < 0 then level = 0
	delta = -2
	board = new Board()
	list = ([] for i in range 7)
	moves = []

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
			text nr, x, y
	sc()
	fc 1
	msg = ['','Datorn vann!','Remis!','Du vann!'][delta+2]
	text msg,width/2,SIZE/2-10
	text level,SIZE/2,SIZE/2-10

mousePressed = ->
	if delta != -2 then return newGame()
	if mouseX<SIZE/2 or mouseX>=width-SIZE/2 or mouseY>=height then return
	nr = int (mouseX-SIZE/2)/SIZE

	if 0 <= nr <= N
		if list[nr].length == M then return
		moves.push nr
		board.move nr
		list[nr].push moves.length

	if board.done() then return delta = 1
	m = dator.move board
	moves.push m
	board.move m
	list[m].push moves.length
	if board.done() then return delta = -1
	if board.moves.length == M*N then delta = 0



undo : -> if moves.length > 0 then list[moves.pop()].pop()
