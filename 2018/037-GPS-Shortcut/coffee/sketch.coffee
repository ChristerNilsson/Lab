position = {x:0,y:0} # home

R = 80

buttons = []
hist = []
track = []

a = 7
b = 9
count = 0
start = null
stopp = null
wgs84 = null
dx = null
dy = null

class Button
	constructor : (@x,@y,@r,@txt) -> 
	draw : ->
		if @r > dist position.x,position.y,@x,@y then fc 1,1,0,0.5 else fc 1,1,1,0.5 
		if stopp? then fc 0,1,0
		if @r > 0 then circle @x,@y,@r
		fc 0
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

locationUpdate = (p) ->
	p1 = 
		lat : p.coords.latitude
		lng : p.coords.longitude
		timestamp : p.timestamp # milliseconds since 1970
	position = wgs84ToXY p1.lat,p1.lng
	track.push position
	if track.length > 10 then track.shift()

locationUpdateFail = (error) ->

wgs84ToXY = (lat,lon) ->
	x = int map lon, 18.132735-dx, 18.132735+dx, 0,800
	y = int map lat, 59.265205+dy, 59.265205-dy, 0,800
	{x,y}

setup = ->
	createCanvas 800,800

	dx = 0.01/(1137/width)
	dy = 0.01/(2224/height)
	p1 = new LatLon 59.265205+dy,18.132735
	p2 = new LatLon 59.265205-dy,18.132735
	p3 = new LatLon 59.265205,18.132735-dx
	p4 = new LatLon 59.265205,18.132735+dx
	print p3.distanceTo p4
	print p1.distanceTo p2

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	start = millis()

	angleMode DEGREES
	textAlign CENTER,CENTER
	textSize 50
	labels = "+2 *2 /2".split ' '
	for txt,i in labels
		x = width/2 + 200*cos i*360/labels.length-90
		y = height/2 + 200*sin i*360/labels.length-90
		buttons.push new Button x,y,R,txt
	buttons.push new Button width/2,height/2,R,'undo'
	buttons[0].event = -> @spara a+2 
	buttons[1].event = -> @spara a*2
	buttons[2].event = -> if a%2==0 then @spara a//2
	buttons[3].event = ->	
		if hist.length > 0 
			a = hist.pop()
			buttons[4].txt = a
	buttons.push new Button 100,100,-R,a
	buttons.push new Button 500,100,-R,b
	buttons.push new Button 120,height-50,-R,''
	buttons.push new Button width-120,height-50,-R,''

draw = ->
	bg 0.5
	fc()
	circle width/2,height/2,200
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
	text "#{position.x}, #{position.y}",200,200

mousePressed = ->
	if stopp? then return
	for button in buttons
		button.execute()
