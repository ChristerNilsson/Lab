#hng: null # NESW = [0,90,180,270]
#spd: null # m/s

p2 = # Ulvsjön
	lat: 59.277103
	lng: 18.164897
	timestamp: 0

track = []
bearing = 0
heading_12 = 0

texts = ['','','','','','','','','','','','']

locationUpdate = (position) ->
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp/1000

	track.push p1

	heading_12 = calcHeading p1,p2

	texts[0] = precisionRound p1.lat,6
	texts[2] = precisionRound p1.lng,6
	texts[8] = "#{Math.round heading_12}°"
	#texts[3] = 'nospeed' #p1.spd
	#texts[4] = p1.timestamp
	texts[10] = "#{Math.round distance_on_geoid p1,p2} m"
	texts[3] = "#{track.length}"  

	if track.length >= 2 
		p0 = track[track.length-2]
		dt = p1.timestamp-p0.timestamp
		ds = distance_on_geoid p0,p1
		texts[1] = "#{precisionRound dt,3} s"
		texts[4] = "#{Math.round ds} m"
		texts[9] = "#{Math.round calcHeading p0,p1}°"
		texts[5] = "#{precisionRound ds/dt,1} m/s"

locationUpdateFail = (error) ->
	texts[0] = "n/a"
	texts[1] = "n/a"

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
	enableHighAccuracy: false
	maximumAge: 30000
	timeout: 27000

window.addEventListener "deviceorientation", (event) ->
	bearing = event.alpha

	if typeof event.webkitCompassHeading != "undefined"
		bearing = event.webkitCompassHeading # iOS non-standard

	texts[9] = "#{Math.round bearing}°"
	texts[11] = "#{Math.round bearing - heading_12}°"

setup = ->
	createCanvas windowWidth,windowHeight

drawCompass = ->
	w = windowWidth
	h = windowHeight
	fc()
	sw 5
	circle w/2,h/2,0.9*w/2
	translate w/2,h/2
	sc 1
	line 0,0,0,-0.9*w/2
	try
		rd heading_12 - bearing
		sc 0 
		line 0,0,0,-0.9*w/2

draw = ->
	bg 0.5
	fc 0.75
	d = windowHeight/6
	textSize 75
	for t,i in texts
		x = (i%2) * windowWidth
		if i%2==0 then textAlign LEFT else textAlign RIGHT
		y = d*Math.floor(i/2)
		text t,x,0.6*d+y
	drawCompass()