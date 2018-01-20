# https://stackoverflow.com/questions/2010892/storing-objects-in-html5-localstorage
# sex decimaler motsvarar 11 cm resp 5 cm precision i sista siffran.

LINK = "https://christernilsson.github.io/Lab/2018/005-MobileGUI/index.html"

WHITE = null
GREEN = null
BLACK = null
RED   = null

pages = {}
place = null
oldName = null

#normal = 0 # 0 = values 1 = help texts

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
startDate = null

texts = ['dist','bäring','ETA','km/h','','wait','punkter','','tid','destination']

storeData = -> localStorage["GPSCompass"] = JSON.stringify places	
fetchData = ->
	data = localStorage["GPSCompass"]
	if data then places = JSON.parse data 

hideCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'none'		

showCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'block'

################################

setupCompass = ->
	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha
		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard

locationUpdate = (position) ->
	#print 'locationUpdate', position
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp # milliseconds since 1970

	track.push p1

	heading_12 = calcHeading p1,place
	lastObservation = millis()

	texts[0] = prettyDist distance_on_geoid p1,place
	texts[1] = "#{Math.round heading_12}°"
	texts[6] = track.length 
	if track.length > 1
		speed     = calcSpeed     start, millis(), track[0], _.last(track), place
		totalTime = calcTotalTime start, millis(), track[0], _.last(track), place
		texts[3] = "#{precisionRound 3.6*speed,1} km/h"  
		texts[2] = prettyETA startDate, totalTime

locationUpdateFail = (error) ->

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
	enableHighAccuracy: true
	maximumAge: 30000
	timeout: 27000

##########################

#mousePressed = -> normal = 1 - normal

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

	pages.Nav = new Page -> 
		texts[9] = place.name
		start = millis()
		startDate = new Date()
		track = []
		lastObservation = millis()
		showCanvas()

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
			@addRow makeInput 'lat',  precisionRound last.lat,6
			@addRow makeInput 'lng',  precisionRound last.lng,6
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

	# pages.Link = new Page -> 
	# 	@addRow makeDiv 'The Link is now on the Clipboard. Mail it to a friend.'
	# 	@addRow link = makeInput 'link', "" #, true
	# 	link.value += "\n" + encodeURI "#{LINK}?name=#{place.name}&lat=#{place.lat}&lng=#{place.lng}" 
	# 	if track.length > 0
	# 		curr = _.last track
	# 		link.value += "\n" + encodeURI "#{LINK}?name=#{curr.timestamp}&lat=#{curr.lat}&lng=#{curr.lng}"
	# pages.Link.addAction 'Ok', -> 
	# 	link.focus()
	# 	link.select()
	# 	document.execCommand 'copy'
	# 	#link.value = ''
	# 	#link.style.display = 'none'
	# 	pages.Nav.display()

	pages.Link = new Page -> 
		@addRow makeDiv 'The Link is now on the Clipboard. Mail it to a friend.'
		@addRow link = makeTextArea 'link'
		link.value += "\n" + encodeURI "#{LINK}?name=#{place.name}&lat=#{place.lat}&lng=#{place.lng}" 
		if track.length > 0
			curr = _.last track
			link.value += "\n" + encodeURI "#{LINK}?name=#{curr.timestamp}&lat=#{curr.lat}&lng=#{curr.lng}"
			#link.focus()
			#link.select()
	pages.Link.addAction 'Ok', -> 
		link = document.getElementById("link")
		link.focus()
		link.select()
		document.execCommand 'copy'
		#link.value = ''
		#link.style.display = 'none'
		pages.Nav.display()

	# startsida:
	pages.List.display()
