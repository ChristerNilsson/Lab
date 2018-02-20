ID_P5 =
	v:'2017-05-20'
	k:'-> text fc sc'
	l:5
	b:"""
skriv = (txt,x,y,r,g,b,size) ->
	# Skriv din kod här!

# Ändra ingenting nedanför denna rad!

skriv "p5",      100,100,1,0,0,180
skriv "Lauren",  155, 43,0,0,0, 18
skriv "McCarthy",155,180,1,1,1, 18
skriv "Coding",   50, 20,1,1,0, 24
skriv "Train",    50, 48,0,1,0, 30
"""
	a:"""
skriv = (txt,x,y,r,g,b,size) ->
	textAlign CENTER,CENTER
	textSize size
	fc r,g,b
	sc()
	text txt,x,y

skriv "p5",      100,100,1,0,0,180
skriv "Lauren",  155, 43,0,0,0, 18
skriv "McCarthy",155,180,1,1,1, 18
skriv "Coding",   50, 20,1,1,0, 24
skriv "Train",    50, 48,0,1,0, 30
"""

ID_PacMan =
	v:'2017-04-29'
	k:'fc arc angleMode'
	l:2
	b:""
	a:"""
fc 1,1,0
angleMode DEGREES
arc 100,100, 180,180, -135,135
"""
	e :
		Play : "https://www.google.se/#q=pacman&clb=clb"
		Wikipedia : "https://en.wikipedia.org/wiki/Pac-Man"

ID_Paint =
	v:'2017-05-15'
	k:'bg sc range rect circle for class []'
	l:36
	b:"""
# colors from cc and cct
class Paint extends Application
	reset : ->
		super
	draw : ->
	mousePressed : (mx,my) ->
	undo : ->
app = new Paint
"""
	a:"""
class Paint extends Application
	reset : ->
		super
		@picture = (Array(20).fill(0) for i in range 18)
		@selected = 3
		@history = []
		@state = 0
	draw : ->
		sc()
		for i in range 32
			index = i+@state*32
			fill cc index
			x = i % 16 * 10
			y = 10 * int i/16
			rect x,y,10,10
			if index == @selected
				fill cct @selected
				circle x+5,y+5,3
		for i in range 20
			for j in range 18
				fill cc @picture[j][i]
				rect 10*i,20+10*j,10,10
	mousePressed : (mx,my) ->
		i = int mx/10
		j = int my/10
		if j<=1
			if i <= 15 then @selected = 32*@state + 16*j + i
			else return @state = 1-@state
		else
			j -= 2
			@history.push [j,i,@picture[j][i]]
			@picture[j][i] = @selected
	undo : ->
		if @history.length==0 then return
		[a,b,c] = @history.pop()
		@picture[a][b] = c

app = new Paint "a"
"""
	c:
		app : "reset()|undo()"

ID_PentaLerp =
	v:'2017-09-11'
	k:'bg sc fc range circle for lerp'
	l:11
	b:""
	a:"""
bg 0.5
sc()
for i in range 11
	for j in range 11
		r = 0.1*i
		g = 0.1*j
		fc r,g,0
		x = 20*i
		y = 20*j
		radius = lerp 0,1,(i+j)/2
		circle x,y,radius
"""

ID_PickingBerries =
	v:'2017-04-29'
	k:'bg sc fc sw [] operators line text constrain dist break for class'
	l:46
	b:"""
class PickingBerries extends Application
	reset      : ->
		super
	draw       : ->
	left       : ->
	right      : ->
	up         : ->
	down       : ->
	snailSpeed : ->
	slowSpeed  : ->
	highSpeed  : ->
	warpSpeed  : ->
	pick       : ->
app = new PickingBerries
"""
	a:"""
class PickingBerries extends Application

	reset : ->
		super
		@SPEEDS = [1,5,20,50]
		@x = 100
		@y = 100
		@speed = 2 # 0..3
		@clicks = 0
		@xs = [100,189,124,196,13,187,12,153,32,131]
		@ys = [107,175,138,188,37,78,168,31,20,188]
		@moves = ""
		@dxdy = [[1,0],[0,1],[-1,0],[0,-1]]

	draw : ->
		bg 0
		rectMode CENTER
		sc 1
		sw 1
		rect @x,@y,2*@SPEEDS[@speed],2*@SPEEDS[@speed]
		for [dx,dy] in @dxdy
			for i in range 4
				point @x+dx*@SPEEDS[i], @y+dy*@SPEEDS[i]

		fc 1,1,0
		sc()
		textSize 20
		textAlign CENTER,CENTER
		text @clicks,100,180

		sc 1,0,0
		sw 2
		for [x,y] in _.zip @xs,@ys
			line x-3,y-3,x+3,y+3
			line x+3,y-3,x-3,y+3

	move : (i) ->
		[dx,dy] = @dxdy[i]
		@x += dx * @SPEEDS[@speed]
		@y += dy * @SPEEDS[@speed]
		@clicks++
		@moves += 'abcd'[i]

	setSpeed : (index) ->
		@speed = index
		@moves += index

	right   : -> @move 0
	down    : -> @move 1
	left    : -> @move 2
	up      : -> @move 3

	snailSpeed : -> @setSpeed 0
	slowSpeed  : -> @setSpeed 1
	highSpeed  : -> @setSpeed 2
	warpSpeed  : -> @setSpeed 3

	step : (d) ->
		@clicks++
		constrain @zoom+d,0,3
	pick : ->
		for [x,y],i in _.zip @xs,@ys
			if dist(x,y,@x,@y) <= 2
				@xs.splice i,1
				@ys.splice i,1
				break
		@clicks++

app = new PickingBerries "a"
			"""
	c:
		app : "reset()|left()|right()|up()|down()|snailSpeed()|slowSpeed()|highSpeed()|warpSpeed()|pick()"

ID_Polygon =
	v:'2017-09-30'
	k:'bg sc range line for cos sin angleMode class'
	l:23
	b:"""
class Turtle
	constructor : (@r=1,@g=0,@b=0, @x=100,@y=10,@dir=0) ->
	fd : (d) ->
	rt : (a) ->

class Polygon extends Application
	reset      : ->
		super
	draw       : ->
	antalSidor : (d) ->
	antalSteg  : (d) ->
app = new Polygon
"""
	a:"""
class Turtle
	constructor : (@r=1,@g=0,@b=0, @x=100,@y=10,@dir=0) ->
	fd : (d) ->
		dx = d*cos @dir
		dy = d*sin @dir
		sc @r,@g,@b
		line @x,@y,@x+dx,@y+dy
		@x += dx
		@y += dy
	rt : (a) ->
		@dir +=a

class Polygon extends Application
	reset : ->
		super
		@n = 6
		@steg = 60

	draw : ->
		t = new Turtle()
		bg 0
		angleMode DEGREES
		for i in range @n
			t.fd @steg
			t.rt 360/@n

	antalSidor : (d) -> @n += d
	antalSteg : (d) -> @steg += d

app = new Polygon "a"
"""
	c:
		app : "reset()|antalSidor -1|antalSidor +1|antalSteg -1|antalSteg +1|"

