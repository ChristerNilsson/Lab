MAX_SPEED = 8 # pixlar/s
MAX_ACC   = 2 # pixlar/s2
LENGTH    = 10 # pixlar
WIDTH     = 2 # pixlar
DT        = 0.02 # ms

trains = []
stations = []
segments = []

totalDist = 0 # pixlar

pause = false
factor = 1.0
[X0,Y0]=[0,0]
memory = [0,0]

getPoint = (ss) ->
	ss %%= totalDist
	s = ss + 0
	for segment in segments
		if s <= segment.dist then return segment.point s else s -= segment.dist

drawLine = (s1,s2) ->
	[x1,y1] = getPoint s1
	[x2,y2] = getPoint s2
	#print s1,s2,x1,y1,x2,y2
	line x1,y1,x2,y2

corr = (a1,sp1,acc1,a2,sp2,security) ->
	distance = security + sp1*sp1/2/MAX_ACC
	d = a2-a1
	if d < 0 then d += totalDist
	if d <= distance then sp2-sp1 else MAX_ACC

class Station
	constructor : (@angle,@duration,@speed=0,@acc=0) -> @angle *= totalDist
	correction : (angle,speed,acc) -> corr angle,speed,acc,@angle,@speed,@acc
	draw : ->
		fc()
		sc 0.1
		sw WIDTH
		drawLine @angle,@angle-LENGTH

class Train
	constructor : (@angle, @r,@g,@b, @nextStation, @nextTrain, @maxSpeed=MAX_SPEED, @maxAcc=MAX_ACC, @duration=10000) ->
		@state = 'Run' # Stop Run
		@speed = 0
		@acc = @maxAcc
		@nextStart = millis()
		@angle *= totalDist

	correction : (angle,speed,acc) -> corr angle,speed,acc,@angle,@speed,3*LENGTH

	update : (nr) ->

		@nr = nr
		t = @maxSpeed/@maxAcc # 4
		s = @maxAcc * t*t / 2 # 8
		dt = trains[@nextTrain].angle - @angle
		ds = stations[@nextStation].angle - @angle

		if dt<0 then dt += totalDist
		if ds<0 then ds += totalDist

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
		@angle = (@angle + @speed*DT) %% totalDist

	draw : (nr) ->
		@update nr
		fc()
		sc @r,@g,@b
		sw WIDTH

		drawLine @angle,@angle-LENGTH

		fc @r,@g,@b
		y = 40+20*nr
		sc()
		text @state, 50,y
		text nf(@acc,0,1), 100,y
		text round(@angle), 150,y
		text nf(@speed,0,1), 200,y
		if @nextStart > millis() then text round((@nextStart - millis())/1000), 250,y
		text @nextStation, 300,y

class ASegment # Straight
	constructor : (@x1,@y1,@x2,@y2) -> @dist = dist @x1,@y1, @x2,@y2
	point : (d) -> [d/@dist*@x2+(@dist-d)/@dist*@x1, d/@dist*@y2+(@dist-d)/@dist*@y1]
	draw : -> line @x1,@y1,@x2,@y2

class BSegment # Bezier
	constructor : (@x1,@y1,@x2,@y2,@x3,@y3,@x4,@y4,@steps=10) ->
		@dist  = 0
		for i in range @steps+1
			xa = bezierPoint @x1, @x2, @x3, @x4, i / @steps
			ya = bezierPoint @y1, @y2, @y3, @y4, i / @steps
			xb = bezierPoint @x1, @x2, @x3, @x4, (i+1) / @steps
			yb = bezierPoint @y1, @y2, @y3, @y4, (i+1) / @steps
			#print xa,ya,xb,yb
			@dist += dist xa,ya, xb,yb
		#print @dist
	point : (d) -> [bezierPoint(@x1, @x2, @x3, @x4, d/@dist), bezierPoint(@y1, @y2, @y3, @y4, d/@dist)]
	draw : -> bezier @x1,@y1,@x2,@y2,@x3,@y3,@x4,@y4

setup = ->
	cnv = createCanvas 800,800
	cnv.mouseWheel changeScale

	textSize 20
	textAlign RIGHT
	frameRate 50

	x0=320
	x1=400
	x2=480

	y0=-5
	y1=95
	y2=695+20
	y3=795+20

	sc 1
	sw 1

	segments.push new BSegment x0,y1, x0,y0, x2,y0, x2,y1
	segments.push new ASegment x2,y1, x2,y2
	segments.push new BSegment x2,y2, x2,y3, x0,y3, x0,y2
	segments.push new ASegment x0,y2, x0,y1

	for segment in segments
		totalDist += segment.dist
	#print totalDist

	for i in range 48
		stations.push new Station i/48,60
	#stations.push new Station 0.40,60
	#stations.push new Station 0.60,60
	#stations.push new Station 0.80,60
	#stations.push new Station 0.95,60

	trains.push new Train 0.10, 1,0,0, 0,1, MAX_SPEED*1.5, MAX_ACC*1.1, 5000
	trains.push new Train 0.30, 1,1,0, 1,2
	trains.push new Train 0.50, 0,1,0, 2,3
	trains.push new Train 0.70, 0,1,1, 3,4
	trains.push new Train 0.90, 0,0,1, 4,0

draw = ->
	bg 0.5
	translate X0,Y0
	scale factor

	sc 0
	fc 1
	sw 0
	y = 20
	text 'state',  50,y
	text 'acc',   100,y
	text 'pos',   150,y
	text 'sp',    200,y
	text 'sec',   250,y
	text 'next',  300,y

	for segment in segments
		sc 1
		sw 2
		fc()
		segment.draw()
	#line 320,95,480,95

	station.draw() for station in stations
	train.draw i for train,i in trains

mousePressed = -> memory = [mouseX,mouseY]
mouseDragged = ->
	X0 += (mouseX-memory[0])
	Y0 += (mouseY-memory[1])
	memory = [mouseX,mouseY]

changeScale = (event) ->
	if event.deltaY > 0
		X0 = (X0+mouseX)/2
		Y0 = (Y0+mouseY)/2
		factor /= 2
	else
		X0 = 2*X0-mouseX
		Y0 = 2*Y0-mouseY
		factor *= 2
