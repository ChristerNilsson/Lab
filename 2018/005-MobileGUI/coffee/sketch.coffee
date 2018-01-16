# https://stackoverflow.com/questions/2010892/storing-objects-in-html5-localstorage

places = []
places.push {name:'Bagarmossen Sushi',     lat:59.277560, lng:18.132739}
places.push {name:'Bagarmossen T',         lat:59.276264, lng:18.131465}
places.push {name:'Björkhagens Golfklubb', lat:59.284052, lng:18.145925}
places.push {name:'Björkhagen T',          lat:59.291114, lng:18.115521}
places.push {name:'Brotorpsbron',          lat:59.270067, lng:18.150236}
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

pages = {}
place = null
oldName = null

class Page

	constructor : (@actionCount, @init) -> 
		@table = document.getElementById "table"
		@actions = []

	addAction : (title, f) -> @actions.push makeButton title, @actionCount, f

	display : ->
		# actions
		elem = document.getElementById 'myActions'
		elem.innerHTML = ""
		span = document.createElement "span"
		for action in @actions
			span.appendChild action
		elem.appendChild span

		# init page
		hideCanvas()
		@table.innerHTML = ""
		@init()
				
	addRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr

fetchData = ->
	data = localStorage["GPSCompass"]
	if data then places = JSON.parse data 
	#console.log 'fetch',places 

storeData = -> localStorage["GPSCompass"] = JSON.stringify places	
	#console.log 'store',localStorage["GPSCompass"]

setup = ->

	fetchData()

	c = createCanvas windowWidth,windowHeight
	c.parent 'myContainer'	
	hideCanvas()

	pages.List = new Page 1, ->
		for p,i in places
			do (i) =>
				b = makeButton p.name, @actionCount, => 
					place = places[i]
					pages.Nav.display()
				b.style.textAlign = 'left' 
				@addRow b		
	pages.List.addAction 'Add', -> pages.Add.display()

	pages.Nav = new Page 4, -> showCanvas()
	pages.Nav.addAction 'List', -> pages.List.display()
	pages.Nav.addAction 'Map', -> window.open "http://maps.google.com/maps?q=#{place.lat},#{place.lng}"
	pages.Nav.addAction 'Edit', -> pages.Edit.display()
	pages.Nav.addAction 'Del', -> 
		places = places.filter (e) => e.name != place.name
		storeData()
		pages.List.display()

	pages.Edit = new Page 2, ->
		oldName = place.name
		@addRow makeInput 'name',place.name
		@addRow makeInput 'lat',place.lat
		@addRow makeInput 'lng',place.lng
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

	pages.Add  = new Page 2, ->
		@addRow makeInput 'name','2018-01-15 12:34:56'
		@addRow makeInput 'lat','59.123456'
		@addRow makeInput 'lng','18.123456'
	pages.Add.addAction	'Save', -> 
		name = getField "name"
		lat = parseFloat(getField "lat")
		lng = parseFloat(getField "lng")
		if isNumeric(lat) and isNumeric(lng)
			places.push {name:name, lat:lat, lng:lng}
			places.sort (a,b) -> if a.name > b.name then 1 else -1
			storeData()
			pages.List.display()
	pages.Add.addAction 'Cancel', -> pages.List.display()

	# startsida:
	pages.List.display()

draw = ->
	bg 0.5
	if place then	text place.name,100,100
