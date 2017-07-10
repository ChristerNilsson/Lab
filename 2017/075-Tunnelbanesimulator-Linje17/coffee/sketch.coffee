MAX_SPEED = 0.4 # pixlar/s
MAX_ACC   = 0.025 # pixlar/s2
LENGTH    = 5 # pixlar
WIDTH     = 0.5 # pixlar # 3,5 osv ger icke sammanhängande bezier med line. 0.5,2,4 ok
DT        = 0.02 # ms

names = 'Åkeshov Brommaplan Abrahamsberg StoraMossen Alvik Kristineberg Thorildsplan Fridhemsplan S:tEriksplan Odenplan Rådmansgatan Hötorget T-centralen GamlaStan Slussen Medborgarplatsen Skanstull Gullmarsplan Skärmabrink Hammarbyhöjden Björkhagen Kärrtorp Bagarmossen Skarpnäck'.split ' '
trains = []
stations = []
segments = []

totalDist = 0 # pixlar

pause = false
factor = 1.0
[X0,Y0]=[0,0]
memory = [0,0]

getPoint = (s) ->
	s %%= totalDist
	for segment in segments
		if s <= segment.dist then return segment.point s else s -= segment.dist

drawLine = (s1,s2) ->
	[x1,y1] = getPoint s1
	[x2,y2] = getPoint s2
	line x1,y1,x2,y2

corr = (a1,sp1,acc1,a2,sp2,security) ->
	distance = security + sp1*sp1/2/MAX_ACC
	d = a2-a1
	if d < 0 then d += totalDist
	if d <= distance then sp2-sp1 else MAX_ACC

class Station
	constructor : (@angle,@name,@duration,@speed=0,@acc=0) -> @angle *= totalDist
	correction : (angle,speed,acc) -> corr angle,speed,acc,@angle,@speed,@acc
	draw : ->
		fc()
		sc 0.1
		sw WIDTH
		drawLine @angle,@angle-2.55
		drawLine @angle-2.45,@angle-LENGTH
		[x,y] = getPoint @angle-2.5
		sw 0
		fc 0
		textSize 5
		textAlign LEFT,CENTER
		text @name,x+2,y

class Train
	constructor : (@angle, @r,@g,@b, @nextStation, @nextTrain, @maxSpeed=MAX_SPEED, @maxAcc=MAX_ACC, @duration=30000) ->
		@state = 'Run' # Stop Run
		@speed = 0
		@acc = @maxAcc
		@nextStart = millis()
		@angle *= totalDist

	correction : (angle,speed,acc) -> corr angle,speed,acc,@angle,@speed,LENGTH * 2

	update : (nr) ->

		@nr = nr
		t = @maxSpeed/@maxAcc # 4
		s = @maxAcc * t*t / 2 # 8
		dt = trains[@nextTrain].angle - @angle
		ds = stations[@nextStation].angle - @angle

		if dt<0 then dt += totalDist
		if ds<0 then ds += totalDist

		if @state=='Run'

			if ds < 0.05 #perrongstopp
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

		drawLine @angle,@angle-2.4
		drawLine @angle-2.6,@angle-LENGTH

	drawText : (nr) ->
		fc @r,@g,@b
		y = 40+20*nr
		sc()
		textSize 16
		textAlign RIGHT,CENTER
		text @state, 50,y
		text round(100*@acc), 100,y
		text round(@angle * 19600/totalDist), 150,y
		text round(100*@speed), 200,y
		if @nextStart > millis() then text round((@nextStart - millis())/1000), 250,y
		textAlign LEFT,CENTER
		if @nextStation<24
			text names[@nextStation], 270,y
		else
			text names[23-@nextStation %% 24], 270,y

class ASegment # Straight
	constructor : (@p1,@p2) ->
		@dist = dist @p1[0],@p1[1], @p2[0],@p2[1]
	point : (d) -> [d/@dist*@p2[0]+(@dist-d)/@dist*@p1[0], d/@dist*@p2[1]+(@dist-d)/@dist*@p1[1]]
	draw : -> line @p1[0],@p1[1], @p2[0],@p2[1]

class BSegment # Bezier
	constructor : (@p1,@p2,@p3,@p4,@steps=16) ->
		@dist  = 0
		for i in range @steps+1
			xa = bezierPoint @p1[0],@p2[0],@p3[0],@p4[0], i / @steps
			ya = bezierPoint @p1[1],@p2[1],@p3[1],@p4[1], i / @steps
			xb = bezierPoint @p1[0],@p2[0],@p3[0],@p4[0], (i+1) / @steps
			yb = bezierPoint @p1[1],@p2[1],@p3[1],@p4[1], (i+1) / @steps
			@dist += dist xa,ya, xb,yb
	point : (d) -> [bezierPoint(@p1[0],@p2[0],@p3[0],@p4[0], d/@dist), bezierPoint(@p1[1],@p2[1],@p3[1],@p4[1], d/@dist)]
	draw : -> bezier @p1[0],@p1[1],@p2[0],@p2[1],@p3[0],@p3[1],@p4[0],@p4[1]

setup = ->
	cnv = createCanvas 1000,800
	cnv.mouseWheel changeScale

	strokeCap SQUARE

	textSize 16
	textAlign RIGHT
	frameRate 50

	x1 = 480
	x2 = 500
	y0 = 0
	y1 = 15
	y2 = 785
	y3 = 800
	segments.push new ASegment [x2,y1],[x2,y2]
	segments.push new BSegment [x2,y2],[x2,y3],[x1,y3],[x1,y2]
	segments.push new ASegment [x1,y2],[x1,y1]
	segments.push new BSegment [x1,y1],[x1,y0],[x2,y0],[x2,y1]

	sc 1
	sw 1

	for segment in segments
		totalDist += segment.dist

	for i in range 48
		if i<24 then name = names[i] else name = ''
		stations.push new Station 0.0006 + i/48,name,60

	trains.push new Train 0.10, 1,0,0, 5,1 #, MAX_SPEED*1.5, MAX_ACC*1.1, 5000
	trains.push new Train 0.30, 1,1,0, 15,2
	trains.push new Train 0.50, 0,1,0, 25,3
	trains.push new Train 0.70, 0,1,1, 34,4
	trains.push new Train 0.90, 0,0,1, 44,0

draw = ->
	bg 0.5

	sc 0
	fc 1
	sw 0
	y = 20
	textSize 16
	textAlign RIGHT,CENTER
	text 'state',  50,y
	text 'acc',   100,y
	text 'pos',   150,y
	text 'sp',    200,y
	text 'sec',   250,y
	text 'dest',  300,y
	train.drawText i for train,i in trains

	translate X0,Y0
	scale factor

	for segment in segments
		sc 1
		sw WIDTH
		fc()
		segment.draw()

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
