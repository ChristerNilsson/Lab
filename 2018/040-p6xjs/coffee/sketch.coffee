stage = null
cn = {}
#########

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

	clicked : (f) -> @click = f

	mouseMoved : (m) -> # m = mouse position
		for child in @children
			child.strokeWeight = if child.contains m then 3 else 1
			child.mouseMoved m

	mousePressed : (m) -> # m = mouse position
		for child in @children
			if child.click? 
				if child.contains m then child.click()
			child.mousePressed m

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
	cn.circle(300,300,200).fill "#ff0"
	shapes.letters = cn.group 300,300
	shapes.digits = cn.group 300,300

	alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	for letter,i in alfabet
		x = 200 * cos i*360/alfabet.length
		y = 200 * sin i*360/alfabet.length
		cn.circle(x,y,20,shapes.letters).fill("#f00").text(letter).clicked -> print @txt

	numbers = '0123456789'
	for digit,i in numbers
		x = 260 * cos i*360/numbers.length
		y = 260 * sin i*360/numbers.length
		cn.circle(x,y,40,shapes.digits).fill("#0f0").text(digit).clicked -> print @txt

draw = ->
	bg 0.5
	stage.draw()

	shapes.letters.rotation += 0.1
	for child in shapes.letters.children
		child.rotation -= 0.1

	shapes.digits.rotation -= 0.1
	for child in shapes.digits.children
		child.rotation += 0.1

mouseMoved   = ->	stage.mouseMoved   new Vector mouseX,mouseY
mousePressed = ->	stage.mousePressed new Vector mouseX,mouseY
