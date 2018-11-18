SIZE = 600/7

level = 0
list = null
moves = null
x = null # Dator
o = null # Human
board = null
delta = 0

setup = ->
	createCanvas 600,600
	x = new Computer 'Dator'
	o = new Human 'Human'
	newGame()

newGame = () ->
	level += delta
	if level < 0 then level = 0
	delta = -2
	board = new Board()
	list = ([] for i in range 7)
	moves = []

draw = ->
	bg 0
	textAlign CENTER,CENTER
	textSize SIZE/2
	fc()
	sc 0.1,0.3,1
	sw 0.2 * SIZE
	for i in range 7
		for j in range 6
			circle width/2-SIZE*3+SIZE*i, height-SIZE/2-SIZE*j, SIZE/2
	for column,i in list
		for nr,j in column
			fc 1,nr%2,0
			sw 1
			circle width/2-SIZE*3+SIZE*i, height-SIZE/2-SIZE*j, SIZE*0.4
			fc 0
			sc()
			text nr, width/2-SIZE*3+SIZE*i, height-SIZE/2-SIZE*j
	sc()
	fc 1
	msg = ''
	if delta == -1 then msg = 'Datorn vann!'
	if delta == 0 then msg = 'Remis!'
	if delta == 1 then msg = 'Du vann!'
	text msg,width/2,SIZE/2
	text level,50,50

mousePressed = ->
	if delta != -2 then return newGame()
	nr = int (mouseX-(width-7*SIZE)/2)/SIZE
	if 0 <= nr <= 6
		if list[nr].length==6 then return
		moves.push nr
		board.move nr
		list[nr].push moves.length

	if board.calc() then return delta = 1
	m = x.move board
	moves.push m
	board.move m
	list[m].push moves.length
	if board.calc() then return delta = -1
	if board.moves.length == 42 then delta = 0

undo : -> if moves.length > 0 then list[moves.pop()].pop()

class Human
	constructor : -> @move = -1 
