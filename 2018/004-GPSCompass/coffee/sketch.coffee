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
		timestamp : position.timestamp

	track.push p1

	heading_12 = calcHeading p1,p2

	texts[0] = precisionRound p1.lat,6
	texts[1] = precisionRound p1.lng,6
	texts[8] = "#{Math.round heading_12}°"
	#texts[3] = 'nospeed' #p1.spd
	#texts[4] = p1.timestamp
	texts[10] = "#{Math.round distance_on_geoid p1,p2} m"
	texts[2] = "#{track.length} punkter"  

	if track.length >= 2 
		p0 = track[track.length-2]
		texts[3] = "Delta t: #{p1.timestamp - p0.timestamp} ms"
		texts[4] = "Distance: #{Math.round distance_on_geoid p0,p1} m"
		texts[9] = "Heading: #{Math.round calcHeading p0,p1}°"
		texts[5] = "speed"

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
	textSize 50
	for t,i in texts
		x = (i%2) * windowWidth/2
		y = d*Math.floor(i/2)
		text t,50+x,0.6*d+y
	drawCompass()