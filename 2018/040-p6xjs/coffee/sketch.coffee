stage = null
cn = {}
#########

karusell = null
shapes = {}

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

	mouseMoved : (m) -> # m = mouse position
		for child in @children
			child.strokeWeight = if child.contains m then 3 else 1
			child.mouseMoved m

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
	inside : (d) -> @radius >= sqrt d.x*d.x+d.y*d.y 

# class Circle extends Polygon
# 	constructor : (x,y,@radius,parent=stage) -> 
# 		super x,y,parent
# 		for v in range 0,361,10
# 			x = @radius * cos v
# 			y = @radius * sin v
# 			@lineTo x,y

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

cn.shape  = (...args) -> new Shape ...args
cn.group  = (...args) -> new Group ...args
cn.circle = (...args) -> new Circle ...args
cn.arc    = (...args) -> new Arc ...args
cn.rect   = (...args) -> new Rect ...args

##########################

setup = ->
	createCanvas 600,600
	angleMode DEGREES
	
	# test()

	stage = new Shape()
	karusell = cn.group 200,200
	cn.circle(0,0,100,karusell).fill "#ff0"
	cn.rect(0,-100,100,100,karusell).fill "#f00"
	cn.rect(-100,0,100,100,karusell).fill "#0f0"
	cn.circle(0,100,50,karusell).fill "#fff"
	cn.arc(100,0, 50,0,180,karusell).fill "#f00"
	cn.arc(100,0,-50,0,180,karusell).fill "#0f0"

	shapes.r1 = cn.rect 200,400,50,100
	shapes.r2 = cn.rect 300,400,50,100
	shapes.a1 = cn.arc  100,400,50,0,45
	shapes.a2 = cn.arc  100,400,50,45,90

	#karusell.rotation = 45
	#print stage 

draw = ->
	bg 1
	stage.draw() 
	karusell.rotation += 0.1
	for child in karusell.children
		child.rotation += 0.05
	shapes.r2.rotation += 0.1
	shapes.r2.move 0.1,0
	shapes.a1.rotation += 0.1
	shapes.a2.rotation += 0.1

mouseMoved = ->	stage.mouseMoved new Vector mouseX,mouseY
