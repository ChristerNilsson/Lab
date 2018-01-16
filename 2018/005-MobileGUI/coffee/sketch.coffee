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

pages = []
placeIndex = 0
place = places[placeIndex]
oldName = null
name = null
latitude = null
longitude = null

makeCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'block'

makeDiv = (title) ->
	b = document.createElement 'div'
	b.innerHTML = title
	b

makeInput = (title,value) ->
	b = document.createElement 'input'
	b.id = title
	b.value = value 
	b

makeButton = (title,f) ->
	b = document.createElement 'input'
	b.type = 'button'
	b.value = title
	b.onclick = f
	b

addCell = (tr,value) ->
	td = document.createElement "td"
	td.appendChild value
	tr.appendChild td

getField = (name) ->
	element = document.getElementById(name)
	if element then element.value else null

class Page

	constructor : (@title, @elements) ->
		@table = document.getElementById "table"

	display : ->
		elem = document.getElementById 'myTitle'
		elem.innerHTML = @title + if @title =='Nav' then ': ' + place.name else ""

		elem = document.getElementById 'myContainer'
		elem.style.display = 'none'		

		# rensa body
		@table.innerHTML = ""

		for element in @elements
			@makeElement element
				
	handleRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr

	makeElement : (nr) ->
		# After Add
		if nr==2 then @handleRow makeButton 'Save', -> 
			name = getField "name"
			latitude = getField "latitude"
			longitude = getField "longitude"
			places.push {name:name,lat:latitude,lng:longitude}
			places.sort (a,b) -> if a.name > b.name then 1 else -1
			pages[0].display()
	
		if nr==3 # Edit
			oldName = place.name
			@handleRow makeInput 'name',place.name
			@handleRow makeInput 'latitude',place.lat
			@handleRow makeInput 'longitude',place.lng

		if nr==4 # Add
			@handleRow makeInput 'name','2018-01-15 12:34:56'
			@handleRow makeInput 'latitude','59.123456'
			@handleRow makeInput 'longitude','18.123456'

		if nr==5 then @handleRow makeButton 'List', -> pages[0].display()
		if nr==6 then @handleRow makeButton 'Map', -> window.open "http://maps.google.com/maps?q=#{place.lat},#{place.lng}"

		if nr==7 then @handleRow makeButton 'Update', -> # After Edit 
			name = getField "name"
			latitude = getField "latitude"
			longitude = getField "longitude"

			# finns namnet redan?
			if oldName == name
				for p in places
					if oldName == p.name
						p.lat = latitude
						p.lng = longitude
			else
				places = places.filter (e) => e.name != oldName
				places.push {name:name,lat:latitude,lng:longitude}
				places.sort (a,b) -> if a.name > b.name then 1 else -1
			pages[0].display()

		if nr==8 then @handleRow makeButton 'Delete', -> 
			places = places.filter (e) => e.name != place.name
			pages[0].display()

		if nr==9 then @handleRow makeButton 'Cancel', -> pages[1].display()
		if nr==10 then @handleRow makeButton 'Add', -> pages[3].display()
		if nr==11 then @handleRow makeButton 'Edit', -> pages[2].display()
		if nr==12 then makeCanvas()

		if nr==13
			for p,i in places
				do (i) =>
					@handleRow makeButton p.name, => 
						placeIndex = i
						place = places[i]
						pages[1].display()

setup = ->
	c = createCanvas 200,200
	c.parent 'myContainer'	
	elem = document.getElementById 'myContainer'
	elem.style.display = 'none'

	pages.push new Page 'List', [10,13] # Add Places
	pages.push new Page 'Nav',  [12,5,6,10,11,8] # Canvas List Map Add Edit Delete
	pages.push new Page 'Edit', [3,7,9] # 3fält Update Cancel
	pages.push new Page 'Add',  [4,2,9] # 3fält Save Cancel
	pages[0].display()

draw = ->
	bg 0.5
	text place.name,100,100
