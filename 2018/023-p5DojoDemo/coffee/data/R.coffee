ID_RandomDice =
	v:'2017-05-21'
	k:'bg sc circle operators [] int for class'
	l:18
	b: """
class RandomDice extends Application
	reset : ->
		super
		@seed = 0
	draw : ->
	mousePressed : (mx,my) ->
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
app = new RandomDice
"""
	a:"""
class RandomDice extends Application
	reset : ->
		super
		@seed = 0
		@throw()
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	throw : -> @value = 1 + @randint 6
	mousePressed : (mx,my) -> @throw()
	draw : ->
		bg 1
		sc 1
		coords = []
		if @value in [1,3,5] then coords.push [100,100]
		if @value in [4,5,6] then coords = coords.concat [[150,150],[ 50,50]]
		if @value in [2,3,4,5,6] then coords = coords.concat [[ 150,50],[ 50,150]]
		if @value in [6] then coords = coords.concat [[ 150,100],[ 50,100]]
		circle x,y,20 for [x,y] in coords
app = new RandomDice "a"

"""
	c:
		app : "reset()"

ID_RecursiveCircle =
	v:'2017-04-29'
	k:'sc circle if return operators class'
	l:10
	b: """
class RecursiveCircle extends Application
	reset   : ->
		super
	draw    : ->
	circles : (x,y,r,level) ->
	mousePressed : (mx,my) ->
app = new RecursiveCircle
"""
	a: """

class RecursiveCircle extends Application
	reset : ->
		super
		@n = 0
	draw : -> @circles 100,100,100,@n
	circles : (x,y,r,level) ->
		circle x,y,r
		if level <= 0 then return
		@circles x-r/2, y, r/2, level-1
		@circles x+r/2, y, r/2, level-1
	mousePressed : (mx,my) -> @n = constrain @n + (if my < 100 then 1 else -1),0,10

app = new RecursiveCircle "a"
"""
	c:
		app : "reset()"

ID_RedCone =
	v:'2017-04-29'
	k:'range fc circle for lerp'
	l:6
	b:""
	a:"""
for i in range 10,0,-1
	fc i/10.0,0,0
	x = 10*i
	y = 10*i
	r = 10*i
	circle x,y,r
"""

# ID_RedRect =
# 	v:'2017-04-29'
# 	k:'fc rect'
# 	l:2
# 	b:""
# 	a:"""
# fc 1,0,0
# rect 80,70, 40,100
# """

ID_Reversi =
	v:'2017-05-02'
	k:'sc fc bg range [] rect circle while if operators class'
	l:49
	b: """
class Reversi extends Application
	reset : ->
		super
	draw : ->
	mousePressed : (mx,my) ->
app = new Reversi
"""
	a: """
class Reversi extends Application
	reset : ->
		super
		@newGame()
	newGame : ->
		@board = []
		@drag = 0
		for j in range 8
			@board.push []
			for i in range 8
				@board[j].push 0
		@board[3][3]=2 # White
		@board[3][4]=1 # Black
		@board[4][3]=1
		@board[4][4]=2
	draw : ->
		sc 0
		for i in range 8
			for j in range 8
				sq = @board[j][i]
				fc 0,1,0
				rect 20+20*i, 20+20*j,20,20
				if sq in [1,2]
					fc sq-1
					circle 30.5+20*i, 30.5+20*j,10-2
	move : (i,j) ->
		res = []
		mycol = 1 + @drag % 2
		other = [0,2,1][mycol]
		for di in [-1,0,1]
			for dj in [-1,0,1]
				if not (di==0 and dj==0)
					i1=i+di
					j1=j+dj
					temp = []
					while 0 <= i1 < 8 and 0 <= j1 < 8 and @board[j1][i1] == other
						temp.push [i1,j1]
						i1 = i1+di
						j1 = j1+dj
					if 0 <= i1 < 8 and 0 <= j1 < 8 and @board[j1][i1] == mycol
						if temp.length > 0 then	res = res.concat temp
		if res.length > 0
			@board[j][i] = mycol
			for [i,j] in res then	@board[j][i] = mycol
			@drag++
	mousePressed : (mx,my) ->
		i = int mx / 20 - 1
		j = int my / 20 - 1
		if 0 <= i < 8 and 0 <= j < 8 and @board[j][i] == 0 then @move i,j

app = new Reversi "a"
"""
	c:
		app : "reset()"
	e:
		Reversi : "https://en.wikipedia.org/wiki/Reversi"

