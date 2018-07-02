# Internt används talen 1..100. Externt visas de som 0..99
# Då ett tal plockats bort negeras det. Dessa visas gråa och förminskade.
# Ramens celler innehåller 0.

SIZE = 12
TILE = 60
FREE = 0
COLORS = '#fff #f00 #0f0 #ff0 #f0f #0ff #800 #080 #d00'.split ' '
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
showLittera = false 
showShadow = true
hints = []
lastHints = []
latestPair = []

class Hearts
	constructor : (@x,@y,@count=9,@maximum=9) -> 

	draw : ->
		for i in range @maximum
			x = @x + 60*i
			if i < @count
				@drawHeart x,@y,10,1,0,0
			else
				@drawHeart x,@y,10,0.5,0.5,0.5

	drawHeart : (x,y,n,r,g,b) ->
			fc r,g,b
			sc r,g,b
			sw n
			dx = 1.2*n
			y -= 0.8*n
			y1 = y+0.6*n
			y2 = y+2.2*n
			line x-dx,y1, x,y2
			line x+dx,y1, x,y2
			line x,y+0.5*n,x,y+2*n
			sc()
			circle x-n,y,n
			circle x+n,y,n

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
loadStorage = -> maxLevel = if KEY of localStorage then parseInt localStorage[KEY] else maxLevel = 2

setup = ->
	canvas = createCanvas 30+TILE*SIZE+30,50+TILE*SIZE+TILE
	canvas.position 0,0 # hides text field used for clipboard copy.

	rectMode CENTER
	loadStorage()
	level = maxLevel
	buttons.push new Button 60,40,'-', -> newGame level-1
	buttons.push new Button 120,40,level, -> # showLittera = not showLittera
	buttons.push new Button 180,40,'+', -> newGame level+1
	hearts = new Hearts 240,35

	if -1 != window.location.href.indexOf 'level'
		urlGame()
	else
		makeGame()
	showMoves()

urlGame = ->
	params = getParameters()
	level = parseInt params.level
	b = JSON.parse params.b
	size = 5+level//4 
	if size>12 then size=12
	hearts.count = size - 3
	hearts.maximum = size - 3
	numbers = (size-2)*(size-2)
	if numbers%2==1 then numbers -= 1
	milliseconds0 = millis()
	state = 'running'	

makeGame = ->
	level += delta
	maxLevel += delta
	delta = 0
	saveStorage()

	size = 5+level//4 
	if size>12 then size=12
	hearts.count = size - 3
	hearts.maximum = size - 3

	numbers = (size-2)*(size-2)
	if numbers%2==1 then numbers -= 1

	candidates = []
	for i in range numbers/2
		candidates.push 1 + i % level
		candidates.push 1 + level-1 - i % level
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
	link = makeLink()
	copyToClipboard link
	print link 

makeLink = -> 
	url = window.location.href + '?'
	index = url.indexOf '?'
	url = url.substring 0,index
	url += '?b=' + JSON.stringify b
	url += '&level=' + level
	url

drawRect = (i,j) ->
	fc 0
	sc 0.25
	sw 1
	rect TILE*i,TILE*j,TILE,TILE

