SIZE = 12
TILE = 60
FREE = -1
N = 5
b = null
COLORS = null

selected = []
message = ''
buttons = []
wrap = false

class Button
	constructor : (@x,@y,@txt,@click) -> @r=50
	inside : (x,y) -> @r > dist @x,@y,x,y
	draw : ->
		fc 0.5
		sc()
		circle @x,@y,@r
		fc 0
		textSize 30
		text @txt,@x,@y

newGame = (n) ->
	N = constrain n,2,100
	makeGame()

setup = ->
	createCanvas 30+TILE*SIZE+30,100+TILE*SIZE+TILE
	rectMode CENTER
	makeColors()
	makeGame()
	buttons.push new Button 80,65,'-', -> newGame N-1
	buttons.push new Button 180,65,N, ->
	buttons.push new Button 280,65,'+', -> newGame N+1
	buttons.push new Button width-80,65,'', -> wrap = not wrap

mybrightness = (s) ->
	res = 0
	for ch in s
		res += "0123456789abcdef#".indexOf ch
	res

makeColors = ->
	COLORS = []
	for i in "05af"
		for j in "05af"
			for k in "05af"
				COLORS.push "#"+i+j+k
	COLORS = _.without COLORS, "#000", "#005", "#00a"
	COLORS.sort (a,b) -> mybrightness(b) - mybrightness(a)

makeGame = ->
	candidates = []
	for i in range 50
		candidates.push i % N
		candidates.push N-1 - i % N
	candidates = _.shuffle candidates

	b = new Array SIZE
	for i in range SIZE
		b[i] = new Array SIZE
		for j in range SIZE
			if i in [0,SIZE-1] or j in [0,SIZE-1] then b[i][j] = FREE
			else b[i][j] = candidates.pop()

draw = ->
	bg 0.25
	buttons[1].txt = N-1
	buttons[3].txt = if wrap then 'wrap' else 'nowrap'

	for button in buttons
		button.draw()

	textSize 0.8 * TILE	
	translate TILE,TILE+100
	textAlign CENTER,CENTER
	fc 1
	sc 0
	for i in range SIZE
		for j in range SIZE
			fc 0
			sc 1
			rect TILE*i,TILE*j,TILE,TILE
			cell = b[i][j]
			if cell >= 0 
				fill COLORS[cell%%COLORS.length]
				sc()
				text b[i][j],TILE*i,TILE*j
	for [i,j] in selected
		fc 1,1,0,0.5
		sc()
		circle TILE*i,TILE*j,TILE/2-3

within = (i,j) -> 0 <= i < SIZE and 0 <= j < SIZE

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.click()
	[i,j] = [(mouseX-TILE/2)//TILE,(mouseY-100-TILE/2)//TILE]
	if not within i,j then return 
	if selected.length == 0 
		if b[i][j] != FREE then selected.push [i,j]
	else
		[i1,j1] = selected[0]
		if i==i1 and j==j1 then return selected.pop()
		if b[i][j] + b[i1][j1] == N-1 
			if legal(i1,j1,i,j) or legal(i,j,i1,j1) or bridge(i,j,i1,j1)
				b[i][j] = b[i1][j1] = FREE
				selected.pop()

makeMove = (x,y) -> if wrap then [x%%SIZE,x%%SIZE] else [x,y]

# A*. This algorithm blocks itself sometimes.
# That's why bridge is also used.
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
				[x,y] = makeMove x0+dx,y0+dy
				key = [x,y]
				turns = turns0
				if index != index0 and index0 != -1 then turns++
				next = [turns,x,y,index]
				if x==i1 and y==j1 then return 2 >= turns
				if within x,y
					if b[x][y]==FREE
						if key not of reached or reached[key][0] > next[0]
							reached[key] = next
							cands.push next
	false

getlst = (x0,y0,dx,dy) ->
	resx = []
	resy = []
	[x,y] = makeMove x0+dx,y0+dy 
	while within x,y
		if b[x][y] != FREE then return [resx,resy]
		resx.push x
		resy.push y
		[x,y] = makeMove x+dx,y+dy 
	[resx,resy]

getrows = (x0,x1) ->
	res = []
	for y in range SIZE
		found = false 
		for x in range x0,x1 
			if b[x][y] != FREE then found = true 
		if not found then res.push y
	res

getcols = (y0,y1) ->
	res = []
	for x in range SIZE
		found = false 
		for y in range y0,y1 
			if b[x][y] != FREE then found = true 
		if not found then res.push x
	res

bridge = (x0,y0,x1,y1) ->
	lst1 = getlst(x0,y0,0,-1)[1].concat getlst(x0,y0,0,1)[1]
	lst2 = getlst(x1,y1,0,-1)[1].concat getlst(x1,y1,0,1)[1]
	lst3 = getrows _.min([x0,x1])+1,_.max([x0,x1])
	lst4 = _.intersection lst1, lst2, lst3 

	lst1 = getlst(x0,y0,-1,0)[0].concat getlst(x0,y0,1,0)[0]
	lst2 = getlst(x1,y1,-1,0)[0].concat getlst(x1,y1,1,0)[0]
	lst3 = getcols _.min([y0,y1])+1,_.max([y0,y1])
	lst5 = _.intersection lst1, lst2, lst3 

	lst4.length > 0 or lst5.length > 0
