# https://stackoverflow.com/questions/2010892/storing-objects-in-html5-localstorage
LINK = "https://christernilsson.github.io/Lab/2018/004-GPSCompass/index.html"

WHITE = null
GREEN = null
BLACK = null
RED   = null

pages = {}
place = null
oldName = null

places = []
places.push {name:'Bagarmossen Sushi',     lat:59.277560, lng:18.132739}
places.push {name:'Bagarmossen T',         lat:59.276264, lng:18.131465}
places.push {name:'Björkhagens Golfklubb', lat:59.284052, lng:18.145925}
places.push {name:'Björkhagen T',          lat:59.291114, lng:18.115521}
places.push {name:'Brotorpsbron',					 lat:59.270067, lng:18.150236}
places.push {name:'Brotorpsstugan',        lat:59.270542, lng:18.148473}
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
start = null # Starttid. Sätts vid byte av target

texts = ['dist','bäring','pkter','speed','','wait','18:35','','tid']

storeData = -> localStorage["GPSCompass"] = JSON.stringify places	
fetchData = ->
	data = localStorage["GPSCompass"]
	if data then places = JSON.parse data 
	#print 'fetchData',data

# Visa vinkelavvikelse med färgton. 
# -180 = black
#  -90 = red
#    0 = white
#   90 = green 
#  180 = black
calcColor = (delta) ->
	# -180 <= delta <= 180
	if      -180 <= delta <  -90 then res = lerpColor BLACK, RED,  (delta+180)/90
	else if  -90 <= delta <    0 then res = lerpColor RED,   WHITE,(delta+90)/90
	else if    0 <= delta <   90 then res = lerpColor WHITE, GREEN,(delta+0)/90
	else if   90 <= delta <= 180 then res = lerpColor GREEN, BLACK,(delta-90)/90
	else res = color 255,255,0,255 # yellow, error 
	res.levels

hideCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'none'		

showCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'block'

draw = ->
	bg 0
	texts[5] = "#{Math.round (millis() - lastObservation)/1000} s"
	texts[8] = "#{precisionRound (millis()-start)/1000,0} s" # sekunder sedan start
	drawCompass()
	drawTexts()

locationUpdate = (position) ->
	print 'locationUpdate', position
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp # milliseconds since 1970

	track.push p1

	heading_12 = calcHeading p1,place
	lastObservation = millis()

	texts[0] = "#{Math.round distance_on_geoid p1,place} m"
	texts[1] = "#{Math.round heading_12}°"
	texts[2] = "#{track.length}"  
	texts[3] = "speed"  

locationUpdateFail = (error) ->

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
	enableHighAccuracy: true
	maximumAge: 30000
	timeout: 27000

setupCompass = ->
	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha
		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard
		#texts[1] = "#{Math.round bearing}°"

drawHouse = (radius) ->
	push()

	# nio linjer
	dx = 0.02 * w
	sc 0
	sw 1
	for i in range -4,5
		line i*4*dx,-1.1*radius,i*4*dx,1.1*radius

	# vit omkrets
	sc 1
	sw 5
	fc()
	circle 0,0,1.1*radius

	# pilen
	sc 0
	sw 0.05*h
	line 0,-1.01*radius,0,1.01*radius

	# fyra väderstreck
	sc()
	textAlign CENTER,CENTER
	textSize 0.06*h
	for i in range 4
		push()
		translate 0,0.96*radius
		rd 180
		if i==0 then fc 1 
		else if i==2 then fc 1,0,0 
		else fc 0
		text "SWNE"[i],0,0
		pop()
		rd 90	

	pop()

drawNeedle = (radius) ->
	try
		rd -bearing

		sc 0
		sw 0.035*h
		line 0,-0.98*radius,0,0.98*radius

		sc 1
		sw 0.030*h
		line 0,0,0,0.98*radius
		sc 1,0,0
		line 0,0,0,-0.98*radius

		sw 0.035*h
		sc 0
		point 0,0

drawCompass = ->
	radius = 0.33 * w 
	delta = calcDelta heading_12-bearing
	fill calcColor delta
	sw 5
	sc 1
	push()
	translate 0.5*w,0.5*h
	circle 0,0,1.1*radius
	push()

	rd -heading_12
	drawHouse radius
	pop()
	drawNeedle radius
	pop()

