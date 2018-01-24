# https://stackoverflow.com/questions/2010892/storing-objects-in-html5-localstorage
# sex decimaler motsvarar 11 cm resp 5 cm precision i sista siffran.

#LINK = "https://christernilsson.github.io/Lab/2018/005-MobileGUI/index.html"
DECLINATION = 0 # degrees in Stockholm 2018
LINK = "file:///C:/Lab/2018/005-MobileGUI/index.html"

WHITE = null
GREEN = null
BLACK = null
RED   = null

pages = {}
logg = []

places = 
	'Bagarmossen Sushi'      : {lat:59.277560, lng:18.132739}
	'Bagarmossen T'          : {lat:59.276264, lng:18.131465}
	'Björkhagens Golfklubb'  : {lat:59.284052, lng:18.145925}
	'Björkhagen T'           : {lat:59.291114, lng:18.115521}
	'Brotorpsbron'           : {lat:59.270067, lng:18.150236}
	'Brotorpsstugan'         : {lat:59.270542, lng:18.148473}
	'Kärrtorp T'             : {lat:59.284505, lng:18.114477}
	'Hellasgården'           : {lat:59.289813, lng:18.160577}
	'Hem'                    : {lat:59.265205, lng:18.132735}
	'Parkeringsgran'         : {lat:59.274916, lng:18.161353}
	'Pers badställe'         : {lat:59.289571, lng:18.170767}
	'Skarpnäck T'            : {lat:59.266432, lng:18.133093}
	'Söderbysjön N Bron'     : {lat:59.285500, lng:18.150542}
	'Söderbysjön S Bron'     : {lat:59.279155, lng:18.149318}
	'Ulvsjön, Udden'         : {lat:59.277103, lng:18.164897}

placeIndex = 'Bagarmossen Sushi'
place = -> places[placeIndex]

w = null 
h = null 
track = []
bearing = 0
heading_12 = 0
lastObservation = 0
p1 = null
start = null # Starttid. Sätts vid byte av target till millis()
startDate = null # . Sätts vid byte av target till new Date()

texts = ['dist','bäring','ETA','km/h','','wait','punkter','','tid','destination']

storeData = -> 
	#print JSON.stringify places
	localStorage["GPSCompass"] = JSON.stringify places	

fetchData = ->
	data = localStorage["GPSCompass"]
	print data
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
		if typeof event.webkitCompassHeading != "undefined"
			bearing = DECLINATION - event.webkitCompassHeading # iOS 
		else
			bearing = DECLINATION event.alpha # android: 
		texts[1] = precisionRound bearing, 0

locationUpdate = (position) ->
	logg.push 'locationUpdate ' + position.timestamp
	#print 'locationUpdate', position
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp # milliseconds since 1970

	track.push p1

	heading_12 = calcHeading p1,place()
	lastObservation = millis()

	texts[0] = prettyDist distance_on_geoid p1,place()
	#texts[1] = "#{Math.round heading_12}°"
	texts[6] = track.length 
	if track.length > 1
		speed     = calcSpeed     start, millis(), track[0], _.last(track), place()
		totalTime = calcTotalTime start, millis(), track[0], _.last(track), place()
		texts[3] = "#{precisionRound 3.6*speed,1} km/h"  
		texts[2] = prettyETA startDate, totalTime

		ts = prettyDate d = new Date p1.timestamp
		lat = precisionRound p1.lat,6
		lng = precisionRound p1.lng,6
		heading = precisionRound heading_12,0
		mark00 = if d.getSeconds() == 0 then '*' else ''
		
		logg.push "#{ts} #{lat} #{lng} #{texts[0]} #{heading} #{texts[3]} #{texts[2]} #{mark00}"

locationUpdateFail = (error) ->
	logg.push error

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
	enableHighAccuracy: true
	maximumAge: 30000
	timeout: 27000

##########################

draw = ->
	bg 0
	dt = Math.round (millis() - lastObservation)/1000
	texts[8] = if dt>=2 then "#{dt} s" else ""
	texts[5] = "#{precisionRound (millis()-start)/1000,0} s" # sekunder sedan start
	# if window.orientation in [-90,90]  
	# 	w = width
	# 	h = height	
	# 	drawCompassL w,h
	# 	drawTextsL w,h
	# else
	w = width
	h = height	
	drawCompassP w,h
	drawTextsP w,h

# doOnOrientationChange = ->
# window.addEventListener('orientationchange', doOnOrientationChange);
# Initial execution if needed
# doOnOrientationChange();

