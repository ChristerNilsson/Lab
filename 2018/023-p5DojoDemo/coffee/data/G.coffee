ID_GalaxiesColliding =
	v:'2017-04-29'
	k:'fc range for lerp rect if'
	l:8
	b: "# (David Larsson)\n"
	a: """
for i in range 10
	for j in range 10
		fc()
		if i-j in [-2,0,2] then fc 1,1,0
		if i+j in [7,9,11] then fc 1,0,0
		x = 20*i
		y = 20*j
		rect x,y, 20,20
"""

ID_GameOfLife =
	v:'2017-04-29'
	k:'bg range for [] operators if int class'
	l:40
	b:"""
class GameOfLife extends Application
	reset : (n) ->
		super
	draw : ->
	mousePressed : (mx,my) ->
	tick : ->
app = new GameOfLife

"""
	a:"""
class GameOfLife extends Application
	reset : (n) ->
		super
		@n = n
		@size = 200/@n
		@matrix = {}
		@ticks = 0
		for [i,j] in [[0,0],[2,0],[1,1],[2,1],[1,2]]
			@matrix[i+','+j] = 1
	draw : ->
		bg 0.5
		for i in range @n
			for j in range @n
				if @matrix[i+','+j]==1
					rect @size*i, @size*j, @size, @size
	count : (x,y) ->
		res = 0
		for dx in [-1,0,1]
			for dy in [-1,0,1]
				i = (x+dx) %% @n
				j = (y+dy) %% @n
				res++ if @matrix[i+','+j]==1 and (dx!=0 or dy!=0)
		res
	tick : ->
		@ticks++
		m = {}
		for i in range @n
			for j in range @n
				c = @count(i,j)
				key = i+','+j
				if @matrix[key] == 1
					if 2 <= c <= 3 then m[key]=1
				else
					if c==3 then m[key]=1
		@matrix = m
	mousePressed : (mx,my) ->
		i = int mx/@size
		j = int my/@size
		key = i+','+j
		@matrix[key] = if @matrix[key] == 1 then undefined else 1

app = new GameOfLife "a"

"""
	c:
		app : "reset 10|reset 20|reset 40|tick()"
#	d : "reset 40|mousePressed 105,100|mousePressed 110,105|mousePressed 100,110|mousePressed 105,110|mousePressed 110,110|tick()|tick()|tick()|tick()|tick()|tick()|tick()|tick()"
	d : "reset 40|tick()|tick()|tick()|tick()|tick()|tick()|tick()|tick()"
	e:
		Wikipedia : "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life"

ID_Girlang =
	v:'2018-02-11'
	k:'sc bg sw range for line class'
	l:15
	b:"""
class Cartesius
	constructor : (@r,@g,@b, @x,@y) ->
	go : (dx,dy) ->

a = new Cartesius ...
b = new Cartesius ...
for ...
"""
	a:"""
class Cartesius
	constructor : (@r,@g,@b, @x,@y) ->
	go : (dx,dy) ->
		sc @r,@g,@b
		line @x,@y,@x+dx,@y+dy
		[@x,@y] = [@x+dx,@y+dy]

bg 0
r = new Cartesius 1,0,0, 10,0
y = new Cartesius 1,1,0, 0,10
sw 5
for i in range 9
	r.go 0,20
	y.go 20,0
	y.go 0,20
	r.go 20,0
"""

ID_GoldenStar =
	v:'2017-09-30'
	k:'bg fc range for triangle translate angleMode rotate cos sin class'
	l:23
	b: """
class GoldenStar extends Application
	reset : ->
		super
	draw  : ->
	n     : (d) ->
	outer : (d) ->
	inner : (d) ->
app = new GoldenStar
"""
	a: """
class GoldenStar extends Application
	reset : ->
		super
		@_X = 100
		@_Y = 100
		@_n = 4
		@_outer = 100
		@_inner = 25
	n : (d) -> @_n = constrain @_n+d,3,12
	outer : (d) -> @_outer = constrain @_outer+d, 0, 100
	inner : (d) -> @_inner = constrain @_inner+d, 0, 100
	draw : ->
		bg 0
		angleMode DEGREES
		translate @_X,@_Y
		v = 360/@_n
		rotate -90
		x1 = @_inner * cos v/2
		y1 = @_inner * sin v/2
		for i in range @_n
			fc 1,1,0
			triangle 0,0, @_outer,0, x1,y1
			fc 1,0.7,0
			triangle 0,0, @_outer,0, x1,-y1
			rotate v

app = new GoldenStar "a"
"""
	c:
		app : "reset()|n -1|n +1|outer -1|outer +1|inner -1|inner +1"
	d : "reset()|n -1|n +1|n +1|outer -10|outer +10|inner -1|inner +1"

ID_GreenEllipse =
	v:'2017-04-29'
	k:'fc ellipse'
	l:2
	b:""
	a:"""
fc 0,1,0
ellipse 120,60, 60,40
"""

ID_GreenRect =
	v:'2017-04-29'
	k:'fc rect'
	l:2
	b:""
	a:"""
fc 0,1,0
rect 60,80, 40,50
"""

ID_Grid =
	v:'2017-04-29'
	k:'sc sw range for line'
	l:5
	b:""
	a:"""
sc 1,1,0
sw 2
for i in range 10,200,10
	line 10,i,190,i
	line i,190, i,10
"""

