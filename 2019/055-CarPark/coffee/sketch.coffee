SIZE = 2

class Point 
	constructor : (@x,@y) ->

class Car 
	# @active 
	#   0 = passive car
	#   1 = moving car 
	#   2 = target parking spot
	# @x,@y anger bakaxelns mittpunkt
	constructor : (@x,@y,@length,@width, @active=0, @direction=0, @speed=0, @steering=0) ->
		@makePolygon()

	clone : -> JSON.parse JSON.stringify @

	makePolygon : () =>
		a1 = atan2 -1,-1   # degrees 
		a2 = atan2 -1,4    # degrees
		d1 = SIZE * sqrt 20*20+20*20
		d2 = SIZE * sqrt 80*80+20*20
		@polygon = []
		@polygon.push @transform d1,a1  
		@polygon.push @transform d2,a2 
		@polygon.push @transform d2,-a2
		@polygon.push @transform d1,-a1 

	transform : (d,a) => new Point @x + d*cos(@direction+a),  @y+d*sin(@direction+a)

	draw : ->
		if @active == 2 then return  
		push()
		translate @x,@y
		rotate @direction

		fc 1
		if @active == 1 then fc 1,1,0

		rectMode CORNER
		rect -0.2*@length,-0.5*@width,@length,@width

		sw 5
		sc 0
		point 0,0
		sw 1

		@x0 = 0                  # bakaxel
		@x1 = 0 + 0.60 * @length # framaxel
		@y0 = 0 - 0.4 * @width
		@y1 = 0 + 0.4 * @width

		line @x0,@y0,@x0,@y1 
		line @x1,@y0,@x1,@y1 
		fc 0
		rectMode CENTER

		# rita bakhjul
		rect @x0,@y0,0.2*@length,0.2*@width
		rect @x0,@y1,0.2*@length,0.2*@width

		# rita VF
		push()
		translate @x1,@y0
		rotate 5*@steering
		rect 0,0,0.2*@length,0.2*@width
		pop()

		# rita HF
		push()
		translate @x1,@y1
		rotate 5*@steering
		rect 0,0,0.2*@length,0.2*@width
		pop()

		pop()

	update : ->
		if @active != 1 then return
		gs = navigator.getGamepads()
		if gs and gs[0] then @speed = -2 * gs[0].axes[1] 
		if gs and gs[0] then @steering = 10 * gs[0].axes[0] 
		@steering = constrain @steering,-30,30

		@x += @speed * cos @direction
		@y += @speed * sin @direction
		@direction += @speed/10 * @steering
		@makePolygon()
		@checkCollision()

	checkCollision : () ->
		for car in cars
			if car.active == 0
				if intersecting @polygon, car.polygon 
					@active = 0

cars = []
start = new Date()
bestScore = 999999999

setup = ->
	gs = navigator.getGamepads()
	createCanvas SIZE*800,1000
	angleMode DEGREES
	textSize 100
	for i in range 5
		for j in range 2
			x = 400+i*50*SIZE
			y = 100+j*300*SIZE
			cars.push new Car x,y,SIZE*100,SIZE*40,0,if j==0 then 90 else 270

	cars[7].active = 2 # target parking lot

	cars.push new Car SIZE*100,SIZE*200,SIZE*100,SIZE*40,1

	# car = new Car 100,100,100,40,false,0
	# assert car.polygon, [new Point(80,80),new Point(180,80),new Point(180,120),new Point(80,120)]
	# car.direction = 90
	# car.makePolygon()
	# assert car.polygon, [new Point(120,80),new Point(120.00000000000001,180),new Point(80,180), new Point(80,80)]
	# car.direction = 45
	# car.makePolygon()
	# assert car.polygon, [new Point(100, 71.7157287525381), new Point(170.71067811865476, 142.42640687119285), new Point(142.42640687119285, 170.71067811865476), new Point(71.7157287525381, 100)]
	# console.log 'ready'

draw = ->
	bg 0.5
	for car in cars
		car.draw()
	cars[10].update()
	stopp = new Date()
	temp = score(cars[10], cars[7]) + (stopp - start)/1000
	if temp < bestScore then bestScore = temp
	text round(bestScore),100,100

score = (a,b) ->
	result = 0
	for i in range 4
		result += distance a.polygon[i], b.polygon[i]
	result

distance = (p1,p2) -> dist p1.x,p1.y,p2.x,p2.y

# Checks if two polygons are intersecting.
intersecting = (a, b) => # polygons
	for polygon in [a,b]
		for i1 in range polygon.length
			i2 = (i1 + 1) % polygon.length
			p1 = polygon[i1]
			p2 = polygon[i2]

			normal = new Point p2.y - p1.y, p1.x - p2.x

			minA = null
			maxA = null

			for p in a
				projected = normal.x * p.x + normal.y * p.y
				if minA == null or projected < minA then minA = projected
				if maxA == null or projected > maxA then maxA = projected

			minB = null
			maxB = null
			for p in b
				projected = normal.x * p.x + normal.y * p.y
				if minB == null or projected < minB then minB = projected
				if maxB == null or projected > maxB then maxB = projected

			if maxA < minB or maxB < minA then return false
	true
