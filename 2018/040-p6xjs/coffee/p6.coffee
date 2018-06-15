shapes = {}
p6 = {}

class Vector
	constructor : (@x=0,@y=0) ->
		@rotation = atan2 @y, @x
		@length = sqrt @x*@x + @y*@y
	add : (vector) -> new Vector @x + vector.x,@y + vector.y
	sub : (vector) -> new Vector @x - vector.x,@y - vector.y
	rotate : (degrees) ->
		v = @rotation + degrees
		x = @length * cos v
		y = @length * sin v
		new Vector x, y

class Shape
	constructor : (@x=0,@y=0,@parent=null,@rotation=0)->
		@children = []
		@fillColor = "#fff"
		@strokeColor = "#000"
		@strokeWeight = 1
		@txt = ''
		if @parent? then @parent.add @

	draw : ->
		translate @x,@y
		rotate @rotation
		for child in @children
			push()
			child.draw()
			pop()

	add : (shape) -> @children.push shape

	fill : (color) ->
		@fillColor = color
		@
	stroke : (color) ->
		@strokeColor = color
		@
	text : (txt) ->
		@txt = txt
		@

	contains : (m) -> # m is mouse position
		[x,y,rotation] = @stagepos()
		p = new Vector x,y
		p = m.sub p
		p = p.rotate -rotation
		@inside p

	stagepos : -> # returns resulting [x, y, rotation]
		lst = []
		current = @
		while current
			lst.unshift [current.x,current.y,current.rotation]
			current = current.parent
		vec = new Vector()
		rot = 0
		rotres = 0
		for [x,y,rotation] in lst
			rotres += rotation
			v1 = new Vector x, y
			v2 = v1.rotate rot
			rot = rotation
			vec = vec.add v2
		[vec.x,vec.y,rotres]

	mouseMoved : -> # m = mouse position
		m = new Vector mouseX,mouseY
		for child in @children
			if child.moved? then child.moved m
			child.mouseMoved()

	mousePressed : -> # m = mouse position
		m = new Vector mouseX,mouseY
		for child in @children
			if child.contains m
				if child.pressed? then child.pressed()
			child.mousePressed()

	move : (dx,dy) -> [@x,@y] = [@x+dx,@y+dy]

class Polygon extends Shape
	constructor : (x,y,parent=stage) ->
		super x,y,parent
		@points = []

	lineTo : (x,y) -> @points.push new Vector x,y

	draw : ->
		super()
		fill @fillColor
		strokeWeight @strokeWeight
		beginShape()
		for p in @points
			vertex p.x,p.y
		endShape CLOSE

	inside : (p) -> # only checks if p is locally within polygon
		res = false
		lst = range @points.length
		lst.unshift lst.pop()
		for j,i in lst
			xi = @points[i].x
			yi = @points[i].y
			xj = @points[j].x
			yj = @points[j].y
			intersect = ((yi >= p.y) != (yj >= p.y)) and (p.x <= (xj - xi) * (p.y - yi) / (yj - yi) + xi)
			if intersect then res = !res
		res

class Circle extends Shape
	constructor : (x,y,@radius,parent=stage) -> super x,y,parent
	draw : ->
		super()
		fill @fillColor
		strokeWeight @strokeWeight
		circle 0,0,@radius
		fill '#000'
		textSize 30
		textAlign CENTER,CENTER
		text @txt,0,0

	inside : (d) -> @radius >= sqrt d.x*d.x+d.y*d.y

class Arc extends Polygon
	constructor : (x,y,radius,start,stopp,parent=stage) ->
		super x,y,parent
		@lineTo 0,0
		lst = range start,stopp,10
		lst.push stopp
		for v in lst
			x = radius * cos v
			y = radius * sin v
			@lineTo x,y

class Rect extends Polygon
	constructor : (x,y,w,h,parent=stage) ->
		super x,y,parent
		w = w/2
		h = h/2
		@lineTo -w,-h,+w,-h
		@lineTo +w,-h,+w,+h
		@lineTo +w,+h,-w,+h
		@lineTo -w,+h,-w,-h

class Group extends Shape
	constructor : (x,y,parent=stage) -> super x,y,parent
	contains : ->

p6.shape  = (...args) -> new Shape ...args
p6.group  = (...args) -> new Group ...args
p6.circle = (...args) -> new Circle ...args
p6.arc    = (...args) -> new Arc ...args
p6.rect   = (...args) -> new Rect ...args

stage = new Shape()
