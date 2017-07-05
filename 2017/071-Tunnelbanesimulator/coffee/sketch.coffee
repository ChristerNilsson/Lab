X = 420
Y = 420
R = 400
MAX_SPEED = 10
MAX_ACC = 0.02

trains = []
stations = []

class Station
	constructor : (@angle,@duration) ->
	draw : ->
		start = radians @angle - 5
		stopp = radians @angle
		fc()
		sc 0.5
		sw 5
		arc X,Y,2*R,2*R,start,stopp

class Train
	constructor : (@angle, @r,@g,@b, @nextStation, @nextTrain, @maxSpeed=MAX_SPEED, @duration=10000) ->
		@state = 'R' # =stopped R=running
		@speed = 0
		@acc = MAX_ACC
		@nextStart = millis()

	update : ->
		if @state == ' '
			if millis() > @nextStart
				@nextStation = (@nextStation + 1) % stations.length
				@state = 'R'
				@acc = MAX_ACC
		else
			if @speed > @maxSpeed then @acc=0
			if @speed < 0 then @acc=0

			@speed += @acc
			@angle = (@angle + @speed/100) %% 360

			newSpeed1 = @speed
			newSpeed2 = @speed
			newSpeed3 = @speed

			d = abs(@angle - (stations[@nextStation].angle))
			if d < 20 then newSpeed1 = map(d, 20,0, @maxSpeed,2) # inbromsning pga station

			if d < 0.1 # stopp
				@acc = 0
				newSpeed2 = 0
				@nextStart = millis() + @duration
				@state = ' '

			d = abs(@angle - (trains[@nextTrain].angle-20))
			if d < 20 then newSpeed3 = map(d, 10,0, @maxSpeed,2) # inbromsning pga annat tåg

			@speed = _.min([newSpeed1,newSpeed2,newSpeed3])

	draw : (nr) ->
		@update()
		start = radians @angle-5
		stopp = radians @angle
		fc()
		sc @r,@g,@b
		sw 5
		arc X,Y,2*R,2*R,start,stopp
		fc @r,@g,@b
		y = 300+30*nr
		sc()
		text round(@speed), 450,y
		if @nextStart > millis() then text round((@nextStart - millis())/1000), 650,y
		text @nextStation, 700,y

setup = ->
	createCanvas 2*X+40,2*Y+40
	textSize 20
	textAlign RIGHT

	stations.push new Station 50,60
	stations.push new Station 100,60
	stations.push new Station 180,60
	stations.push new Station 240,60
	stations.push new Station 330,60

	trains.push new Train   0, 1,0,0, 0,1, MAX_SPEED+2, 5000
	trains.push new Train  70, 1,1,0, 1,2
	trains.push new Train 140, 0,1,0, 2,3
	trains.push new Train 210, 0,1,1, 3,4
	trains.push new Train 300, 1,0,1, 4,0

draw = ->
	bg 1
	sc 0
	sw 4
	fill 0
	circle X,Y,R+10

	y = 270
	fc 1
	sc()
	sw 0
	text 'speed', 450,y
	text 'sec',   650,y
	text 'next',  700,y

	station.draw() for station in stations
	train.draw i for train,i in trains