class Turtle
	constructor : ->
		@loc = createVector()
		@ploc = createVector()
		@heading = 0
		@pen = true
		@show = true
		@counter = 1
		@labelstring = ""
		@labelheight = 15
		@penwidth = 1
		@pencolor = 0
		@commands = {}
		@variables = {}

	forward : (distance) ->
		@ploc = @loc.copy()
		dir = createVector(0, -distance).rotate @heading
		@loc.add dir
		if @pen then line @ploc.x, @ploc.y, @loc.x, @loc.y

	back :(distance) -> @forward -distance
	right : (degree) -> @heading += radians degree
	left : (degree) -> @right -degree
	penup : () -> @pen = false
	pendown : () -> @pen = true
	hideturtle : () -> @show = false
	showturtle : () -> @show = true

	home : () -> @setxy 0,0
	setx : (x) -> @setxy x,@loc.y
	sety : (y) -> @setxy @loc.x, y
	setxy : (x, y) ->
		@ploc = @loc.copy()
		@loc.x = x
		@loc.y = y
		if @pen then line @ploc.x, @ploc.y, @loc.x, @loc.y

	setheading : (degree) -> @heading = radians degree

	arc : (degree, radius) ->
		noFill()
		arc @loc.x, @loc.y, radius*2, @heading, @heading + degree

	print : (string) ->
		push()
		translate -width/2, -height/2
		textSize 10
		text string, 10, @counter*20
		pop()
		@counter++

	label : (string) -> @labelstring = string
	setlabelheight : (_height) ->	@labelheight = _height
	repeat : (number, block) -> block() for i in range number
	setwidth : (penwidth) -> @penwidth = penwidth
	to : (name, command) -> @commands[name] = command
	setcolor : (pencolor) -> @pencolor = pencolor
	random : (maximum) -> floor random maximum
	make : (name, variable) -> @variables[name] = variable
	sum : (a, b) -> a + b
	difference : (a, b) -> a - b
	_for : (minimum, maximum, increment, block) -> block i for i in range minimum, maximum, increment
	first : (list) -> @item 1, list 
	last : (list) -> @item list.length, list
	item : (number, list) -> list[number-1]
	pick : (list) -> @item @random list.length + 1, list
	butfirst : (list) ->
		newlist = []
		@_for i in range(2,list.length), (i) -> 
			newlist.push list.item i
		newlist
	butlast : (list) ->
		newlist = []
		@_for i in range(list.length-1), (i) ->
			newlist.push list.item i
		newlist
