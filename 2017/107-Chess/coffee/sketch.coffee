MOVES =
	King   : [false,[[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]]
	Queen  : [true,[[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]]
	Rook   : [true,[[-1,0],[1,0],[0,-1],[0,1]]]
	Bishop : [true,[[-1,-1],[1,1],[1,-1],[-1,1]]]
	Knight : [false,[[-1,-2],[-1,2],[1,-2],[1,2],[-2,-1],[-2,1],[2,-1],[2,1]]]

currentPiece = 'King'
currentCol = 4
currentRow = 0

setup = ->
	createCanvas 200,200
	xdraw()

genDir = (multi,sq,dxdy) ->
	[dx,dy] = dxdy
	squares = []
	maximum = if multi then 7 else 1
	[col,row] = sq
	for i in range maximum
		col += dx
		row += dy
		if 0<=col<=7 and 0<=row<=7 then squares.push [col,row]
	squares

oneGeneration = (piece,sq) ->
	[multi,drag] = piece
	squares = []
	squares = squares.concat genDir multi,sq,dxdy for dxdy in drag
	squares

xdraw = ->
	bg 1
	textAlign RIGHT,CENTER
	textSize 13

	for i in range 8
		for j in range 8
			fc (i+j+1)%2
			rect 20*i,20*j,20,20

	fc 0
	for piece,i in _.keys MOVES
		text piece,200,10+20*i

	sq = [currentCol,currentRow]
	[x,y] = sq
	fc 0,1,0
	circle 10+20*x,10+20*y,5

	fc 1,0,0
	for [x,y] in oneGeneration MOVES[currentPiece],sq
		circle 10+20*x,10+20*y,5

assert [[5,5]], genDir false,[4,4],[1,1]
assert [[3,3],[2,2],[1,1],[0,0]], genDir true,[4,4],[-1,-1]
assert [[3,4],[5,4],[4,3],[4,5],[3,3],[5,5],[5,3],[3,5]], oneGeneration MOVES['King'],[4,4]
assert [[3,4],[2,4],[1,4],[0,4],[5,4],[6,4],[7,4],[4,3],[4,2],[4,1],[4,0],[4,5],[4,6],[4,7]],	oneGeneration MOVES['Rook'],[4,4]

mousePressed = ->
	if mouseX < 160
		currentCol = int mouseX/20
		currentRow = int mouseY/20
	else
		currentPiece = _.keys(MOVES)[int mouseY/20]
	xdraw()
