position = [59.265205, 18.132735] # home

#OMKRETS = 40075000 # meter
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

class Button
	constructor : (@x,@y,@r,@txt) -> 
	draw : ->
		if @r > dist mouseX,mouseY,@x,@y then fc 1,1,0,0.5 else fc 1,1,1,0.5 
		if stopp? then fc 0,1,0
		if @r > 0 then circle @x,@y,@r
		fc 0
		text @txt,@x,@y
	execute : ->
		if @r > dist mouseX,mouseY,@x,@y
			@event()
			if a==b then stopp = millis()

	spara : (value) ->
		count++
		hist.push a
		a = value
		buttons[4].txt = a

locationUpdate = (p) ->
	#logg.push 'locationUpdate ' + position.timestamp
	#print 'locationUpdate', position
	p1 = 
		lat : p.coords.latitude
		lng : p.coords.longitude
		timestamp : p.timestamp # milliseconds since 1970
	position = wgs84ToXY p1.lat,p1.lng
	track.push position
	if track.length > 10 then track.shift()
	#heading_12 = calcHeading p1,place()
	#lastObservation = millis()


	# texts[0] = prettyDist distance_on_geoid p1,place()
	# texts[1] = "#{Math.round heading_12}°"
	# texts[6] = track.length 
	# if track.length > 1
	# 	speed     = calcSpeed     start, millis(), track[0], _.last(track), place()
	# 	totalTime = calcTotalTime start, millis(), track[0], _.last(track), place()
	# 	#texts[3] = "#{precisionRound 3.6*speed,1} km/h"  
	# 	texts[2] = prettyETA startDate, totalTime

	# 	ts = prettyDate d = new Date p1.timestamp
	# 	lat = precisionRound p1.lat,6
	# 	lng = precisionRound p1.lng,6
	# 	heading = precisionRound heading_12,0
	# 	mark00 = if d.getSeconds() == 0 then '*' else ''
		
	# 	logg.push "#{ts} #{lat} #{lng} #{texts[0]} #{heading} #{texts[3]} #{texts[2]} #{mark00}"

locationUpdateFail = (error) ->
	#logg.push error	

wgs84ToXY = (lat,lon) ->
	dx = 0.01/1.136
	dy = 0.01/2.224
	x = int map lon, 18.132735-dx, 18.132735+dx, 0,1000
	y = int map lat, 59.265205+dy, 59.265205-dy, 0,1000
	[x,y]

setup = ->

	dx = 0.01/1.136
	dy = 0.01/2.224

	p0 = new LatLon 59.265205,    18.132735 # home
	p1 = new LatLon 59.265205+dy, 18.132735-dx
	p2 = new LatLon 59.265205+dy, 18.132735 
	p3 = new LatLon 59.265205+dy, 18.132735+dx 
	p4 = new LatLon 59.265205,    18.132735+dx
	p5 = new LatLon 59.265205-dy, 18.132735+dx 
	p6 = new LatLon 59.265205-dy, 18.132735
	p7 = new LatLon 59.265205-dy, 18.132735-dx
	p8 = new LatLon 59.265205,    18.132735-dx 

	print p1.distanceTo p3
	print p7.distanceTo p5
	print p1.distanceTo p7
	print p3.distanceTo p5

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	start = millis()
	createCanvas 1000,1000
	# wgs84 = new WGS84 59.265205, 18.132735, width, height
	# assert [300,300], wgs84.w2c 59.265205, 18.132735
	# assert [300,301], wgs84.w2c 0.0001+59.265205, 0.0001+18.132735

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
	for p,i in track
		[x,y] = p
		fc (9-i)*0.1,0,0
		circle x,y,3

	text position,200,200


mousePressed = ->
	if stopp? then return
	for button in buttons
		button.execute()


