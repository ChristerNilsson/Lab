released = true
system = null

position = {x:0,y:0} # home

SCALE = 3

# inparametrar
Rmeter = 100 # stora radien i meter
rmeter = 30 # lilla radien meter
RADIUS = null # stora radien i pixlar
radius = null # lilla radien i pixlar
# level
# seed

LAT = 59.265205 # Skarpnäck
LON = 18.132735

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
		#print 'System',@lat1,@lat2,@lon1,@lon2
	toXY : (lat,lon) ->
		x = round map lon, @lon1, @lon2, -@w/2, @w/2
		y = round map lat, @lat1, @lat2, -@h/2, @h/2
		{x,y}
	toWGS84 : (x,y) ->
		lon = map x, -@w/2, @w/2, @lon1, @lon2
		lat = map y, -@h/2, @h/2, @lat1, @lat2
		{lat,lon}

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
	lat = p.coords.latitude
	lon = p.coords.longitude
	#timestamp : p.timestamp # milliseconds since 1970
	position = system.toXY lat,lon
	track.push position
	if track.length > 10 then track.shift()

locationUpdateFail = (error) ->

setup = ->
	createCanvas 800,800  # windowWidth,windowHeight
	system = new System LAT,LON,width,height
	assert {x: 0, y: 0}, system.toXY LAT,LON
	#assert {lat: 59.26160771357633, lon: 18.125696195929095}, system.toWGS84 0,0

	# dx = 0.01/(1136.6/width) # meter per grad Stockholm
	# dy = 0.01/(2223.9/height) # meter per grad Stockholm
	#dh = height/113660 # grader vertikalt Stockholm
	#dw = width/222390 # grader horisontellt Stockholm
	#dh = height/389000 # grader vertikalt Stockholm
	#dw = width/209500 # grader horisontellt Stockholm
	#meterPerPixlar = 2 * (rmeter+Rmeter) / Math.min width,height
	RADIUS = Rmeter #/ meterPerPixlar
	radius = 0.3 * RADIUS
	#print 'RADIUS',RADIUS
	#print 'radius',radius
	#print 'meterPerPixlar',meterPerPixlar
#	print 'dw',dw
#	print 'dh',dh

	# print 'xy',XY_WGS84 400,46
	# print 'xy',XY_WGS84 754,400

	# p0 = {lat: LAT, lng: LNG, timestamp:0}
	# p1 = {lat: LAT-dh/2, lng: LNG-dw/2, timestamp:0}
	# p2 = {lat: LAT-dh/2, lng: LNG+dw/2, timestamp:0}
	# p3 = {lat: LAT+dh/2, lng: LNG-dw/2, timestamp:0}
	# p4 = {lat: LAT+dh/2, lng: LNG+dw/2, timestamp:0}

	# p5 = {lat: 59.266115, lng: 18.132735}

	# p6 = {lat: LAT+dh/2, lng: LNG, timestamp:0}
	# p7 = {lat: LAT-dh/2, lng: LNG, timestamp:0}
	# p9 = {lat: LAT, lng: LNG+dw/2, timestamp:0}

	# p10 = {lat: 59.265205, lng: 18.1344247}

	# print WGS84_XY p0 
	# print WGS84_XY p1 
	# print WGS84_XY p2 
	# print WGS84_XY p3
	# print WGS84_XY p4

	# print 'p5',WGS84_XY p5 
	# print 'p6',WGS84_XY p6 
	# print 'p7',WGS84_XY p7 
	# print 'p9',WGS84_XY p9 
	# print 'p10',WGS84_XY p10 

	# ll1 = LatLon p1.lat,p1.lng 
	# ll2 = LatLon p2.lat,p2.lng 
	# ll3 = LatLon p3.lat,p3.lng 
	# ll4 = LatLon p4.lat,p4.lng 
	# print ll1.bearingTo ll4
	# print ll2.bearingTo ll3

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
		x = RADIUS * cos i*360/n 
		y = RADIUS * sin i*360/n 
		buttons.push new Button x,y,radius,txt
	buttons[0].event = -> @spara a+2
	buttons[1].event = -> @spara a*2
	buttons[2].event = -> if a%2==0 then @spara a//2
	buttons[3].event = -> @spara a+3

	buttons.push new Button 0,0,radius,steps
	buttons[3+1].event = ->
		if hist.length > 0
			a = hist.pop()
			buttons[4+1].txt = a
	ws = 0.4*width/SCALE
	hs = 0.4*height/SCALE		
	rs = radius/SCALE
	buttons.push new Button -ws,-hs,-rs,a
	buttons.push new Button ws,-hs,-rs,b
	buttons[4+1].setColor 0,0,0
	buttons[5+1].setColor 0,0,0
	buttons.push new Button -ws,hs,-rs,'time'
	buttons.push new Button ws,hs,-rs,'count'
	buttons[6+1].setColor 0,0,0
	buttons[7+1].setColor 0,0,0

	#for i in range 4
	#		print 'dist', dist width/2,height/2,buttons[i].x,buttons[i].y

draw = ->
	translate width/2,height/2
	scale SCALE
	bg 0.5
	fc()
	circle 0,0,RADIUS
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
	text "#{position.x}, #{position.y}",0,-0.5*RADIUS

mouseReleased = -> # to make Android work
	released = true
	false

mousePressed = ->
	if !released then return # to make Android work
	released = false
	if stopp? then return
	for button in buttons
		button.execute()
