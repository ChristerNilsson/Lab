places = []
places.push {name:'Bagarmossen Sushi',     lat:59.277560, lng:18.132739}
places.push {name:'Bagarmossen T',         lat:59.276264, lng:18.131465}
places.push {name:'Björkhagens Golfklubb', lat:59.284052, lng:18.145925}
places.push {name:'Björkhagen T',          lat:59.291114, lng:18.115521}
places.push {name:'Brotorpsbron',					 lat:59.270067, lng:18.150236}
places.push {name:'Brotorpsstugan'         lat:59.270542, lng:18.148473}
places.push {name:'Kärrtorp T',            lat:59.284505, lng:18.114477}
places.push {name:'Hellasgården',          lat:59.289813, lng:18.160577}
places.push {name:'Hem',                   lat:59.265205, lng:18.132735}
places.push {name:'Parkeringsgran',        lat:59.274916, lng:18.161353}
places.push {name:'Pers badställe',        lat:59.289571, lng:18.170767}
places.push {name:'Skarpnäck T',           lat:59.266432, lng:18.133093}
places.push {name:'Söderbysjön N Bron',    lat:59.285500, lng:18.150542}
places.push {name:'Söderbysjön S Bron',    lat:59.279155, lng:18.149318}
places.push {name:'Ulvsjön, Udden',        lat:59.277103, lng:18.164897}

placeIndex = 0
place = places[placeIndex]

w = null
h = null
track = []
bearing = 0
heading_12 = 0
lastObservation = 0
p1 = null

texts = ['','','','','','','','','','','','']

locationUpdate = (position) ->
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		accuracy : position.coords.accuracy
		timestamp : position.timestamp/1000

	track.push p1

	heading_12 = calcHeading p1,place
	lastObservation = millis()

	texts[0] = precisionRound place.lat,6
	texts[1] = precisionRound place.lng,6
	texts[3] = "#{track.length}"  
	texts[6] = "#{Math.round p1.accuracy} m"
	texts[8] = "#{Math.round heading_12}°"
	#texts[3] = 'nospeed' #p1.spd
	#texts[4] = p1.timestamp
	texts[10] = "#{Math.round distance_on_geoid p1,place} m"

	if track.length >= 2 
		p0 = track[track.length-2]
		dt = p1.timestamp-p0.timestamp
		ds = distance_on_geoid p0,p1
		texts[2] = "#{precisionRound dt,3} s"
		texts[4] = "#{Math.round ds} m"
		texts[5] = "#{precisionRound ds/dt,1} m/s"
		texts[9] = "#{Math.round calcHeading p0,p1}°"

locationUpdateFail = (error) ->
	texts[0] = "n/a"
	texts[1] = "n/a"

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
	enableHighAccuracy: true
	maximumAge: 30000
	timeout: 27000

calcDelta = (delta) ->
	if delta < -180 then delta += 360
	if delta > +180 then delta -= 360
	delta

# Visa avvikelsen med färgton. Vid 90 grader blir det svart
calcColor = (delta) ->
	white = color 255,255,255
	red   = color 255,0,0
	green = color 0,255,0
	if abs(delta) > 90 then res = color 0,0,0
	else if delta < 0 then res = lerpColor white, red, -delta/90
	else res = lerpColor white, green, delta/90
	res.levels

setup = ->
	createCanvas windowWidth,windowHeight
	w = windowWidth
	h = windowHeight	

	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha

		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard

		texts[7] = "#{Math.round (millis() - lastObservation)/1000} s"
		texts[9] = "#{Math.round bearing}°"
		delta = calcDelta heading_12-bearing
		texts[11] = "#{Math.round delta}°"

	assert [255,255,255,255], calcColor 0
	assert [255,0,0,255], calcColor -90
	assert [0,0,0,255], calcColor -180
	assert [0,255,0,255], calcColor 90
	assert [0,0,0,255], calcColor 180

drawHouse = (radius) ->
	fc 1
	sc()
	textAlign CENTER,CENTER

	for i in range 4
		push()
		translate 0,1.3*radius
		rd 180
		text "SWNE"[i],0,0
		pop()
		rd 90	
	push()

	dx = 0.02 * w
	sc 0
	sw 1
	for i in range -3,4
		line i*4*dx,-1.1*radius,i*4*dx,1.1*radius

	sc 1
	sw 5
	fc()
	circle 0,0,1.1*radius

	sc 0
	sw 1
	fc 0.5
	rect -dx,-0.9*radius,2*dx,1.9*radius
	triangle -1.5*dx,-0.9*radius,0,-1.05*radius,1.5*dx,-0.9*radius
	pop()

drawNeedle = (radius) ->
	try
		rd -bearing

		sc 0
		sw 0.025*h
		line 0,-0.95*radius,0,0.95*radius

		sc 1
		sw 0.02*h
		line 0,0,0,0.95*radius
		sc 1,0,0
		line 0,0,0,-0.95*radius

		sw 0.025*h
		sc 0
		point 0,0

drawCompass = ->
	radius = 0.25 * w 
	delta = calcDelta heading_12-bearing
	fill calcColor delta
	sw 5
	sc 1
	push()
	translate 0.5*w,0.7*h
	circle 0,0,1.1*radius
	push()

	rd -heading_12
	drawHouse radius
	pop()
	textSize 0.08*h
	fc 1
	sc()
	textAlign CENTER
	text texts[10],0,-2*radius
	text texts[8],0,-1.6*radius
	drawNeedle radius
	pop()

drawTexts = ->
	fc 0.5
	d = h/12
	sc 0.5
	sw 1
	textSize 0.08*h
	for t,i in texts
		x = i%2 * w
		if i%2==0 then textAlign LEFT else textAlign RIGHT
		y = d*Math.floor i/2
		if i not in [8,9,10,11] then text t,x,2*d+y
	textAlign LEFT
	text placeIndex + ' ' + place.name,0,d

draw = ->
	bg 0
	drawCompass()
	drawTexts()

mousePressed = ->
	if mouseY > h/2 and track.length>0
		p = track[track.length-1]
		places.push 
			name: prettyDate new Date()
			lat: p.lat
			lng: p.lng
		placeIndex = places.length-1

	else if mouseX > w/2 then placeIndex++
	else placeIndex--
	placeIndex %%= places.length
	place = places[placeIndex]
	texts = ['','','','','','','','','','','','']
	texts[0] = precisionRound place.lat,6
	texts[1] = precisionRound place.lng,6
