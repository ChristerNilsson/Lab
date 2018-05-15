released = true

position = {x:0,y:0} # home

# inparametrar
Rmeter = 100 # stora radien i meter
rmeter = 30 # lilla radien meter
RADIUS = null # stora radien i pixlar
radius = null # lilla radien i pixlar
# level
# seed

LAT = 59.265205 # Skarpnäck
LNG = 18.132735

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

class Button
	constructor : (@x,@y,@radius,@txt,@r=0.5,@g=0.5,@b=0.5) -> 
	draw : ->
		if @radius > dist position.x,position.y,@x,@y then fc 1,1,0,0.5 else fc 1,1,1,0.5 
		if stopp? then fc 0,1,0
		sc 0
		if @radius > 0 then circle @x,@y,@radius
		fc @r,@g,@b
		sc()
		text @txt,@x,@y
	execute : ->
		if @radius > dist position.x,position.y,@x,@y
			@event()
			if a==b then stopp = millis()

	spara : (value) ->
		count++
		hist.push a
		a = value
		buttons[3+1].txt = steps - count
		buttons[4+1].txt = a
	setColor : (r,g,b) -> [@r,@g,@b] = [r,g,b]

locationUpdate = (p) ->
	p1 = 
		lat : p.coords.latitude
		lng : p.coords.longitude
		timestamp : p.timestamp # milliseconds since 1970
	position = wgs84ToXY p1
	track.push position
	if track.length > 10 then track.shift()

locationUpdateFail = (error) ->

wgs84ToXY = (p) ->
	x = int map p.lng, LNG-dw/2, LNG+dw/2, 0, width
	y = int map p.lat, LAT+dh/2, LAT-dh/2, 0,height
	timestamp = p.timestamp
	{x,y,timestamp}

setup = ->
	createCanvas 800,800  # windowWidth,windowHeight
	# dx = 0.01/(1136.6/width) # meter per grad Stockholm
	# dy = 0.01/(2223.9/height) # meter per grad Stockholm
	#dh = height/113660 # grader vertikalt Stockholm
	#dw = width/222390 # grader horisontellt Stockholm
	dh = height/389000 # grader vertikalt Stockholm
	dw = width/209500 # grader horisontellt Stockholm
	meterPerPixlar = 2 * (rmeter+Rmeter) / Math.min width,height
	RADIUS = Rmeter / meterPerPixlar
	radius = 0.3 * RADIUS
	print 'RADIUS',RADIUS
	print 'radius',radius
	print 'meterPerPixlar',meterPerPixlar
	print 'dw',dw
	print 'dh',dh

	p0 = {lat: LAT, lng: LNG, timestamp:0}
	p1 = {lat: LAT-dh/2, lng: LNG-dw/2, timestamp:0}
	p2 = {lat: LAT-dh/2, lng: LNG+dw/2, timestamp:0}
	p3 = {lat: LAT+dh/2, lng: LNG-dw/2, timestamp:0}
	p4 = {lat: LAT+dh/2, lng: LNG+dw/2, timestamp:0}

	p5 = {lat: 59.2661136, lng: 18.1326854}

	p6 = {lat: LAT+dh/2, lng: LNG, timestamp:0}
	p7 = {lat: LAT-dh/2, lng: LNG, timestamp:0}
	p9 = {lat: LAT, lng: LNG+dw/2, timestamp:0}

	p10 = {lat: 59.2652257, lng: 18.1344284}

	print wgs84ToXY p0 
	print wgs84ToXY p1 
	print wgs84ToXY p2 
	print wgs84ToXY p3
	print wgs84ToXY p4

	print 'p5',wgs84ToXY p5 
	print 'p6',wgs84ToXY p6 
	print 'p7',wgs84ToXY p7 
	print 'p9',wgs84ToXY p9 
	print 'p10',wgs84ToXY p10 

	ll1 = LatLon p1.lat,p1.lng 
	ll2 = LatLon p2.lat,p2.lng 
	ll3 = LatLon p3.lat,p3.lng 
	ll4 = LatLon p4.lat,p4.lng 
	print ll1.bearingTo ll4
	print ll2.bearingTo ll3

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	start = millis()

	angleMode DEGREES
	textAlign CENTER,CENTER
	textSize 1*radius
	labels = "+2 *2 /2 +3".split ' '
	n = labels.length
	for txt,i in labels
		x = width/2  + RADIUS * cos i*360/n # -90
		y = height/2 + RADIUS * sin i*360/n # -90
		buttons.push new Button x,y,radius,txt
	buttons[0].event = -> @spara a+2
	buttons[1].event = -> @spara a*2
	buttons[2].event = -> if a%2==0 then @spara a//2
	buttons[3].event = -> @spara a+3

	buttons.push new Button width/2,height/2,radius,steps
	buttons[3+1].event = ->
		if hist.length > 0
			a = hist.pop()
			buttons[4+1].txt = a
	buttons.push new Button 100,100,-radius,a
	buttons.push new Button width-100,100,-radius,b
	buttons[4+1].setColor 0,0,0
	buttons[5+1].setColor 0,0,0
	buttons.push new Button 120,height-radius,-radius,'time'
	buttons.push new Button width-120,height-radius,-radius,'count'
	buttons[6+1].setColor 0,0,0
	buttons[7+1].setColor 0,0,0

	for i in range 4
			print 'dist', dist width/2,height/2,buttons[i].x,buttons[i].y

draw = ->
	bg 0.5
	fc()
	circle width/2,height/2,RADIUS
	for button in buttons
		button.draw()
	if stopp?
		buttons[6+1].txt = round(stopp-start)/1000
		buttons[7+1].txt = count
	fc()
	sc 0
	sw 1
	for p,i in track
		circle p.x,p.y,3*(10-i)

	fc 1,0,0
	text "#{position.x}, #{position.y}",0.5*width,0.35*height

mouseReleased = -> # to make Android work
	released = true
	false

mousePressed = ->
	if !released then return # to make Android work
	released = false
	if stopp? then return
	for button in buttons
		button.execute()