ID_GrowingCircles =
	v:'2017-04-29'
	k:'range fc circle for lerp'
	l:6
	b:"""
# LÄXA: Hela uppgiften
"""
	a:"""
for i in range 10
	fc i/10.0,0,0
	x = 10+20*i
	y = 10
	r = i
	circle x,y,r
"""

ID_GrowingRedSquares =
	v:'2017-04-29'
	k:'fc range for lerp rect rectMode'
	l:8
	b:""
	a:"""
rectMode CENTER
for i in range 10
	fc i/10.0,0,0
	x = 10+20*i
	y = 10
	w = 2*i
	h = 2*i
	rect x,y,w,h
"""

ID_GrowingSquares =
	v:'2017-04-29'
	k:'range rect rectMode for lerp'
	l:7
	b:""
	a:"""
rectMode CENTER
for i in range 10
	x = 10+20*i
	y = 10
	w = 2*i
	h = 2*i
	rect x,y, w,h
"""

ID_GuessANumber =
	v:'2017-04-29'
	k:'bg fc sc range text for if operators int class'
	l:29
	b:"""
class Guess extends Application
	reset        : ->
		super
	draw         : ->
	newGame : ->
	mousePressed : (mx,my) ->
app = new Guess
"""
	a:"""
class Guess extends Application
	reset : ->
		super
		@N = 100
		@seed = 0
		@newGame()

	randint : (n) -> int n * fraction 10000 * Math.sin @seed++

	newGame : ->
		@start = 0
		@stopp = @N-1
		@secret = @randint @N

	draw : ->
		bg 0.1
		textAlign CENTER,CENTER
		for i in range @N
			if @start <= i <= @stopp then fc 1 else fc 0.5
			sc()
			x = i % 10
			y = int i / 10
			text i, 10 + 20 * x, 10 + 20 * y

	mousePressed : (mx,my) ->
		guess = int mx/20 + 10 * int my/20
		if guess <= @secret then @start = guess+1
		if guess >= @secret then @stopp = guess-1

app = new Guess "a"
			"""
	c:
		app : "reset()|newGame()"
	d : "reset()|mousePressed 75,75|mousePressed 100,125"

ID_GuessANumberHex =
	v:'2017-05-11'
	k:'bg fc sc range text for if operators int class'
	l:33
	b:"""
class GuessANumberHex extends Application
	reset        : ->
		super
	draw         : ->
	newGame : ->
	mousePressed : (mx,my) ->
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
app = new GuessANumberHex
"""
	a:"""
class GuessANumberHex extends Application
	reset : ->
		super
		@BASE = 16
		@N = @BASE*@BASE
		@S = 200 / @BASE
		@seed = 1
		@newGame()
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	newGame : ->
		@start = 0
		@stopp = @N-1
		@secret = @randint @N
		@count = 0
	draw : ->
		bg 0
		textAlign CENTER,CENTER
		textSize 9
		for i in range @N
			if @start <= i <= @stopp then fc 1 else fc 0.5
			sc()
			x = i % @BASE
			y = int i / @BASE
			text hex(i,2), @S/2 + @S * x, @S/2 + @S * y
		fc 1,1,1,0.5
		textSize 100
		text @count,100,100
	mousePressed : (mx,my) ->
		guess = int mx/@S + @BASE * int my/@S
		@seed += mx % 2
		@count++
		if guess <= @secret then @start = guess+1
		if guess >= @secret then @stopp = guess-1

app = new GuessANumberHex "a"
			"""
	c:
		app : "reset()|newGame()"
	d : "reset()|mousePressed 100,100|mousePressed 100,150|mousePressed 50,50"

ID_GUI =
	v:'2017-09-29'
	k:'bg fc sc text for if [] operators class'
	l:30
	b:"""
class GUI extends Application
	reset : ->
		super
	draw : ->
	up : ->
	down : ->
	left : ->
	right : ->
app = new GUI
"""
	a:"""
class GUI extends Application
	reset : ->
		super
		@current = 0
		@prompts = []
		@labels = []
		@values = []
		@add 'Fan o--- -o-- --o- ---o'
		@add 'Temp o----- -o---- --o--- ---o-- ----o- -----o'
		@add 'Blink Off Left Right'
		@add 'Music Beatles Jazz Rock Stones'
		@add 'Radio P1 P2 P3 P4 P5'
		@add 'Volume 0 1 2 3 4 5 6 7 8 9'
		@add 'Wipers o--- -o-- --o- ---o'

	add : (s) ->
		arr = s.split ' '
		@prompts.push arr.shift()
		@labels.push arr
		@values.push 0

	draw : ->
		bg 0.5
		sc()
		textSize 20
		for prompt,i in @prompts
			if @current == i then fc 1,1,0 else fc 0
			text prompt,10,30+25*i
			text @labels[i][@values[i]],120,30+25*i

	up : -> @current = (@current - 1) %% @prompts.length
	down : -> @current = (@current + 1) %% @prompts.length
	left : -> @values[@current] = (@values[@current]-1) %% @labels[@current].length
	right : -> @values[@current] = (@values[@current]+1) %% @labels[@current].length

app = new GUI "a"
"""
	c:
		app : "reset()|up()|down()|left()|right()"
	d : "reset()|down()|right()|right()|right()|right()|down()|right()|down()"