ID_RotatedEllipse =
	v:'2017-09-30'
	k:'angleMode rotate ellipse translate'
	l:6
	b:""
	a:"""
fc 1,0,0
sc()
translate 100,100
angleMode DEGREES
rotate 45
ellipse 0,0, 80,40
"""

ID_RotatedRectA =
	v:'2017-04-29'
	k:'fc rect'
	l:4
	b:""
	a:"""
fc 1,0,0
rect 60,100, 40,40
fc 0,1,0
rect 140,100, 40,40
"""

ID_RotatedRectB =
	v:'2017-09-30'
	k:'fc angleMode rotate rect translate push pop'
	l:12
	b:""
	a:"""
push()
fc 1,0,0
translate 60,100
angleMode DEGREES
rotate 45
rect 0,0, 40,40
pop()
push()
fc 0,1,0
translate 140,100
rotate 45
rect 0,0, 40,40
pop()
"""

ID_RotatedRectC =
	v:'2017-09-30'
	k:'fc angleMode rotate rect translate push pop'
	l:13
	b:""
	a:"""
rectMode CENTER
push()
fc 1,0,0
translate 80,120
angleMode DEGREES
rotate 45
rect 0,0, 40,40
pop()
push()
fc 0,1,0
translate 160,120
rotate 45
rect 0,0, 40,40
pop()
"""

ID_Roulette =
	v:'2017-09-30'
	k:'bg sw fc sc range angleMode rotate for if operators [] "" PI text arc strokeCap translate'
	l:15
	b:"""
numbers = [0,32,15,19,4,21,2,25,17,34,6,27,13,36,11,30,8,23,10,5,24,16,33,1,20,14,31,9,22,18,29,7,28,12,35,3,26]
"""
	a:"""
numbers = [0,32,15,19,4,21,2,25,17,34,6,27,13,36,11,30,8,23,10,5,24,16,33,1,20,14,31,9,22,18,29,7,28,12,35,3,26]
bg 0.5
translate 100,100
d = 180/numbers.length
sw 20
strokeCap SQUARE
textAlign CENTER,CENTER
angleMode DEGREES
for number,i in numbers
	fc()
	if i==0 then sc 0,1,0 else sc i%2,0,0
	arc 0,0,180,180,-90-d,-90+d
	sc()
	fc 1
	text number,0,-90
	rotate 360 / numbers.length
"""
	e :
		Wikipedia : "https://en.wikipedia.org/wiki/Roulette"

