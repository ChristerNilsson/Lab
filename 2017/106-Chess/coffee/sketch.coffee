King   = [false,[[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]]
Queen  = [true,[[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]]
Rook   = [true,[[-1,0],[1,0],[0,-1],[0,1]]]
Bishop = [true,[[-1,-1],[1,1],[1,-1],[-1,1]]]
Knight = [false,[[-1,-2],[-1,2],[1,-2],[1,2],[-2,-1],[-2,1],[2,-1],[2,1]]]

setup = ->
	createCanvas 400,400
	xdraw()

genDir = (multi,sq,dxdy) ->
	[dx,dy] = dxdy
	squares = []
	if multi then maximum = 7 else maximum = 1
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

recurse = (level,piece,front,reached) ->
	if front.length==0 then return reached
	candidates = []
	candidates = candidates.concat oneGeneration piece,sq for sq in front
	newFront = []
	for candidate in candidates
		key = candidate.toString()
		if key not in _.keys reached
			reached[key] = level
			newFront.push candidate
	recurse level+1, piece, newFront, reached

solve = (piece,sq) ->
	reached = {}
	reached[sq.toString()] = 0
	recurse 1,piece,[sq],reached

xdraw = ->
	rectMode CENTER
	textAlign CENTER,CENTER
	textSize 20
	for i in range 8
		for j in range 8
			fc (i+j+1)%2
			rect 20+20*i,20+20*j,20,20

	reached = solve Knight,[0,0]
	fc 1,0,0
	for key,level of reached
		arr = key.split ','
		col = int arr[0]
		row = 7-int arr[1]
		text level, 20+20*col,20+20*row

assert [[5,5]], genDir false,[4,4],[1,1]
assert [[3,3],[2,2],[1,1],[0,0]], genDir true,[4,4],[-1,-1]
assert [[3,4],[5,4],[4,3],[4,5],[3,3],[5,5],[5,3],[3,5]], oneGeneration King,[4,4]
assert [[3,4],[2,4],[1,4],[0,4],[5,4],[6,4],[7,4],[4,3],[4,2],[4,1],[4,0],[4,5],[4,6],[4,7]],	oneGeneration Rook,[4,4]

reached = solve Knight,[4,5]
assert 0, reached['4,5']
assert 1, reached['2,4']
assert 2, reached['3,2']
assert 3, reached['2,0']
assert 4, reached['0,1']

reached = solve Knight,[0,0]
assert 6, reached['7,7']
