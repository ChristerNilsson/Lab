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

a = 7
b = 9
count = 0
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
		if @r > dist position.x,position.y,@x,@y
			@event()
			if a==b then stopp = millis()

	spara : (value) ->
		count++
		hist.push a
		a = value
		buttons[4].txt = a
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
	y = int map p.lat, LAT+dh/2, LAT-dh/2, 0, height
	timestamp = p.timestamp
	{x,y,timestamp}

setup = ->
	createCanvas windowWidth,windowHeight
	# dx = 0.01/(1136.6/width) # meter per grad Stockholm
	# dy = 0.01/(2223.9/height) # meter per grad Stockholm
	dh = height/113660 # grader vertikalt Stockholm
	dw = width/222390 # grader horisontellt Stockholm
	meterPerPixlar = 2 * (rmeter+Rmeter) / Math.min width,height 
	RADIUS = Rmeter / meterPerPixlar  
	radius = 0.2 * RADIUS 
	print RADIUS,radius

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	start = millis()

	angleMode DEGREES
	textAlign CENTER,CENTER
	textSize 1.3*radius
	labels = "+2 *2 /2".split ' '
	n = labels.length
	for txt,i in labels
		x = width/2  + RADIUS * cos i*360/n # -90
		y = height/2 + RADIUS * sin i*360/n # -90
		buttons.push new Button x,y,radius,txt
	buttons.push new Button width/2,height/2,radius,'13'
	buttons[0].event = -> @spara a+2 
	buttons[1].event = -> @spara a*2
	buttons[2].event = -> if a%2==0 then @spara a//2
	buttons[3].event = ->	
		if hist.length > 0 
			a = hist.pop()
			buttons[4].txt = a
	buttons.push new Button 100,100,-radius,a
	buttons.push new Button width-100,100,-radius,b
	buttons[4].setColor 0,0,0
	buttons[5].setColor 0,0,0
	buttons.push new Button 120,height-radius,-radius,'time'
	buttons.push new Button width-120,height-radius,-radius,'count'
	buttons[6].setColor 0,0,0
	buttons[7].setColor 0,0,0

draw = ->
	bg 0.5
	fc()
	circle width/2,height/2,RADIUS
	for button in buttons
		button.draw()
	if stopp? 
		buttons[6].txt = round(stopp-start)/1000
		buttons[7].txt = count
	fc()
	sc 0
	sw 1
	for p,i in track
		circle p.x,p.y,1+1*(10-i)

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
