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
		fill @fillColor
		strokeWeight @strokeWeight
		for child in @children
			push()
			child.draw() 
			pop()

	drawTitle : ->
		fill '#000'
		textAlign CENTER,CENTER
		text @txt,0,0				

	add : (shape) -> @children.push shape

	fill : (color) ->
		@fillColor = color
		@
	stroke : (color) ->
		@strokeColor = color
		@
	title : (txt) ->
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

		position = new Vector 0,0
		lastRotation = 0
		for [x,y,rotation] in lst
			v1 = new Vector x, y
			v2 = v1.rotate lastRotation
			position = position.add v2
			lastRotation += rotation
		[position.x, position.y, lastRotation %% 360]

	mouseMoved : -> 
		m = new Vector mouseX,mouseY
		for child in @children
			if child.moved? then child.moved m
			child.mouseMoved()

	mousePressed : ->
		m = new Vector mouseX,mouseY
		for child in @children
			if child.contains m
				if child.pressed? then child.pressed()
			child.mousePressed()

	move : (dx,dy) -> [@x,@y] = [@x+dx,@y+dy]

class Group extends Shape
	constructor : (x,y,parent=stage) -> super x,y,parent
	contains : ->

class Polygon extends Shape
	constructor : (x,y,parent=stage,@points = []) -> super x,y,parent
	lineTo : (x,y) -> @points.push new Vector x,y
	draw : ->
		super()
		beginShape()
		for p in @points
			vertex p.x,p.y
		endShape CLOSE
		@drawTitle()

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
		@drawTitle()
	inside : (d) -> @radius >= sqrt d.x*d.x+d.y*d.y

class Ellipse extends Shape
	constructor : (x,y,@w,@h,parent=stage) -> super x,y,parent
	draw : ->
		super()
		fill @fillColor
		strokeWeight @strokeWeight
		ellipse 0,0,@w,@h
		@drawTitle()
	inside : (d) -> 
		xr = @w/2
		yr = @h/2
		dx = d.x/xr
		dy = d.y/yr
		dx*dx + dy*dy < 1

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
		@lineTo -w,-h
		@lineTo +w,-h
		@lineTo +w,+h
		@lineTo -w,+h

class Triangle extends Polygon
	constructor : (x,y,x1,y1,x2,y2,x3,y3,parent=stage) ->
		super x,y,parent
		@lineTo x1,y1
		@lineTo x2,y2
		@lineTo x3,y3

class Quad extends Polygon
	constructor : (x,y,x1,y1,x2,y2,x3,y3,x4,y4,parent=stage) ->
		super x,y,parent
		@lineTo x1,y1
		@lineTo x2,y2
		@lineTo x3,y3
		@lineTo x4,y4

class Regular extends Polygon
	constructor : (x,y,r,n,parent=stage) ->
		super x,y,parent
		for i in range n
			dx = r*cos i*360/n
			dy = r*sin i*360/n
			@lineTo dx,dy

p6.shape    = (...args) -> new Shape ...args
p6.group    = (...args) -> new Group ...args
p6.polygon  = (...args) -> new Polygon ...args
p6.circle   = (...args) -> new Circle ...args
p6.ellipse  = (...args) -> new Ellipse ...args
p6.arc      = (...args) -> new Arc ...args
p6.rect     = (...args) -> new Rect ...args
p6.triangle = (...args) -> new Triangle ...args
p6.quad     = (...args) -> new Quad ...args
p6.regular  = (...args) -> new Regular ...args

stage = new Shape()
