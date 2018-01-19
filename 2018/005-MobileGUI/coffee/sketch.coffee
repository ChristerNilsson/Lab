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

w = null # width
h = null # height
track = []
bearing = 0
heading_12 = 0
lastObservation = 0
p1 = null
start = null # Starttid. Sätts vid byte av target

texts = ['','','','','','','','','','','','']

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
	else res = color 255,255,0,255 # error 
	res.levels

hideCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'none'		

showCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'block'

locationUpdate = (position) ->
	#print 'locationUpdate', position
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		accuracy : position.coords.accuracy
		timestamp : position.timestamp/1000

	track.push p1

	heading_12 = calcHeading p1,place
	lastObservation = millis()

	#texts[1] = 
	texts[1] = "#{track.length}"  
	texts[6] = "#{Math.round p1.accuracy} m"
	texts[8] = "#{Math.round heading_12}°"
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

GPSCompass_setup = ->
	start = millis()
	#createCanvas windowWidth,windowHeight

	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha

		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard

		texts[0] = "#{precisionRound (millis()-start)/1000,0} s" # sekunder sedan start
		texts[7] = "#{Math.round (millis() - lastObservation)/1000} s"
		texts[9] = "#{Math.round bearing}°"
		delta = calcDelta heading_12-bearing
		texts[11] = "#{Math.round delta}°"

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
		if i not in [2,3,8,9,10,11] then text t,x,2*d+y
	textAlign LEFT
	text place.name,0,d

draw = ->
	bg 0
	drawCompass()
	drawTexts()

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

	c = createCanvas windowWidth,windowHeight-25
	w = width
	h = height	

	c.parent 'myContainer'	
	hideCanvas()

	GPSCompass_setup()

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
		@addRow makeInput 'name','2018-01-15 12:34:56'
		@addRow makeInput 'lat','59.123456'
		@addRow makeInput 'lng','18.123456'
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

