MSPEED = 25 # m/s
MACC = 1.25 # m/s2
MLEN = 3*46.5 # m
MWIDTH = 3  # m
MTOTAL = 2 * 19600 # m

FACTOR = 24.3 # m/pixel MTOTAL/1611.5
MM = 0.001/FACTOR # pixel/mm

MAX_SPEED = MSPEED/FACTOR # pixlar/s
MAX_ACC   = MACC/FACTOR # pixlar/s2
LENGTH    = MLEN/FACTOR # pixlar
WIDTH     = MWIDTH/FACTOR # 0.5 # pixlar # 3,5 osv ger icke sammanhängande bezier med line. 0.5,2,4 ok
DT        = 0.02 # ms

names = 'Åkeshov Brommaplan Abrahamsberg StoraMossen Alvik Kristineberg Thorildsplan Fridhemsplan S:tEriksplan Odenplan Rådmansgatan Hötorget T-centralen GamlaStan Slussen Medborgarplatsen Skanstull Gullmarsplan Skärmarbrink Hammarbyhöjden Björkhagen Kärrtorp Bagarmossen Skarpnäck'.split ' '
trains = []
stations = []
segments = []

totalDist = 0 # pixlar

pause = false
factor = 37.4
[X0,Y0]=[-483,1.778]
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
		drawLine @angle,@angle-LENGTH
		[x,y] = getPoint @angle-0.5*LENGTH
		sw 0
		fc 0
		textSize 5/3
		textAlign CENTER,CENTER
		text @name,x-7.5,y

class Train
	constructor : (@angle, @r,@g,@b, @nextStation, @nextTrain, @maxSpeed=MAX_SPEED, @maxAcc=MAX_ACC, @duration=60000) ->
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

			if ds < 0.001 #perrongstopp 1 mm
				@acc = 0
				@speed = 0
				@nextStart = millis() + @duration
				@state = 'Stop'
			else
				@s = stations[@nextStation].correction @angle,@speed,@acc
				@t = trains[@nextTrain].correction @angle,@speed,@acc
				@s = constrain @s,-MAX_ACC,MAX_ACC
				@t = constrain @t,-MAX_ACC,MAX_ACC
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

		for i in range 9
			a0 = @angle - i*LENGTH/9 - 250*MM
			a1 = @angle - (i+1)*LENGTH/9 + 250*MM
			drawLine a0,a1

	drawText : (nr) ->
		fc @r,@g,@b
		y = 40+20*nr
		sc()
		textSize 16
		textAlign RIGHT,CENTER
		text @state, 50,y
		text nf(FACTOR*@acc,0,2), 100,y
		text round(FACTOR*@speed), 150,y
		text round(@angle/totalDist * MTOTAL), 200,y
		if @nextStart > millis() then text round((@nextStart - millis())/1000), 250,y
		textAlign LEFT,CENTER
		if @nextStation<24
			text names[@nextStation], 270,y
		else
			text names[47-@nextStation], 270,y

class ASegment # Straight
	constructor : (@a,@b, @c,@d) -> @dist = dist @a,@b, @c,@d
	point : (d) -> [d/@dist*@c+(@dist-d)/@dist*@a, d/@dist*@d+(@dist-d)/@dist*@b]
	draw : -> line @a,@b, @c,@d

class BSegment # Bezier
	constructor : (@a,@b, @c,@d, @e,@f, @g,@h,@steps=16) ->
		@dist  = 0
		for i in range @steps+1
			[xa,ya] = @bp i / @steps
			[xb,yb] = @bp (i+1) / @steps
			@dist += dist xa,ya, xb,yb
	point : (d) -> @bp d/@dist
	bp : (t) -> [bezierPoint(@a,@c,@e,@g,t), bezierPoint(@b,@d,@f,@h,t)]
	draw : -> bezier @a,@b, @c,@d, @e,@f, @g,@h

setup = ->
	cnv = createCanvas 1000,800
	cnv.mouseWheel changeScale

	strokeCap SQUARE

	textSize 16
	textAlign RIGHT
	frameRate 50

	x1 = 485
	x2 = 500
	y0 = 0
	y1 = 10
	y2 = 790
	y3 = 800
	segments.push new ASegment x2,y1, x2,y2
	segments.push new BSegment x2,y2, x2,y3, x1,y3, x1,y2
	segments.push new ASegment x1,y2, x1,y1
	segments.push new BSegment x1,y1, x1,y0, x2,y0, x2,y1

	sc 1
	sw 1

	for segment in segments
		totalDist += segment.dist
	print totalDist

	for i in range 48
		if i<24 then name = names[i] else name = ''
		stations.push new Station 0.0042 + i/48,name,60

	trains.push new Train 0.00, 1,0,0, 0,1
	trains.push new Train 0.10, 1,1,0, 5,2
	trains.push new Train 0.20, 0,1,0, 10,3
	trains.push new Train 0.30, 0,1,1, 15,4
	trains.push new Train 0.40, 0,0,1, 19,5
	trains.push new Train 0.50, 1,0,1, 24,6
	trains.push new Train 0.60, 0.5,1,0, 29,7
	trains.push new Train 0.70, 0.75,0.75,0.75, 34,8
	trains.push new Train 0.80, 0.20,0.30,0.40, 39,9
	trains.push new Train 0.90, 0.25,0.25,0.25, 43,0

draw = ->
	bg 0.5

	sc 0
	fc 1
	sw 0
	y = 20
	textSize 16
	textAlign RIGHT,CENTER
	text 'state', 50,y
	text 'm/s2', 100,y
	text 'm/s',  150,y
	text 'm',    200,y
	text 's',    250,y
	text 'dest', 300,y
	train.drawText i for train,i in trains

	scale factor
	translate X0,Y0

	for segment in segments
		sc 1
		sw WIDTH
		fc()
		segment.draw()

	station.draw() for station in stations
	train.draw i for train,i in trains

mousePressed = -> memory = [mouseX,mouseY]
mouseDragged = ->
	X0 += (mouseX - memory[0]) / factor
	Y0 += (mouseY - memory[1]) / factor
	memory = [mouseX,mouseY]
	print X0,Y0,factor

changeScale = (event) ->
	S = 1.1
	X0 -= mouseX / factor
	Y0 -= mouseY / factor
	factor = if event.deltaY > 0 then factor/S else factor*S
	X0 += mouseX / factor
	Y0 += mouseY / factor
