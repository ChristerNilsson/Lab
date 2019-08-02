SIZE = 2

cars = []
start = new Date()
bestScore = 999999999
centerX = null
centerY = null

active = null
parkinglot = null

class Point 
	constructor : (@x,@y) ->

class Car 
	# @active 
	#   0 = passive car
	#   1 = moving car 
	#   2 = target parking spot
	# @x,@y is the middle point of the read axis
	constructor : (@x,@y,@length,@width, @active=0, @direction=0, @speed=0, @steering=0) ->
		@tracks = []
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

	makeTrack : () =>
		a1 = atan2 -1,0   # degrees 
		a2 = atan2 -1,4   # degrees
		d1 = SIZE * sqrt 15*15
		d2 = SIZE * sqrt 60*60+15*15
		polygon = []
		polygon.push @transform d2,-a2
		polygon.push @transform d1,-a1 
		polygon.push @transform d1,a1  
		polygon.push @transform d2,a2 
		@tracks.push polygon

		n = @tracks.length
		if n<2 then return 
		[p1,p2,p3,p4] = @tracks[n-1]
		[q1,q2,q3,q4] = @tracks[n-2]
		if 10 > dist p1.x,p1.y,q1.x,q1.y then @tracks.pop()
		if n > 50 then @tracks.shift()

	transform : (d,a) => new Point @x + d*cos(@direction+a),  @y+d*sin(@direction+a)

	drawTracks : ->
		if @tracks.length < 1 then return 
		sw 12
		for i in range @tracks.length-1
			sc 0.5 - i * 0.01
			[p1,p2,p3,p4] = @tracks[i]
			[q1,q2,q3,q4] = @tracks[i+1]
			line p1.x,p1.y,q1.x,q1.y
			line p2.x,p2.y,q2.x,q2.y
			line p3.x,p3.y,q3.x,q3.y
			line p4.x,p4.y,q4.x,q4.y
		sw 1

	draw : ->
		if @active == 2 then return  
		@drawTracks()
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

		ww = 0.15*@width

		@x0 = 0                 # read axis
		@x1 = 0 + 0.6 * @length # front axis
		@y0 = 0 - 0.4 * @width
		@y1 = 0 + 0.4 * @width

		line @x0,@y0,@x0,@y1 
		line @x1,@y0,@x1,@y1 
		fc 0
		rectMode CENTER

		# draw rear wheels
		rect @x0,@y0,0.2*@length,ww
		rect @x0,@y1,0.2*@length,ww

		# draw front left wheel
		push()
		translate @x1,@y0
		rotate @steering
		rect 0,0,0.2*@length,ww
		pop()

		# draw front right wheel
		push()
		translate @x1,@y1
		rotate @steering
		rect 0,0,0.2*@length,ww
		pop()

		pop()

	update : ->
		if @active != 1 then return
		if centerX in [null,undefined] then return
		if centerY in [null,undefined] then return

		# gs = navigator.getGamepads()
		# if gs and gs[0] then @speed = -2 * gs[0].axes[1] 
		# if gs and gs[0] then @steering = 10 * gs[0].axes[0] 
		# @steering = constrain @steering,-30,30

		@steering = (mouseX-centerX)/10
		@speed    = (centerY-mouseY)/100
		
		@steering = constrain @steering,-90,90
		@speed = constrain @speed,-10,10

		[@x,@y,@direction] = calc @x,@y,@length,@direction,@speed,@steering

		@makePolygon()
		@makeTrack()
		@checkCollision()

	checkCollision : () ->
		for car in cars
			if car.active == 0
				if intersecting @polygon, car.polygon 
					@active = 0

calc = (x,y,length,direction,speed,steering) ->
	len = 0.6 * length
	xc = x + len * cos(direction) + speed * cos(direction+steering)
	yc = y + len * sin(direction) + speed * sin(direction+steering)
	distance = dist x,y,xc,yc
	d = distance - len
	direction = atan2 yc-y, xc-x			
	[x + d * cos(direction), y + d * sin(direction), direction]

setup = ->
	angleMode DEGREES
	#assert [], calc 0,0,3,90,1,45
	#gs = navigator.getGamepads()
	createCanvas SIZE*800,1000
	textSize 100

problem1 = ->
	for i in range 5
		for j in range 2
			x = 400+i*50*SIZE
			y = 100+j*300*SIZE
			cars.push new Car x,y,SIZE*100,SIZE*40,0,if j==0 then 90 else 270
	parkinglot = cars[7]
	parkinglot.active = 2 
	active = new Car SIZE*100,SIZE*200,SIZE*100,SIZE*40,1
	cars.push active

problem2 = ->
	for i in range 2
		for j in range 3
			x = 400+i*150*SIZE
			y = 200+j*120*SIZE
			cars.push new Car x,y,SIZE*100,SIZE*40,0,if i==0 then 90 else 270
	parkinglot = cars[4]
	parkinglot.active = 2 # target parking lot
	x = 400+1*95*SIZE
	y = 200+3*120*SIZE
	active = new Car x,y,SIZE*100,SIZE*40,1,270
	cars.push active

init = ->
	cars = []
	start = new Date()
	bestScore = 999999999
	centerX = mouseX
	centerY = mouseY
	if random() < 0.5 then problem1() else problem2()

	# car = new Car 100,100,100,40,false,0
	# assert car.polygon, [new Point(80,80),new Point(180,80),new Point(180,120),new Point(80,120)]
	# car.direction = 90
	# car.makePolygon()
	# assert car.polygon, [new Point(120,80),new Point(120.00000000000001,180),new Point(80,180), new Point(80,80)]
	# car.direction = 45
	# car.makePolygon()
	# assert car.polygon, [new Point(100, 71.7157287525381), new Point(170.71067811865476, 142.42640687119285), new Point(142.42640687119285, 170.71067811865476), new Point(71.7157287525381, 100)]
	# console.log 'ready'

mousePressed = -> init()

draw = ->
	if cars.length == 0 then return 
	bg 0.5

	line 0,centerY,width,centerY
	line centerX,height,centerX,0

	for car in cars
		car.draw()
	active.update()
	stopp = new Date()
	temp = score(parkinglot, active) + (stopp - start)/1000
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