ID_RubikCube =
	v:'2017-04-29'
	k:'bg fc sc range [] if constrain for int quad text dist operators class'
	l:121
	b:"""
class RubikCube extends Application
	reset : ->
		super
	draw : ->
	mousePressed : (mx,my) ->
	toggleNumbers : ->
app = new RubikCube
"""
	a:"""
class RubikCube extends Application
	newGame : ->
		@level = @level + if @level==@history.length then 1 else -1
		@level = constrain @level,0,100
		@history = []
		@board = []
		@memory = -1
		@board.push i for i in range 54
		for i in range @level
			@op @randint(6), 2*@randint(2)-1
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	undo : ->
		if @history.length==0 then return
		@memory = -1
		[k,d] = @history.pop()
		@op k,-d
	turn : (a,b) -> # a,b in 0..54
		if int(a/9) != int(b/9) then return
		d = (a%9 - b%9)/2
		if d in [-3,3] then d = -d/3
		if d not in [-1,1] then return
		k = int a/9
		@op k,d
		@history.push [k,d]
	op : (k,d) -> # 0..5, [-1,1]
		tiles = [
			[0,1,42,41,40,   2,3,9,16,15,    4,5,20,19,18,   6,7,31,30,29]
			[9,10,40,39,38,  11,12,49,48,47, 13,14,22,21,20, 15,16,4,3,2]
			[18,19,6,5,4,    20,21,15,14,13, 22,23,47,46,45, 24,25,33,32,31]
			[27,28,36,43,42, 29,30,0,7,6,    31,32,18,25,24, 33,34,45,52,51]
			[36,37,51,50,49, 38,39,11,10,9,  40,41,2,1,0,    42,43,29,28,27]
			[45,46,24,23,22, 47,48,13,12,11, 49,50,38,37,36, 51,52,27,34,33]]
		arr = tiles[k]
		carr = (@board[i] for i in arr)
		limit = if d==1 then 5 else 15
		carr = carr[limit..20].concat carr[0..limit]
		@board[arr[i]] = carr[i] for i in range 20
	reset : ->
		super
		@board = []
		@memory = -1
		@level = -1
		@history = []
		@buttons = [[40,140,@level], [160,140,"new"]]
		@showNumbers = false
		@seed = 0
		@newGame()
	colorize : (index,board) ->
		k = int board[index] / 9
		[r,g,b] = [[1,1,1],[0,0,1],[1,0,0],[0,1,0],[0.97, 0.57, 0],[1,1,0]][k]
		fc r,g,b
	textColorize : (index,board) -> fc [0,1,1,0,0,0][int board[index] / 9]
	rita : (x,y,index,tilt,self) ->
		a = 16
		b = 9
		self.colorize index,self.board
		sc 0
		if tilt == 0 then quad x-a,y, x,y-b, x+a,y, x,y+b
		if tilt == 1 then quad x+a/2,y-b/2, x-a/2,y-3*b/2, x-a/2,y+b/2, x+a/2,y+3*b/2
		if tilt == 2 then quad x-a/2,y-b/2, x+a/2,y-3*b/2, x+a/2,y+b/2, x-a/2,y+3*b/2
		self.textColorize index,self.board
		sc()
		if self.showNumbers then text self.board[index],x,y
		if self.memory? and index == self.memory then circle x,y,4
		false
	sense : (x,y,index,tilt,self) -> dist(x,y,mouseX,mouseY) < 9
	draw : ->
		bg 0
		textSize 12
		textAlign CENTER,CENTER
		@traverse @rita
		fc 1,1,0
		textSize 20
		@buttons[0][2] = @level - @history.length
		text txt,x,y for [x,y,txt] in @buttons
	traverse : (f) ->
		a = 16
		b = 9
		y0 = 60
		for index in range 54
			side = int index / 9
			if side==0 # vit
				i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
				j = [0,1,2,2,2,1,0,0,1][index % 9]
				if f 100+a*(i+j-1),y0+b*(i-j+1), index, 0,@ then return index
			if side==1 # blå
				i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
				j = [0,1,2,2,2,1,0,0,1][index % 9]
				if f 100+a*(i+4.5),y0+b*(2*j+i-3.5), index, 1,@ then return index
			if side==2 # röd
				i = [-1,0,1,1,1,0,-1,-1,0][index % 9]
				j = [0,0,0,1,2,2,2,1,1][index % 9]
				if f 100+a*(i+1.5),y0+b*(2*j-i+2.5), index, 2,@ then return index
			if side==3 # grön
				i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
				j = [2,1,0,0,0,1,2,2,1][index % 9]
				if f 100+a*(i-1.5),y0+b*(2*j+i+2.5), index, 1,@ then return index
			if side==4 # orange
				i = [-1, 0, 1, 1, 1, 0,-1,-1, 0][index % 9]
				j = [ 2, 2, 2, 1, 0, 0, 0, 1, 1][index % 9]
				if f 100+a*(i-4.5),y0+b*(2*j-i-3.5), index, 2,@ then return index
			if side==5 # gul
				i = [ 1, 1, 1, 0,-1,-1,-1, 0, 0][index % 9]
				j = [ 0, 1, 2, 2, 2, 1, 0, 0, 1][index % 9]
				if f 100+a*(i+j-1),y0+b*(i-j+13), index, 0,@ then return index
		-1
	mousePressed : (mx,my) ->
		for [x,y,txt],i in @buttons
			if dist(mx,my,x,y) < 10
				if i==0 then return @undo()
				if i==1 then return @newGame()
		if @memory == -1
			@memory = @traverse @sense
			if @memory != -1
				if @memory%9==8 then @memory = -1
		else
			index = @traverse @sense
			if index != -1 and index%9 != 8 then @turn @memory,index
			@memory = -1
	toggleNumbers : ->
		@showNumbers = not @showNumbers

app = new RubikCube "a"


"""
	c:
		app : "reset()|toggleNumbers()"
	e:
		"RubikCube" : "https://sv.wikipedia.org/wiki/Rubiks_kub"

