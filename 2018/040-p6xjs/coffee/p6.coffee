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
	constructor : (@x,@y,@parent,options={}) ->
		@children = []
		if @parent? then @parent.add @
		@rotation = if options.rotation? then options.rotation else 0
		@strokeColor = if options.strokeColor? then options.strokeColor else "#000"
		@strokeWeight = if options.strokeWeight? then options.strokeWeight else 1
		@title = if options.title? then options.title else ''
		@scaleFactor = if options.scaleFactor? then options.scaleFactor else 1
		@moved = if options.moved? then options.moved else ->
		@pressed = if options.pressed? then options.pressed else ->
		@fillColor = if options.fillColor? then options.fillColor else "#fff"

	draw : ->
		scale @scaleFactor
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
		text @title,0,0

	add : (shape) -> @children.push shape

	contains : (m) -> # m is mouse position
		[x,y,rotation,sf] = @stagepos()
		p = new Vector x,y
		p = m.sub p
		p = p.rotate -rotation
		p.x /= sf
		p.y /= sf
		@inside p

	stagepos : -> # returns resulting [x, y, rotation, scaleFactor]
		lst = []
		current = @
		while current
			lst.unshift [current.x, current.y, current.rotation, current.scaleFactor]
			current = current.parent
		print 'lst',lst 
		position = new Vector 0,0
		lastRotation = 0
		sf = 1
		for [x,y,rotation,scaleFactor] in lst
			sf *= scaleFactor
			v1 = new Vector sf*x, sf*y
			v2 = v1.rotate lastRotation
			position = position.add v2
			lastRotation += rotation
		[position.x, position.y, lastRotation %% 360, sf]

	mouseMoved : ->
		m = new Vector mouseX,mouseY
		for child in @children
			if child.moved? then child.moved m
			child.mouseMoved()

	mousePressed : ->
		m = new Vector mouseX,mouseY
		for child in @children
			if child.contains m
				print child.pressed
				if child.pressed? then child.pressed()
			child.mousePressed()

	move : (dx,dy) -> [@x,@y] = [@x+dx,@y+dy]

class Group extends Shape
	constructor : (x,y,parent,options={}) -> super x,y,parent,options
	contains : ->

class Polygon extends Shape
	constructor : (x,y,parent,options={}) -> 
		super x,y,parent,options
		@points = []
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
	constructor : (x,y,@radius,parent,options={}) -> super x,y,parent,options
	draw : ->
		super()
		fill @fillColor
		strokeWeight @strokeWeight
		circle 0,0,@radius
		@drawTitle()
	inside : (d) -> @radius >= sqrt d.x*d.x+d.y*d.y

class Ellipse extends Shape
	constructor : (x,y,@w,@h,parent,options={}) -> super x,y,parent,options
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
	constructor : (x,y,radius,start,stopp,parent,options={}) ->
		super x,y,parent,options
		@lineTo 0,0
		lst = range start,stopp,10
		lst.push stopp
		for v in lst
			x = radius * cos v
			y = radius * sin v
			@lineTo x,y

class Rect extends Polygon
	constructor : (x,y,w,h,parent,options={}) ->
		super x,y,parent,options
		w = w/2
		h = h/2
		@lineTo -w,-h
		@lineTo +w,-h
		@lineTo +w,+h
		@lineTo -w,+h

class Triangle extends Polygon
	constructor : (x,y,x1,y1,x2,y2,x3,y3,parent,options={}) ->
		super x,y,parent,options
		@lineTo x1,y1
		@lineTo x2,y2
		@lineTo x3,y3

class Quad extends Polygon
	constructor : (x,y,x1,y1,x2,y2,x3,y3,x4,y4,parent,options={}) ->
		super x,y,parent,options
		@lineTo x1,y1
		@lineTo x2,y2
		@lineTo x3,y3
		@lineTo x4,y4

class Regular extends Polygon
	constructor : (x,y,r,n,parent,options={}) ->
		super x,y,parent,options
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

stage = new Shape 0,0,null
