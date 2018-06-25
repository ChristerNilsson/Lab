SIZE = 12
TILE = 60
FREE = -1
COLORS = null
KEY = '049-Twins'

level = null
maxLevel=null
numbers = null

b = null
selected = []
message = ''
buttons = []
path = []
pathTimestamp = null
hearts = null

class Hearts
	constructor : (@x,@y,@count=9,@maximum=9) -> 
	draw : ->
		for i in range @maximum
			x = @x + 25*i
			if i < @count
				fc 1,0,0
			else
				fc 0.5
			triangle x-11,@y, x+11,@y, x,@y+15 
			circle x-5,@y,5
			circle x+5,@y,5

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
	level = constrain n,2,maxLevel
	makeGame()

saveStorage = -> localStorage[KEY] = maxLevel
loadStorage = ->
	if KEY of localStorage 
		maxLevel = parseInt localStorage[KEY]
		print maxLevel
	else
		maxLevel = 2

setup = ->
	createCanvas 30+TILE*SIZE+30,100+TILE*SIZE+TILE
	rectMode CENTER
	makeColors()
	loadStorage()
	level = maxLevel
	buttons.push new Button 80,65,'-', -> newGame level-1
	buttons.push new Button 180,65,level, -> newGame level
	buttons.push new Button 280,65,'+', -> newGame level+1
	hearts = new Hearts width-240,110
	makeGame()
	#assert true,  setBoard 41,true,2,5,9,8,["","",""," 25"," 22 35 21       7"," 11 10 15","          5","  19 18   29","   33      30"]
	#assert false, setBoard 41,true,2,5,3,8,["","",""," 25"," 22 35 21       7"," 11 10 15","          5","  19 18   29","   33      30"]
	#assert false, setBoard 21,false,2,8,6,8,["","    17","","","        11","  7","     4   7","  5    7  15 10","  17   5 3 18 16 2 12","       8 13 15 9","  10  3    13 13"]
	#assert true,  setBoard 21,false,2,2,7,2,["","        20  5"," 18 1  17   19 16","  4 9 10  14 15 3","     9"]

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
	hearts.count = 9
	numbers = 100
	for i in range 50
		candidates.push i % level
		candidates.push level-1 - i % level
	candidates = _.shuffle candidates

	b = new Array SIZE
	for i in range SIZE
		b[i] = new Array SIZE
		for j in range SIZE
			if i in [0,SIZE-1] or j in [0,SIZE-1] then b[i][j] = FREE
			else b[i][j] = candidates.pop()

draw = ->
	bg 0.25
	sw 1
	buttons[1].txt = level-1

	for button in buttons
		button.draw()
	hearts.draw()

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
	drawPath()

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
		if b[i][j] + b[i1][j1] == level-1
			path = legal false,i1,j1,i,j
			if path.length == 0
				path = legal true,i1,j1,i,j
				if path.length == 0
					hearts.count -= 2 # Punish two
				else
					hearts.count -= 1 # Punish one
			b[i][j] = b[i1][j1] = FREE
			numbers -= 2
			selected.pop()
			if numbers==0
				if level == maxLevel 
					if hearts.count >= 0 
						maxLevel+=1
						level+=1
					else
						maxLevel-=1
						level-=1
				saveStorage()
				newGame level
			else
				if level == maxLevel 
					if hearts.count < 0 
						maxLevel-=1
						level-=1
						saveStorage()
						newGame level

makeMove = (wrap,x,y) -> if wrap then [x %% SIZE, y %% SIZE] else [x,y]

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
	if millis() > 1000 + pathTimestamp then path = []

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

# setBoard = (n,w,i0,j0,i1,j1,arr) ->
# 	level = n
# 	for j in range SIZE
# 		b[j] = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
# 	for row,j in arr
# 		for cell,i in row.split ' '
# 			b[i][j] = if cell=='' then -1 else parseInt cell
# 	legal i0,j0,i1,j1
