stage = null
cn = {}
#########
karusell = null

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

testVector = ->
	a = new Vector 10,20
	assert 10,a.x
	assert 20,a.y
	a = a.rotate 90
	assert -20.000000000000004,a.x
	assert 9.999999999999995,a.y
	b = new Vector 10,10
	assert 45, b.rotation
	assert 14.142135623730951,b.length
	c = b.add b
	assert 20,c.x
	assert 20,c.y
	c = c.sub b
	assert 10,c.x
	assert 10,c.y

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
		p2 = new Vector x,y
		p3 = m.sub p2
		p4 = p3.rotate -rotation
		@inside p4 #, @points

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

testCircle = ->
	c = new Circle 100,200,50
	assert 100,c.x
	assert 200,c.y
	assert 50,c.radius
	assert [100.00000000000001, 200, 0], c.stagepos()
	assert true,c.contains new Vector 110,210
	assert true,c.contains new Vector 129,239
	assert false,c.contains new Vector 131,241

class Arc extends Polygon
	constructor : (x,y,radius,start,stopp,parent=stage) ->
		super x,y,parent
		for v in range start,stopp+1,10
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

testRect = ->
	r = cn.rect 100,200,10,20
	assert -5,r.points[0].x
	assert -10,r.points[0].y
	assert 5,r.points[1].x
	assert -10,r.points[1].y
	assert 5,r.points[2].x
	assert 10,r.points[2].y
	assert -5,r.points[3].x
	assert 10,r.points[3].y
	assert true,r.inside new Vector 1,1
	assert true,r.inside new Vector 5,10
	assert false,r.inside new Vector 6,10
	assert false,r.inside new Vector 5,11
	assert [100.00000000000001, 200, 0], r.stagepos()
	assert true, r.contains new Vector 100+4,200+4
	assert true, r.contains new Vector 100-4,200-4
	assert true, r.contains new Vector 100-4,200+4
	assert true, r.contains new Vector 100+4,200-4

	r = cn.rect 100,200,10,10
	r.rotation = 45
	print r
	assert true, r.contains new Vector 100+3,200+3
	assert false, r.contains new Vector 100+4,200+4
	assert true, r.contains new Vector 100+7,200+0
	assert false, r.contains new Vector 100+8,200+0
	# assert true, r.contains new Vector 100-4,200-4
	# assert true, r.contains new Vector 100-4,200+4
	# assert true, r.contains new Vector 100+4,200-4

#	assert true,r.contains new Vector 1,1
	# d2 = new Vector 140,230
	# assert true,r.contains d1.sub d2
	# d2 = new Vector 141,231
	# assert false,r.contains d1.sub d2

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
	
	# testVector()
	# testCircle()
	# testRect()

	stage = new Shape()
	karusell = cn.group 200,200
	karusell.name = 'karusell'
	a=cn.circle(0,0,100,karusell).fill "#ff0"
	b=cn.rect(0,-100,100,100,karusell).fill "#f00"
	a.name = 'circle'
	b.name = 'rect'
	cn.rect(-100,0,100,100,karusell).fill "#0f0"
	cn.circle(0,100,50,karusell).fill "#fff"
	cn.arc(100,0, 50,0,180,karusell).fill "#f00"
	cn.arc(100,0,-50,0,180,karusell).fill "#0f0"

	karusell.rotation = 45
	#xdraw()
	#xdraw()
	print stage 

draw = ->
	bg 1
	stage.draw() 
	karusell.rotation += 0.1
	for child in karusell.children
		child.rotation += 0.05

mouseMoved = ->	stage.mouseMoved new Vector mouseX,mouseY