ID_RubikSquare =
	v:'2017-04-29'
	k:'bg fc sc circle [] int .. operators if rectMode rect "" parseInt _.isEqual text while constrain class'
	l:85
	b:"""
# OBS: Du bör använda variabeln rubikSquareData.

class RubikSquare extends Application
	reset : ->
	draw : ->
	mousePressed : (mx,my) ->
app = new RubikSquare
"""
	a:"""
class RubikSquare extends Application
	reset : ->
		super
		@BUTTONS = [[4,3,3,3],[10,3,3,3],[16,3,3,3], [4,9,3,3],[10,9,3,3],[16,9,3,3], [4,15,3,3],[10,15,3,3],[16,15,3,3], [4,19,3,1],[10,19,3,1],[16,19,3,1]]
		@seed = 0
		@level = 1
		@history = []
		@memory = -1
		@createGame()

	randint : (n) -> int n * fraction 10000 * Math.sin @seed++

	newGame : ->
		if @level >= @history.length and _.isEqual @board,[0,1,2,0,1,2,0,1,2] then d=1 else d=-1
		@level = constrain @level+d,1,6
		@history = []
		@createGame()

	createGame : ->
		bigstring = rubikSquareData[@level]
		arr = bigstring.split ' '
		s = arr[@randint(arr.length)]
		@board = (parseInt(ch) for ch in s)

	move : (m,d,board) ->
		[i,j,k] = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8]][m]
		bd = board[..]
		[a,b,c] = [bd[i],bd[j],bd[k]]
		if d==0 then [a,b,c] = [b,c,a] else [a,b,c] = [c,a,b]
		[bd[i],bd[j],bd[k]] = [a,b,c]
		bd

	draw : ->
		bg 0
		textAlign CENTER,CENTER
		textSize 20
		rectMode CENTER,CENTER
		for c,i in @board
			sc 1
			if c==0 then fc 1,0,0
			if c==1 then fc 0,1,0
			if c==2 then fc 0,0,1
			[x,y,w,h] = @BUTTONS[i]
			rect 10*x,10*y,20*w,20*h
		if @memory >= 0
			[x,y,w,h] = @BUTTONS[@memory]
			fc 0
			sc()
			circle 10*x,10*y,10
		[x,y,w,h] = @BUTTONS[10]
		fc 1,1,0
		sc()
		text @level-@history.length,10*x,10*y
		if @history.length > 0
			[x,y,w,h] = @BUTTONS[9]
			text "undo",10*x,10*y
			[x,y,w,h] = @BUTTONS[11]
			text "new",10*x,10*y

	undo : ->
		if @history.length == 0 then return
		@board = @history.pop()
		@memory = -1

	mousePressed : (mx,my) ->
		index = -1
		for [x,y,w,h],i in @BUTTONS
			if x-w <= mx/10 <= x+w and y-h <= my/10 <= y+h then index = i
		if 0 <= index < 9
			if @memory == -1
				@memory = index
			else if @memory == index
				@memory = -1
			else
				hash =
					"01":[0,1], "02":[0,0], "10":[0,0], "12":[0,1], "20":[0,1], "21":[0,0]
					"34":[1,1], "35":[1,0], "43":[1,0], "45":[1,1], "53":[1,1], "54":[1,0]
					"67":[2,1], "68":[2,0], "76":[2,0], "78":[2,1], "86":[2,1], "87":[2,0]
					"03":[3,1], "06":[3,0], "30":[3,0], "36":[3,1], "60":[3,1], "63":[3,0]
					"14":[4,1], "17":[4,0], "41":[4,0], "47":[4,1], "71":[4,1], "74":[4,0]
					"25":[5,1], "28":[5,0], "52":[5,0], "58":[5,1], "82":[5,1], "85":[5,0]
				pair = hash["" + @memory + index]
				if pair
					[m,d] = pair
					@history.push @board[..]
					@board = @move m,d,@board
					@memory = -1
		if index==9 then @undo()
		if index==11 then @newGame()

app = new RubikSquare "a"

"""
	c:
		app : "reset()"