drawNumber = (cell,i,j) ->
	cell -= 1 
	sw 3
	fill   COLORS[cell%%COLORS.length]
	stroke COLORS[cell//COLORS.length]
	text cell,TILE*i,TILE*j

drawShadow = (i,j) ->
	if showShadow
		sw 3
		fill 48
		stroke 48 
		if -b[i][j]-1 in latestPair
			text -b[i][j]-1, TILE*i,TILE*j				

draw = ->
	bg 0.25
	sw 1
	buttons[1].txt = level-1

	for button in buttons
		button.draw()
	hearts.draw()

	translate TILE,TILE+50
	textAlign CENTER,CENTER
	fc 1
	sc 0
	textSize 0.8 * TILE
	for i in range size
		for j in range size
			drawRect i,j
			cell = b[i][j]
			if cell > 0 then drawNumber cell,i,j
			else if cell == FREE
			else drawShadow i,j
			if i in [0,size-1] or j in [0,size-1] then drawLittera i,j
	for [i,j] in selected
		fc 1,1,0,0.5
		sc()
		circle TILE*i,TILE*j,TILE/2-3
	drawPath()
	if state=='halted'
		fc 1,1,0,0.5
		x = (size-1)*TILE/2
		y = (size-1)*TILE/2
		w = size*TILE
		h = size*TILE
		rect x,y,w,h
		ms = round(milliseconds1-milliseconds0)/1000
		if ms > 0
			y = size*TILE-10
			fc 1
			sc()
			textSize 20
			text ms,x,y
	if millis() < deathTimestamp
		x = size//2*TILE
		y = size//2*TILE
		if size % 2 == 0 then [x,y] = [x-TILE/2, y-TILE/2]
		hearts.drawHeart x,y,size*TILE/5,1,0,0

	drawHints()

drawHints = ->
	textSize 24
	if lastHints.length == 0
		msg0 = "#{hints[0]}"
		msg1 = "#{hints[1]}"
	else
		msg0 = "#{hints[0]} (#{hints[0]-lastHints[0]})"
		msg1 = "#{hints[1]} (#{hints[1]-lastHints[1]})"
	fc 0,1,0
	text msg0,0,height-127
	fc 1,0,0
	text msg1,width-100,height-127

drawLittera = (i,j) ->
	if showLittera
		push()
		textSize 32
		fc 0.25
		sc 0.25
		if j in [0,size-1] and i < size-1
			text ' abcdefghik '[i],TILE*i,TILE*j
		else if i in [0,size-1] and 0<j<size-1
			text size-1-j,TILE*i,TILE*j
		pop()

within = (i,j) -> 0 <= i < size and 0 <= j < size

mousePressed = ->
	if state=='halted' 
		newGame level
		return
	for button in buttons
		if button.inside mouseX,mouseY then button.click()
	[i,j] = [(mouseX-TILE/2)//TILE,(mouseY-50-TILE/2)//TILE]
	if not within i,j then return

	if i in [0,size-1] or j in [0,size-1] 
		showLittera = not showLittera
		return

	if b[i][j] < 0
		showShadow = not showShadow 
		return

	if selected.length == 0
		if b[i][j] > 0 then selected.push [i,j]
	else
		[i1,j1] = selected[0]
		if i==i1 and j==j1 then return selected.pop()
		if b[i][j]-1 + b[i1][j1]-1 != level-1
			hearts.count -= 1 # Punish one, wrong sum
			deathTimestamp = 200 + millis()
			selected.pop()
		else
			path = legal false,i1,j1,i,j
			if path.length == 0
				path = legal true,i1,j1,i,j
				if path.length == 0
					hearts.count -= 2 # Punish two, anything goes
				else
					hearts.count -= 1 # Punish one, wrap
				deathTimestamp = 200 + millis()
			latestPair = [b[i][j]-1,b[i1][j1]-1]
			#print latestPair
			b[i][j] = -b[i][j] 
			b[i1][j1] = -b[i1][j1] 
			numbers -= 2
			selected.pop()
			if numbers==0
				milliseconds1 = millis()
				state = 'halted'
				#if level == maxLevel 
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
					if b[x][y] <= 0
						if key not of reached or reached[key][0] >= next[0]
							if next[0] < 3
								reached[key] = next
								cands.push next
	[]

copyToClipboard = (txt) ->
	copyText = document.getElementById "myClipboard"
	copyText.value = txt 
	copyText.select()
	document.execCommand "copy"

showMoves = -> 
	lastHints = hints
	hints = [showMoves1(false), showMoves1(true)]
showMoves1 = (wrap) ->
	res = []
	for i0 in range 1,size-1
		for j0 in range 1,size-1
			if b[i0][j0] > 0 
				for i1 in range 1,size-1
					for j1 in range 1,size-1
						if b[i1][j1] > 0 
							if b[i0][j0]-1 + b[i1][j1]-1 == level-1
								if b[i0][j0] <= b[i1][j1] and (i0!=i1 or j0!=j1)
									path = legal wrap,i0,j0,i1,j1 
									if path.length > 0
										if [b[i0][j0]-1,b[i1][j1]-1] not in res 
											res.push [b[i0][j0]-1,b[i1][j1]-1]
	res.length