setup = ->

	WHITE = color 255,255,255
	GREEN = color 0,255,0
	BLACK = color 0,0,0
	RED   = color 255,0,0

	test()

	# storeData()
	fetchData()

	parameters = getParameters()
	if _.size(parameters) == 3 
		key = decodeURI parameters.name
		places[key] = {lat: parameters.lat, lng: parameters.lng}
		storeData()

	start = millis()

	c = createCanvas windowWidth,windowHeight *0.90 # 4s
	w = width
	h = height	

	c.parent 'myContainer'	
	hideCanvas()

	setupCompass()

	pages.List = new Page ->
		keys = _.keys places 
		for key in keys.sort()
			do (key) =>
				@addRow b = makeButton key, 1, => 
					placeIndex = key
					pages.Nav.display()
				b.style.textAlign = 'left' 
	pages.List.addAction '+abs', -> pages.PlusAbs.display()
	pages.List.addAction 'Links', -> pages.Links.display()

	pages.Nav = new Page -> 
		texts[9] = placeIndex
		start = millis()
		startDate = new Date()
		track = []
		logg = []
		lastObservation = millis()
		showCanvas()
	pages.Nav.addAction 'List', -> pages.List.display()
	#pages.Nav.addAction 'Map', -> window.open "http://maps.google.com/maps?q=#{place().lat},#{place().lng}"
	pages.Nav.addAction 'Map', -> window.location.href = "http://maps.google.com/maps?q=#{place().lat},#{place().lng}"
	pages.Nav.addAction 'Edit', -> pages.Edit.display()
	pages.Nav.addAction 'Del', -> pages.Del.display()
	pages.Nav.addAction 'Link', -> pages.Link.display()
	pages.Nav.addAction '+rel', -> pages.PlusRel.display()

	pages.Edit = new Page ->
		@addRow makeInput 'name',placeIndex
		@addRow makeInput 'lat',place().lat
		@addRow makeInput 'lng',place().lng
		document.getElementById("name").focus()
		document.getElementById("name").select()
	pages.Edit.addAction 'Update', -> 
		name = prettyName getField "name"
		lat = parseFloat getField "lat"
		lng = parseFloat getField "lng"
		if isNumeric(lat) and isNumeric(lng)
			places[name] = {lat: lat, lng: lng}
			if placeIndex != name then delete places[placeIndex]
			placeIndex = name
			storeData()
			pages.List.display()
	pages.Edit.addAction 'Cancel', -> pages.List.display()

	pages.PlusAbs = new Page ->
		if track.length > 0
			last = _.last track
			@addRow makeInput 'name', '' # prettyDate new Date last.timestamp
			@addRow makeInput 'lat',  precisionRound last.lat,6
			@addRow makeInput 'lng',  precisionRound last.lng,6
		else
			@addRow makeInput 'name', 'Missing'
			@addRow makeInput 'lat',  0
			@addRow makeInput 'lng',  0
		document.getElementById("name").focus()
		document.getElementById("name").select()
	pages.PlusAbs.addAction	'Save', -> 
		name = prettyName getField "name"
		lat = parseFloat getField "lat"
		lng = parseFloat getField "lng"
		if isNumeric(lat) and isNumeric(lng)
			places[name] = {lat:lat, lng:lng, timestamp: prettyDate new Date()}
			storeData()
			pages.List.display()
	pages.PlusAbs.addAction 'Cancel', -> pages.List.display()

	pages.PlusRel = new Page ->
		@addRow makeInput 'name', ''
		@addRow makeInput 'distance (m)',  ''
		@addRow makeInput 'bearing',  ''
		document.getElementById("name").focus()
	pages.PlusRel.addAction	'Save', -> 
		name = prettyName getField "name"
		dist = parseFloat getField "distance (m)"
		bear = parseFloat getField "bearing"
		if isNumeric(dist) and isNumeric(bear)
			newPoint = calcDestinationPoint places[placeIndex],dist,bear
			places[name] = {lat: newPoint.lat, lng: newPoint.lng, timestamp: prettyDate new Date()} 
			storeData()
			pages.List.display()
	pages.PlusRel.addAction 'Cancel', -> pages.List.display()

	pages.Del = new Page -> 
		@addRow makeInput 'name',placeIndex,true
		@addRow makeInput 'lat',place().lat,true
		@addRow makeInput 'lng',place().lng,true
	pages.Del.addAction 'Delete', -> 
		delete places[placeIndex]
		storeData()
		pages.List.display()
	pages.Del.addAction 'Cancel', -> pages.Nav.display()

	pages.Link = new Page -> 
		@addRow makeDiv "Click SelAll, Copy and Mail #{placeIndex} and your current position to a friend."
		@addRow link = makeTextArea 'link'
		links = []
		links.push encodeURI "#{LINK}?name=#{placeIndex}&lat=#{place().lat}&lng=#{place().lng}" 
		if track.length > 0
			curr = _.last track
			links.push encodeURI "#{LINK}?name=#{'Christer'}&lat=#{curr.lat}&lng=#{curr.lng}&timestamp=#{curr.timestamp}"
		link.value = links.join("\n") + logg.join("\n")
	pages.Link.addAction 'SelAll', -> 
		iosCopyToClipboard document.getElementById("link")
		# pages.Nav.display()
	pages.Link.addAction 'Cancel', -> 
		pages.Nav.display()

	pages.Links = new Page -> 
		@addRow makeDiv "Click Copy and Mail all your points to a friend."
		@addRow link = makeTextArea 'link'
		links = []
		for key,p of places
			links.push encodeURI "#{LINK}?name=#{key}&lat=#{p.lat}&lng=#{p.lng}" 
		link.value = links.join "\n"
	pages.Links.addAction 'Copy', -> 
		iosCopyToClipboard document.getElementById("link")
		pages.List.display()
	pages.Links.addAction 'Cancel', -> 
		pages.List.display()

	# startsida:
	pages.List.display()

```
// fungerar på iPad: iOS 11.2.2
// fungerar ej på 4s iOS 9.3.5. Workaround: Låt användaren utföra kopieringen.
// https://stackoverflow.com/questions/34045777/copy-to-clipboard-using-javascript-in-ios
function iosCopyToClipboard(el) {
		var oldContentEditable = el.contentEditable,
				oldReadOnly = el.readOnly,
				range = document.createRange();

		el.contenteditable = true;
		el.readonly = false;
		range.selectNodeContents(el);

		var s = window.getSelection();
		s.removeAllRanges();
		s.addRange(range);

		el.setSelectionRange(0, 999999); // A big number, to cover anything that could be inside the element.

		el.contentEditable = oldContentEditable;
		el.readOnly = oldReadOnly;

		// document.execCommand('copy');
}
```