X = 400
Y = 400
R = 400

MAX_SPEED = 4 # grader/s
MAX_ACC   = 1 # grader/s2
LENGTH    = 5 # grader
DT     = 0.02 # ms

trains = []
stations = []
segments = []

totalDist = 0

pause = false

getPoint = (s) ->
	for segment in segments
		if s < segment.dist then return segment.point s	else s -= segment.dist

drawLine = (s1,s2) ->
	[x1,y1] = getPoint s1/360*totalDist
	[x2,y2] = getPoint s2/360*totalDist
	line x1,y1,x2,y2

corr = (a1,sp1,acc1,a2,sp2,security) ->
	distance = security + sp1*sp1/2/MAX_ACC
	d = a2-a1
	if d < 0 then d += 360
	if d <= distance then sp2-sp1 else MAX_ACC

class Station
	constructor : (@angle,@duration,@speed=0,@acc=0) ->
	correction : (angle,speed,acc) -> corr angle,speed,acc,@angle,@speed,@acc

	draw : ->
		fc()
		sc 0.1
		sw 5
		drawLine @angle,@angle-LENGTH

class Train
	constructor : (@angle, @r,@g,@b, @nextStation, @nextTrain, @maxSpeed=MAX_SPEED, @maxAcc=MAX_ACC, @duration=10000) ->
		@state = 'Run' # Stop Run
		@speed = 0
		@acc = @maxAcc
		@nextStart = millis()

	correction : (angle,speed,acc) -> corr angle,speed,acc,@angle,@speed,2*LENGTH

	update : (nr) ->

		@nr = nr
		t = @maxSpeed/@maxAcc # 4
		s = @maxAcc * t*t / 2 # 8
		dt = trains[@nextTrain].angle - @angle
		ds = stations[@nextStation].angle - @angle

		if dt<0 then dt += 360
		if ds<0 then ds += 360

		if @state=='Run'

			if ds < 0.1 #perrongstopp
				@acc = 0
				@speed = 0
				@nextStart = millis() + @duration
				@state = 'Stop'
			else
				@s = stations[@nextStation].correction @angle,@speed,@acc
				@t = trains[@nextTrain].correction @angle,@speed,@acc
				@s = constrain @s,-1,1
				@t = constrain @t,-1,1
				@acc = _.min [@s,@t]

		else
			@acc = 0
			if millis() > @nextStart
				@nextStation = (@nextStation + 1) % stations.length
				@state = 'Run'
				@acc = @maxAcc

		if pause then return

		@speed += @acc * DT
		if @speed > @maxSpeed
			@acc=0
			@speed = @maxSpeed
		if @speed < 0 then @speed = 0
		@angle = (@angle + @speed*DT) %% 360

	draw : (nr) ->
		@update nr
		fc()
		sc @r,@g,@b
		sw 5

		drawLine @angle,@angle-LENGTH

		fc @r,@g,@b
		y = 300+30*nr
		sc()
		text @state, 200,y
		text nf(@acc,0,1), 300,y
		text round(@angle), 400,y
		text nf(@speed,0,1), 500,y
		if @nextStart > millis() then text round((@nextStart - millis())/1000), 600,y
		text @nextStation, 700,y

class Segment
	constructor : (@x1,@y1,@x2,@y2,@x3,@y3,@x4,@y4,@steps=32) ->
		@dist  = 0
		for i in range @steps+1
			xa = bezierPoint @x1, @x2, @x3, @x4, i / @steps
			ya = bezierPoint @y1, @y2, @y3, @y4, i / @steps
			xb = bezierPoint @x1, @x2, @x3, @x4, (i+1) / @steps
			yb = bezierPoint @y1, @y2, @y3, @y4, (i+1) / @steps
			@dist += dist xa,ya, xb,yb
	point : (d) -> [bezierPoint(@x1, @x2, @x3, @x4, d/@dist), bezierPoint(@y1, @y2, @y3, @y4, d/@dist)]
	draw : -> bezier @x1,@y1,@x2,@y2,@x3,@y3,@x4,@y4

setup = ->
	createCanvas 800,800
	textSize 20
	textAlign RIGHT
	frameRate 50

	stations.push new Station 50,60
	stations.push new Station 101,60
	stations.push new Station 183,60
	stations.push new Station 224,60
	stations.push new Station 337,60

	trains.push new Train 0, 1,0,0, 0,1, MAX_SPEED*1.5, MAX_ACC*1.1, 5000
	trains.push new Train 75, 1,1,0, 1,2
	trains.push new Train 135, 0,1,0, 2,3
	trains.push new Train 220, 0,1,1, 3,4
	trains.push new Train 260, 0,0,1, 4,0

	x1=width/2;     y1=0
	x2=1.164*width;  y2=0
	x3=1.164*width;  y3=height
	x4=width/2;     y4=height
	x5=-0.164*width; y5=height
	x6=-0.164*width; y6=0

	segments.push new Segment x1,y1,x2,y2,x3,y3,x4,y4
	segments.push new Segment x4,y4,x5,y5,x6,y6,x1,y1

	totalDist = segments[0].dist+segments[1].dist
	print totalDist

draw = ->
	bg 0.5
	scale 0.9
	sc 0
	sw 1
	#circle X,Y,R
	fc 1
	y = 270
	fc 1
	sc()
	sw 0
	text 'state', 200,y
	text 'acc',   300,y
	text 'angle', 400,y
	text 'speed', 500,y
	text 'sec',   600,y
	text 'next',  700,y

	for segment in segments
		sc 1
		sw 1
		fc()
		segment.draw()

	station.draw() for station in stations
	train.draw i for train,i in trains

mousePressed = ->	pause = not pause
