SIZE = 12
TILE = 60
FREE = -1
COLORS = null
KEY = '049-Twins'

size = null
level = null
maxLevel=null
numbers = null

b = null
selected = []
message = ''
buttons = []
path = []
pathTimestamp = null
deathTimestamp = null
hearts = null
milliseconds0 = null
milliseconds1 = null
state = 'halted' # 'running' 'halted'
delta = 0
found = null

class Hearts
	constructor : (@x,@y,@count=9,@maximum=9) -> 
	draw : ->
		for i in range @maximum
			x = @x + 60*i
			if i < @count
				fc 1,0,0
				sc 1,0,0
			else
				fc 0.5
				sc 0.5
			sw 10
			line x-15,@y+2, x,@y+20
			line x,   @y, x,@y+20
			line x+15,@y+2, x,@y+20
			sw 1
			circle x-10,@y,10
			circle x+10,@y,10

class Button
	constructor : (@x,@y,@txt,@click) -> @r=24
	inside : (x,y) -> @r > dist @x,@y,x,y
	draw : ->
		fc 0.5
		if level == maxLevel then sc 1 else sc()
		sw 2
		circle @x,@y,@r
		fc 0
		textSize 30
		sc()
		text @txt,@x,@y

newGame = (n) ->
	if n in [1,maxLevel+1] then return 
	level = constrain n,2,maxLevel
	makeGame()

saveStorage = -> localStorage[KEY] = maxLevel
loadStorage = ->
	if KEY of localStorage 
		maxLevel = parseInt localStorage[KEY]
	else
		maxLevel = 2

setup = ->
	createCanvas 30+TILE*SIZE+30,50+TILE*SIZE+TILE
	rectMode CENTER
	makeColors()
	loadStorage()
	level = maxLevel
	buttons.push new Button 60,40,'-', -> newGame level-1
	buttons.push new Button 120,40,level, -> newGame level
	buttons.push new Button 180,40,'+', -> newGame level+1
	hearts = new Hearts 240,35
	makeGame()
	showMoves()

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

	maxLevel += delta
	level += delta
	delta = 0
	saveStorage()

	size = 5+level//4 
	if size>12 then size=12
	hearts.count = size-3
	hearts.maximum = size-3

	numbers = (size-2)*(size-2)
	if numbers%2==1 then numbers -= 1

	for i in range numbers/2
		candidates.push i % level
		candidates.push level-1 - i % level
	candidates = _.shuffle candidates

	b = new Array size
	for i in range size
		b[i] = new Array size
		for j in range size
			if i in [0,size-1] or j in [0,size-1] then b[i][j] = FREE
			else 
				if size % 2 == 0
					b[i][j] = candidates.pop()
				else
					if i == size//2 and j == size//2
						b[i][j] = FREE
					else
						b[i][j] = candidates.pop()
	milliseconds0 = millis()
	state = 'running'

draw = ->
	bg 0.25
	sw 1
	buttons[1].txt = level-1

	for button in buttons
		button.draw()
	hearts.draw()

	textSize 0.8 * TILE
	translate TILE,TILE+50
	textAlign CENTER,CENTER
	fc 1
	sc 0
	for i in range size
		for j in range size
			fc 0
			sc 1
			rect TILE*i,TILE*j,TILE,TILE
			cell = b[i][j]
			if cell >= 0 
				fill COLORS[cell%%COLORS.length]
				sc 0
				text b[i][j],TILE*i,TILE*j
	for [i,j] in selected
		fc 1,1,0,0.5
		sc()
		circle TILE*i,TILE*j,TILE/2-3
	drawPath()
	if state=='halted'
		fc 1,1,0,0.5
		x = size//2*TILE
		y = size//2*TILE
		w = size*TILE
		h = size*TILE
		rect x,y,w,h
		ms = round(milliseconds1-milliseconds0)/1000
		if ms > 0
			y = size*TILE
			fc 1
			sc()
			textSize 20
			text ms,x,y
	if millis() < deathTimestamp
		sc 1,0,0
		sw 5
		fc()
		x = size//2*TILE-TILE/2
		y = size//2*TILE-TILE/2
		w = size*TILE
		h = size*TILE
		rect x,y,w,h

	[i0,j0,i1,j1,z,z] = found		
	fc()
	circle TILE*i0,TILE*j0,TILE/2-3
	circle TILE*i1,TILE*j1,TILE/2-3


