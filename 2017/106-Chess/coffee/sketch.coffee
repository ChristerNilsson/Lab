# Visa i hur många drag man kan nå en viss ruta.
# Välj pjäs
# Välj ruta
# Nu visas ett tal i varje ruta.

moves =
	K : [false,[[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]]
	Q : [true,[[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]]
	R : [true,[[-1,0],[1,0],[0,-1],[0,1]]]
	B : [true,[[-1,-1],[1,1],[1,-1],[-1,1]]]
	N : [false,[[-1,-2],[-1,2],[1,-2],[1,2],[-2,-1],[-2,1],[2,-1],[2,1]]]

setup = ->
	createCanvas 400,400
	xdraw()

genDir = (multi,sq,dx,dy) ->
	squares = []
	if multi then maximum = 7 else maximum = 1
	[col,row] = sq
	for i in range maximum
		col += dx
		row += dy
		if 0 <= col <= 7 and 0<=row <= 7 then squares.push [col,row]
	squares

oneGeneration = (piece,sq) ->
	[multi,drag] = moves[piece]
	squares = []
	for [dx,dy] in drag
		squares = squares.concat genDir multi,sq,dx,dy
	squares

recurse = (level,piece,front,reached) ->
	if front.length==0 then return reached
	candidates = []
	for sq in front
		candidates = candidates.concat oneGeneration piece,sq
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
			fc (i+j)%2
			rect 20+20*i,20+20*j,20,20

	reached = solve 'N',[4,5]
	fc 1,0,0
	for key,level of reached
		arr = key.split ','
		col = 1+int arr[0]
		row = 1+7-int arr[1]
		text level, 20*col,20*row

# assert [[5,5]], genDir false,4,4,1,1
# assert [[3,3],[2,2],[1,1],[0,0]], genDir true,4,4,-1,-1
# assert [[3,4],[5,4],[4,3],[4,5],[3,3],[5,5],[5,3],[3,5]], oneGeneration 'King',4,4
# assert [[3,4],[2,4],[1,4],[0,4],[5,4],[6,4],[7,4],[4,3],[4,2],[4,1],[4,0],[4,5],[4,6],[4,7]],	oneGeneration 'Rook',4,4

#print solve 'King',[4,4]
