#hng: null # NESW = [0,90,180,270]
#spd: null # m/s

p2 = # Ulvsjön
	lat: 59.277103
	lng: 18.164897
	timestamp: 0

track = []
bearing = 0
heading_12 = 0
lastObservation = 0

texts = ['','','','','','','','','','','','']

locationUpdate = (position) ->
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		accuracy : position.coords.accuracy
		timestamp : position.timestamp/1000

	track.push p1

	heading_12 = calcHeading p1,p2
	lastObservation = millis()

	texts[0] = precisionRound p1.lat,6
	texts[1] = precisionRound p1.lng,6
	texts[3] = "#{track.length}"  
	texts[6] = "#{Math.round p1.accuracy} m"
	texts[8] = "#{Math.round heading_12}°"
	#texts[3] = 'nospeed' #p1.spd
	#texts[4] = p1.timestamp
	texts[10] = "#{Math.round distance_on_geoid p1,p2} m"

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

window.addEventListener "deviceorientation", (event) ->
	bearing = event.alpha

	if typeof event.webkitCompassHeading != "undefined"
		bearing = event.webkitCompassHeading # iOS non-standard

	texts[7] = "#{Math.round (millis() - lastObservation)/1000} s"
	texts[9] = "#{Math.round bearing}°"
	texts[11] = "#{Math.round bearing - heading_12}°"

setFillColor = (delta) ->
	if delta<-180 then delta += 180
	if delta>180 then delta -= 180
	if delta < 0 
		r = map delta,0,-180,1,0
		fc 1,r,r
	else
		g = map delta,0,180,1,0
		fc g,1,g

setup = ->
	createCanvas windowWidth,windowHeight

drawCompass = ->
	w = windowWidth
	h = windowHeight
	radius = 0.8 * w / 2
	setFillColor heading_12 - bearing
	sw 5
	sc 1
	circle w/2,h/2,radius
	push()
	translate w/2,h/2
	sc 1
	line 0,0,0,-radius
	try
		rd heading_12 - bearing
		sc 0 
		line 0,0,0,-radius
	pop()

draw = ->
	bg 0
	drawCompass()
	fc 0.5
	d = windowHeight/6
	sc 0.5
	sw 1
	textSize 0.08*windowHeight
	for t,i in texts
		x = i%2 * windowWidth
		if i%2==0 then textAlign LEFT else textAlign RIGHT
		y = d*Math.floor i/2
		text t,x,0.6*d+y
