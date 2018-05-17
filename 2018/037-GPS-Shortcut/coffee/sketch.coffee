# file:///C:/Lab/2018/037-GPS-Shortcut/index.html?radius=50&level=3&seed=0.5&nr=1

released = true
system = null

position = {x:0,y:0} 

rotation = 0 # degrees
rotation2 = 0 # degrees

SCALE = null
killed = false 

# inparametrar
Rmeter = 50 # stora radien i meter
RADIUS = null # stora radien i pixlar
radius = null # lilla radien i pixlar
level = null
seed = null
nr = null

TRACKED = 5

#LAT = 59.265205 # Skarpnäck
#LON = 18.132735

buttons = []
hist = []
track = []

a = 8
b = 9
count = 0
steps = 3
start = null
stopp = null
dw = null
dh = null

class System
	constructor : (@lat,@lon,@w,@h) ->
		p0 = LatLon @lat,@lon
		p1 = p0.destinationPoint @h/2, 0
		@lat2 = p1.lat
		p2 = p0.destinationPoint @w/2, 90
		@lon2 = p2.lon
		p3 = p0.destinationPoint @h/2, 180
		@lat1 = p3.lat
		p4 = p0.destinationPoint @w/2, 270
		@lon1 = p4.lon
	toXY : (lat,lon) ->
		x = round map lon, @lon1, @lon2, -@w/2, @w/2
		y = round map lat, @lat2, @lat1, -@h/2, @h/2 # turned
		{x,y}
	toWGS84 : (x,y) ->
		lon = map x, -@w/2, @w/2, @lon1, @lon2
		lat = map y, -@h/2, @h/2, @lat1, @lat2
		{lat,lon}

class Button
	constructor : (@x,@y,@radius,@txt,@r=0,@g=0,@b=0) ->
		@rotates = false 

	draw : ->
		push()
		translate @x,@y
		if @inCircle()
			if @inRedHalf() then killed = true
			fc 0.25 
		else 
			fc 0.75
		if stopp? then fc 0,1,0
		sc()
		if @radius > 0
			if @rotates
				rotate rotation2
				d = 2 * @radius
				fc 0.75
				arc 0,0,d,d,0,180
				fc 1,0,0
				arc 0,0,d,d,180,0
			else
				circle 0,0,@radius
		if a==b then fc 0,1,0 else fc @r,@g,@b
		text @txt,0,0
		pop()

	execute : ->
		if @inCircle()
			@event()
			if a==b then stopp = millis()

	setColor : (r,g,b) -> [@r,@g,@b] = [r,g,b]

	inCircle : ->
		x = width/2
		y = height/2
		x += RADIUS * cos rotation
		y += RADIUS * sin rotation
		@radius > dist position.x,position.y,x,y

	inRedHalf : ->
		x = width/2
		y = height/2
		x += RADIUS * cos rotation
		y += RADIUS * sin rotation
		vinkel = atan2 position.y-y, position.x-x
		rotation2 < vinkel < rotation2+180 and @radius > dist position.x,position.y,x,y

spara = (value) ->
	count++
	hist.push a
	a = value
	buttons[3+0].txt = steps - count
	buttons[4+0].txt = a

locationUpdate = (p) ->
	lat = p.coords.latitude
	lon = p.coords.longitude
	if system == null
		system = new System lat,lon,width,height
	else
		position = system.toXY lat,lon
		track.push position
		if track.length > TRACKED then track.shift()

locationUpdateFail = (error) ->

setup = ->
	createCanvas windowWidth,windowHeight

	# args = getParameters()
	# nr = args.nr
	## lat = parseFloat args.lat
	## lon = parseFloat args.lon
	# RADIUS = parseInt args.radius 
	# level = parseInt args.level
	# seed = parseFloat args.seed

	nr = '1'
	#lat = 59.265205 
	#lon = 18.132735
	RADIUS = 25
	level = 3
	seed = 0.5

	d = new Date()
	seed += 31 * d.getMonth() + d.getDate()

	createProblem level,seed

#	system = new System lat,lon,width,height

	SCALE = min(width,height)/RADIUS/3
	print SCALE
	radius = 0.3 * RADIUS

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	start = millis()

	angleMode DEGREES
	textAlign CENTER,CENTER
	textSize 1*radius
	labels = "+2 *2 /2".split ' '
	n = labels.length

	for txt,i in labels
		x = RADIUS * cos i*360/n
		y = RADIUS * sin i*360/n
		button = new Button x,y,radius,txt
		button.rotates = true
		buttons.push button
	buttons[0].event = -> spara a+2
	buttons[1].event = -> spara a*2
	buttons[2].event = -> if a%2==0 then spara a//2
	#buttons[3].event = -> spara a+3

	buttons.push new Button 0,0,radius,steps
	buttons[3+0].event = ->
		if hist.length > 0
			a = hist.pop()
			buttons[4+1].txt = a

	ws = 0.4*width/SCALE
	hs = 0.4*height/SCALE
	rs = radius/SCALE

	buttons.push new Button -ws,-hs,-rs,a
	buttons.push new Button ws,-hs,-rs,b
	buttons[4+0].setColor 1,0,0
	buttons[5+0].setColor 0,1,0

	buttons.push new Button -ws,hs,-rs,'#'+nr
	buttons.push new Button 0,hs,-rs,'0' # sekunder
	buttons.push new Button ws,hs,-rs,'0' # count

draw = ->
	if killed 
		bg 1,0,0
		return 
	translate width/2,height/2
	scale SCALE
	bg 0.5
	fc()
	sc 0
	circle 0,0,RADIUS
	if stopp?
		buttons[7+0].txt = round(stopp-start)/1000
	else
		buttons[7+0].txt = round (millis()-start)/1000
	buttons[8+0].txt = count

	rotate rotation
	for i in range 0,3
		buttons[i].draw()

	rotate -rotation
	for i in range 3,9
		buttons[i].draw()

	fc()
	sc 1,1,0
	sw 1/SCALE
	for p,i in track
		circle p.x, p.y, 5*(track.length-i)/SCALE

	rotation = (rotation + 0.01) % 360
	rotation2 = (rotation2 + 0.05) % 360

createProblem = (level,seed) ->
	n = int Math.pow 2, 4+level/3 # nodes
	a = myrandom 1,n/2
	lst = [a]
	tree = [a]
	lst2 = []
	save = (item) ->
		if item <= n and item not in tree
			lst2.push item
			tree.push item
	for j in range level
		lst2 = []
		for item in lst
			save item + 2 
			save item * 2
			if item%2 == 0 then save item / 2
		lst = lst2
	i = myrandom 0,lst.length
	b = lst[i]

myrandom = (a,b) ->
  x = 10000 * Math.sin seed
  x = x - Math.floor(x)
  int a+x*(b-a)

mouseReleased = -> # to make Android work
	released = true
	false

mousePressed = ->
	if !released then return # to make Android work
	released = false
	if stopp? then return
	for button in buttons
		button.execute()
