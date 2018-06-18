
# Lägg till två stjärnor
# Hantera felaktiga drag
# Kunna ångra första valet.
# Hantera hängning

SIZE = 12
TILE = 40
FREE = -1
N = 5
b = null

selected = []
message = ''

setup = ->
	createCanvas 800,800
	rectMode CENTER
	textSize 32
	makeGame()

makeGame = ->
	candidates = []
	for i in range 20
		for j in range 5
			candidates.push j
	candidates = _.shuffle candidates

	b = new Array SIZE
	for i in range SIZE
		b[i] = new Array SIZE
		for j in range SIZE
			if i in [0,SIZE-1] or j in [0,SIZE-1]
				b[i][j] = FREE
			else
				b[i][j] = candidates.pop()

draw = ->
	bg 1 
	translate TILE,TILE
	textAlign CENTER,CENTER
	fc 1
	sc 0
	for i in range SIZE
		for j in range SIZE
			fc 0.5
			sc 0
			rect TILE*i,TILE*j,TILE,TILE
			cell = b[i][j]
			if cell >= 0 
				fill ["#000","#f00","#0f0","#00f","#ff0"][cell]
				sc()
				text b[i][j],TILE*i,TILE*j
	text selected,10,SIZE*TILE
	for [i,j] in selected
		fc 1,1,0,0.5
		sc()
		circle TILE*i,TILE*j,TILE/2-3

mousePressed = ->
	[i,j] = [(mouseX-TILE/2)//TILE,(mouseY-TILE/2)//TILE]
	if not (0 <= i <= 11 and 0 <= j <= 11) then return 
	if selected.length == 0 
		if b[i][j] != FREE then selected.push [i,j]
	else
		[i1,j1] = selected[0]
		if i==i1 and j==j1 then return selected.pop()
		if b[i][j] + b[i1][j1] == 4 and (legal(i,j,i1,j1) or legal(i1,j1,i,j)) 
			b[i][j] = b[i1][j1] = FREE
			selected.pop()

legal = (i0,j0,i1,j1) ->
	start = [0,i0,j0,-1]
	cands = []
	cands.push start
	reached = {}
	reached[[i0,j0]] = start
	while cands.length > 0
		front = cands
		front.sort (a,b) -> a[0]-b[0]
		cands = []
		for [turns0,x0,y0,index0] in front
			for [dx,dy],index in [[-1,0],[1,0],[0,-1],[0,1]]
				[x,y] = [x0+dx,y0+dy]
				key = [x,y]
				turns = turns0
				if index != index0 and index0 != -1 then turns++
				next = [turns,x,y,index]
				if x==i1 and y==j1 then return 2 >= turns
				if 0 <= x <= 11 and 0 <= y <= 11 
					if b[x][y]==FREE
						if key not of reached or reached[key][0] > next[0]
							reached[key] = next
							cands.push next
	false