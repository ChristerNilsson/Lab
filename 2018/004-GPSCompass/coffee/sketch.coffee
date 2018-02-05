bearing = 0
p1 = null

locationUpdate = (position) ->
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp # milliseconds since 1970
		heading : position.coords.heading
		speed : position.coords.speed 

locationUpdateFail = (error) ->

setup = ->
	createCanvas windowWidth,windowHeight
	window.addEventListener "deviceorientation", (event) -> 
		if event.alpha then	bearing = 360 - Math.round event.alpha
	textSize 100
	textAlign CENTER,CENTER

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

draw = ->
	bg 1
	if p1
		if p1.heading then text p1.heading, width*0.5, height*0.1
		if p1.speed then text p1.speed, width*0.5, height*0.2
	text bearing, width*0.5, height*0.50
	if window.orientation
		text window.orientation, width*0.5, height*0.75
	else
		text 'orient unknown', width*0.5, height*0.75