within = (i,j) -> 0 <= i < size and 0 <= j < size

mousePressed = ->
	if state=='halted' 
		newGame level
		return
	for button in buttons
		if button.inside mouseX,mouseY then button.click()
	[i,j] = [(mouseX-TILE/2)//TILE,(mouseY-50-TILE/2)//TILE]
	if not within i,j then return
	if selected.length == 0
		if b[i][j] != FREE then selected.push [i,j]
	else
		[i1,j1] = selected[0]
		if i==i1 and j==j1 then return selected.pop()
		if b[i][j] + b[i1][j1] == level-1
			path = legal false,i1,j1,i,j
			if path.length == 0
				path = legal true,i1,j1,i,j
				if path.length == 0
					hearts.count -= 2 # Punish two, anything goes
				else
					hearts.count -= 1 # Punish one, wrap
				deathTimestamp = 200 + millis()
			b[i][j] = b[i1][j1] = FREE
			numbers -= 2
			selected.pop()
			if numbers==0
				milliseconds1 = millis()
				state = 'halted'
				if level == maxLevel 
					if hearts.count >= 0 then delta = 1 else delta = -1
			else
				if level == maxLevel 
					if hearts.count < 0 
						state = 'halted'
						delta = -1
	showMoves()

makeMove = (wrap,x,y) -> if wrap then [x %% size, y %% size] else [x,y]

makePath = (wrap,reached,i,j) ->
	res = []
	key = "#{i},#{j}"
	[turns0,i0,j0,indexes0] = reached[key]
	[i,j] = [i0,j0]
	res.push [i,j]
	pathTimestamp = millis()
	indexes0.reverse()
	for index in indexes0
		[di,dj] = [[1,0],[-1,0],[0,1],[0,-1]][index]
		[i,j] = makeMove wrap,i+di,j+dj
		res.push [i,j]
	res

drawPath = ->
	if path.length == 0 then return 
	sw 3
	sc 1,1,0
	[i1,j1] = path[0]
	for [i2,j2] in path
		if 1 == dist i1,j1,i2,j2
			line TILE*i1,TILE*j1,TILE*i2,TILE*j2
		[i1,j1] = [i2,j2]
	if millis() > 500 + pathTimestamp then path = []

# A*
legal = (wrap,i0,j0,i1,j1) ->
	start = [0,i0,j0,[]] # turns,x,y,move
	cands = []
	cands.push start
	reached = {}
	reached[[i0,j0]] = start
	while cands.length > 0
		front = cands
		front.sort (a,b) -> a[0]-b[0]
		cands = []
		for [turns0,x0,y0,indexes0] in front
			for [dx,dy],index in [[-1,0],[1,0],[0,-1],[0,1]]
				[x,y] = makeMove wrap,x0+dx,y0+dy
				key = "#{x},#{y}"
				turns = turns0
				if indexes0.length > 0 and index != _.last(indexes0) then turns++
				next = [turns,x,y,indexes0.concat [index]]
				if x==i1 and y==j1 and turns<=2
					reached[key] = next
					return makePath wrap,reached,i1,j1
				if within x,y
					if b[x][y]==FREE
						if key not of reached or reached[key][0] >= next[0]
							if next[0] < 3
								reached[key] = next
								cands.push next
	[]

showMoves = ->
	res = showMoves1 false
	if res.length==0
		res = showMoves1 true
	if res.length>0
		found = res[0]
	print res

showMoves1 = (wrap) ->
	res = []
	for i0 in range 1,size-1
		for j0 in range 1,size-1
			if b[i0][j0] != FREE 
				for i1 in range 1,size-1
					for j1 in range 1,size-1
						if b[i1][j1] != FREE 
							if b[i0][j0] + b[i1][j1] == level-1
								if b[i0][j0] <= b[i1][j1] and (i0!=i1 or j0!=j1)
									path = legal wrap,i0,j0,i1,j1 
									if path.length>0
										res.push [i0,j0,i1,j1,b[i0][j0],b[i1][j1]]
	res