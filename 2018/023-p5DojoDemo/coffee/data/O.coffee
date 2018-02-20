ID_OlympicRingPrep =
	v:'2017-04-29'
	k:'sc fc sw arc angleMode strokeCap class'
	l:21
	b:"""
class Ring extends Application
	reset  : ->
		super
	draw   : ->
	start  : (d) ->
	stopp  : (d) ->
	radius : (d) ->
	width  : (d) ->
app = new Ring
"""
	a:"""
class Ring extends Application
	reset : ->
		super
		@_start = 3
		@_stopp = 6
		@_w = 5
		@_radius = 50
	start : (d) -> @_start+=d
	stopp : (d) -> @_stopp+=d
	radius : (d) -> @_radius+=d
	width : (d) -> @_w+=d
	draw : ->
		hour = PI/6
		strokeCap SQUARE
		fc()
		sw @_w
		sc 1,1,0
		arc 100,100,2*@_radius,2*@_radius,(@_start-3)*hour,(@_stopp-3)*hour

app = new Ring "a"
"""
	c:
		app : "reset()|start -1|start +1|stopp -1|stopp +1|radius -1|radius +1|width -1|width +1"

ID_OlympicRings =
	v:'2017-04-29'
	k:'sc bg fc sw arc strokeCap class'
	l:24
	b: """
class Ring
	constructor : (@x,@y,@r,@g,@b) ->
	draw : (start=3,stopp=3,hour=PI/6) ->

olympic = (x=100,y=100,radius=50,d=60,w=10) ->

olympic()
"""
	a: """
class Ring
	constructor : (@x,@y,@radius, @r,@g,@b) ->
	draw : (start=3,stopp=3,hour=PI/6) ->
		sc @r,@g,@b
		arc @x,@y,@radius,@radius,(start-3)*hour,(stopp-3)*hour

olympic = (x=100,y=100,radius=50,d=60,w=10) ->
	r1 = new Ring x-d,  y,     radius, 0,0,1
	r2 = new Ring x,    y,     radius, 0,0,0
	r3 = new Ring x+d,  y,     radius, 1,0,0
	r4 = new Ring x-d/2,y+d/3, radius, 1,1,0
	r5 = new Ring x+d/2,y+d/3, radius, 0,1,0

	strokeCap SQUARE
	bg 0.5
	fc()
	sw w

	r1.draw()
	r3.draw()
	r4.draw()
	r5.draw()
	r1.draw 2,4
	r2.draw()
	r4.draw 12,2
	r5.draw 8,10
	r3.draw 6,8

olympic()
"""
	e :
		Wikipedia : "https://en.wikipedia.org/wiki/Olympic_symbols"

ID_OneDiceHistogram =
	v:'2017-04-29'
	k:'fc sc range int random text for operators rect []'
	l:17
	b:"""
# OBS: På grund av random blir bitmapparna inte likadana

h = 50
counts = Array(4).fill 150
for count,i in counts
	y = h*i
	rect 0,y,count,h
	text y,0,y
"""
	a:"""
counts = Array(6).fill 0
dice = -> int 6 * random()
for i in range 1000
	counts[dice()]++
h = int 200/6
sc()
for count,i in counts
	y = h*i
	fc 1,1,0,0.5
	sc 1,1,0
	rect 0,y,count,h-3
	fc 1,1,0
	sc()
	textAlign LEFT,CENTER
	text i+1, 5,y+h/2
	textAlign RIGHT,CENTER
	text count, count-5,y+h/2
"""