ID_RushHour =
	v:'2017-04-29'
	k:'bg sc fc range operators "" [] {} class rect text for if readText'
	l:71
	b:"""
# De 36 rutorna numreras:
#   0 1 2 3 4 5
#   6 7 8 9 a b
#   c d e f g h
#   i j k l m n
#   o p q r s t
#   u v w x y z
#
# Placering av fordon:
#   horisontellt: A=2 B=3
#   vertikalt:    C=2 D=3
#
# Lösningar:
# 	Bilarna namnges i följden XABCDEFGHIJKLMNOPQR
# 	liten bokstav: vänster/uppåt
# 	stor bokstav:  höger/nedåt

class Car
	constructor : (ch,wh,@c) ->
	render      : ->
	move        : (d) ->

class RushHour extends Application
	classes    : -> [Car]
	reset      : ->
		super
	draw       : ->
	enter_cars : -> # Ad0sBwCoD569
	enter_move : -> # bbbEEEAfdccGGXXXXX
	begin      : ->
	backward   : (n=1) ->
	forward    : (n=1) ->
	end        : ->
app = new RushHour

"""
	a:"""
class Car
	constructor : (ch,wh,@c) ->
		index = "0123456789abcdefghijklmnopqrstuvwxyz".indexOf ch
		@i = index % 6
		@j = int index / 6
		[@w,@h] = wh

	render : ->
		fill cc (@c+1) % 8
		rect 40+20*@i+2, 40+20*@j+2, 20*@w-4, 20*@h-4
		fc 0
		fill cct (@c+1) % 8
		name = "XABCDEFGHIJKLMNOP"[@c]
		small = name.toLowerCase()
		text small, 50+20*@i,        50+20*@j
		text name,  50+20*(@i+@w-1), 50+20*(@j+@h-1)

	move : (d) -> # -1 eller +1
		if @w == 1 then @j += d
		if @h == 1 then @i += d

class RushHour extends Application
	classes : -> [Car]
	reset : ->
		super
		@enter_cars1 "Ad0sBwCoD569"
		@enter_move1 "bbbEEEAfdccGGXXXXX"
		@begin()

	draw : ->
		textAlign CENTER,CENTER
		bg 0
		sc()
		fc 0.5
		rect 40,40,120,120
		rect 160,80,40,20
		fc 1
		sc()
		for i in range 6
			text "012345"[i],30,50+20*i
			text "012345"[i],50+20*i,170
		for car in @cars
			car.render()

	enter_cars : -> @enter_cars1 @readText()
	enter_cars1 : (s) ->
		@cars = []
		@moves = ""
		@index = 0
		for ch in s
			if ch in "ABCD" then wh = {A:[2,1], B:[3,1], C:[1,2], D:[1,3]}[ch]
			else @cars.push new Car ch,wh,@cars.length

	enter_move : -> @enter_move1 @readText()
	enter_move1 : (s) ->
		@moves = @moves[...@index]
		@moves += s
		@forward s.length

	begin : -> @backward @index
	backward : (n=1) ->
		for i in range n
			if @index == 0 then return
			@index--
			@bothward "XABCDEFGHIJKLMNO","xabcdefghijklmno"
	forward : (n=1) ->
		for i in range n
			if @index >= @moves.length then return
			@bothward "xabcdefghijklmno","XABCDEFGHIJKLMNO"
			@index++
	end : -> @forward @moves.length - @index

	bothward : (a,b) ->
		i = a.indexOf @moves[@index]
		j = b.indexOf @moves[@index]
		if i >= 0 then @cars[i].move -1
		if j >= 0 then @cars[j].move +1

app = new RushHour "a"
"""
	c:
		app : "reset()|enter_cars()|enter_move()|begin()|backward()|forward()|end()"
	e:
		RushHour : "https://en.wikipedia.org/wiki/Rush_Hour_(board_game)"

