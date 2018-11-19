M = 6  # antal rader
N = 7  # antal kolumner

SIZE = 700/N
PROBES = 20

level = 0
list = null
moves = null
dator = null
human = null
board = null
delta = 0

setup = ->
	createCanvas 700,700
	dator = new Computer()
	human = new Human()
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
		x = SIZE/2 + i*SIZE
		for j in range M
			y = height-SIZE/2 - SIZE*j
			circle x, y, SIZE/2

	for column,i in list
		x = SIZE/2 + i*SIZE
		for nr,j in column
			y = height-SIZE/2 - SIZE*j
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
	nr = int (mouseX-(width-N*SIZE)/2)/SIZE
	if 0 <= nr <= M
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

class Human
	constructor : -> @move = -1 