drawTexts = ->
	fc 0.5
	d = h/12
	sc 0.5
	sw 1
	n = 3 # columns
	textSize 0.08*h
	for t,i in texts
		if i%n==0 then textAlign LEFT 
		if i%n==1 then textAlign CENTER 
		if i%n==2 then textAlign RIGHT
		x = i%n * w/2
		y = d*Math.floor i/n
		text t,x,d+y
	textAlign LEFT
	text place.name,0,11.7*d

setup = ->

	WHITE = color 255,255,255
	GREEN = color 0,255,0
	BLACK = color 0,0,0
	RED   = color 255,0,0

	test()

	fetchData()

	parameters = getParameters()
	if _.size(parameters) == 3 
		console.log parameters
		places.push parameters
		storeData()

	start = millis()

	c = createCanvas windowWidth,windowHeight*0.90 # 4s
	w = width
	h = height	

	c.parent 'myContainer'	
	hideCanvas()

	setupCompass()

	pages.List = new Page ->
		for p,i in places
			do (i) =>
				b = makeButton p.name, 1, => 
					place = places[i]
					pages.Nav.display()
				b.style.textAlign = 'left' 
				@addRow b		
	pages.List.addAction 'Add', -> pages.Add.display()

	pages.Nav = new Page -> showCanvas()
	pages.Nav.addAction 'List', -> pages.List.display()
	pages.Nav.addAction 'Map', -> window.open "http://maps.google.com/maps?q=#{place.lat},#{place.lng}"
	pages.Nav.addAction 'Edit', -> pages.Edit.display()
	pages.Nav.addAction 'Del', -> pages.Del.display()
	pages.Nav.addAction 'Link', -> pages.Link.display()

	pages.Edit = new Page ->
		oldName = place.name
		@addRow makeInput 'name',place.name
		@addRow makeInput 'lat',place.lat
		@addRow makeInput 'lng',place.lng
		document.getElementById("name").focus()
		document.getElementById("name").select()
	pages.Edit.addAction 'Update', -> 
		name = getField "name"
		lat = parseFloat getField "lat"
		lng = parseFloat getField "lng"
		if isNumeric(lat) and isNumeric(lng)
			if oldName == name # finns namnet redan?
				for p in places
					if oldName == p.name
						p.lat = lat
						p.lng = lng
			else
				places = places.filter (e) => e.name != oldName
				places.push {name:name,lat:lat,lng:lng}
				places.sort (a,b) -> if a.name > b.name then 1 else -1
			storeData()
			pages.List.display()
	pages.Edit.addAction 'Cancel', -> pages.List.display()

	pages.Add = new Page ->
		if track.length > 0
			last = _.last track
			print last 
			@addRow makeInput 'name', prettyDate new Date last.timestamp
			@addRow makeInput 'lat',  last.lat
			@addRow makeInput 'lng',  last.lng
		else
			@addRow makeInput 'name', 'Missing'
			@addRow makeInput 'lat',  0
			@addRow makeInput 'lng',  0
		document.getElementById("name").focus()
		document.getElementById("name").select()
	pages.Add.addAction	'Save', -> 
		name = getField "name"
		lat = parseFloat getField "lat"
		lng = parseFloat getField "lng"
		if isNumeric(lat) and isNumeric(lng)
			places.push {name:name, lat:lat, lng:lng}
			places.sort (a,b) -> if a.name > b.name then 1 else -1
			storeData()
			pages.List.display()
	pages.Add.addAction 'Cancel', -> pages.List.display()

	pages.Del = new Page -> 
		@addRow makeInput 'name',place.name,true
		@addRow makeInput 'lat',place.lat,true
		@addRow makeInput 'lng',place.lng,true
	pages.Del.addAction 'Delete', -> 
		places = places.filter (e) => e.name != place.name
		storeData()
		pages.List.display()
	pages.Del.addAction 'Cancel', -> pages.Nav.display()

	pages.Link = new Page -> 
		@addRow makeInput 'link', encodeURI "#{LINK}?name=#{place.name}&lat=#{place.lat}&lng=#{place.lng}",true
		@addRow makeDiv 'The Link is now on the Clipboard. Mail it to a friend.'
		document.getElementById("link").focus()
		document.getElementById("link").select()
		document.execCommand 'copy'
	pages.Link.addAction 'Ok', -> pages.Nav.display()

	# startsida:
	pages.List.display()

