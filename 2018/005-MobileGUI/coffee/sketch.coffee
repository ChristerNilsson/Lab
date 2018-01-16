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

placeIndex = 0
place = places[placeIndex]
oldName = null

class Page

	constructor : (@title, @actions, @elements) -> # @actions visas på samma rad
		@actions = @actions.split ' '
		@elements = @elements.split ' '
		@table = document.getElementById "table"

	display : ->
		elem = document.getElementById 'myTitle'
		elem.innerHTML = ""

		div = document.createElement "span"
		span = document.createElement "span"
		span.style = "font-size:150%"
		span.innerHTML = @title
		div.appendChild span 
		for action in @actions
			div.appendChild @makeAction action,@actions.length
		elem.appendChild div

		hideCanvas()

		# rensa body
		@table.innerHTML = ""

		for element in @elements
			@makeElement element
				
	addRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr

	makeAction : (action,n) ->
		# After Add
		if action=='save' then return makeButton 'Save', n, -> 
			name = getField "name"
			lat = getField "lat"
			lng = getField "lng"
			places.push {name:name, lat:lat, lng:lng}
			places.sort (a,b) -> if a.name > b.name then 1 else -1
			pages.List.display()

		if action =='listbutton' then return makeButton 'List', n, -> pages.List.display()
		if action =='map' then return makeButton 'Map', n, -> window.open "http://maps.google.com/maps?q=#{place.lat},#{place.lng}"

		if action =='update' then return makeButton 'Update', n, -> # After Edit 
			name = getField "name"
			lat = getField "lat"
			lng = getField "lng"

			# finns namnet redan?
			if oldName == name
				for p in places
					if oldName == p.name
						p.lat = lat
						p.lng = lng
			else
				places = places.filter (e) => e.name != oldName
				places.push {name:name,lat:lat,lng:lng}
				places.sort (a,b) -> if a.name > b.name then 1 else -1
			pages.List.display()

		if action =='delete' then return makeButton 'Delete', n, -> 
			places = places.filter (e) => e.name != place.name
			pages.List.display()

		if action =='cancel' then return makeButton 'Cancel', n, -> pages.Nav.display()
		if action =='add'    then return makeButton 'Add',    n, -> pages.Add.display()
		if action =='edit'   then return makeButton 'Edit',   n, -> pages.Edit.display()

	makeElement : (element ) ->
		if element == 'canvas' then showCanvas()

		if element == 'list'
			for p,i in places
				do (i) =>
					@addRow makeButton p.name, 1, => 
						placeIndex = i
						place = places[i]
						pages.Nav.display()
	
		if element == 'formedit' 
			oldName = place.name
			@addRow makeInput 'name',place.name
			@addRow makeInput 'lat',place.lat
			@addRow makeInput 'lng',place.lng

		if element == 'formadd' 
			@addRow makeInput 'name','2018-01-15 12:34:56'
			@addRow makeInput 'lat','59.123456'
			@addRow makeInput 'lng','18.123456'

setup = ->
	c = createCanvas 200,200 #,windowWidth,windowHeight
	c.parent 'myContainer'	
	hideCanvas()

	pages.List = new Page '', 'add', 'list'
	pages.Nav  = new Page '',  'listbutton map add edit delete', 'canvas'
	pages.Edit = new Page '', 'update cancel', 'formedit'
	pages.Add  = new Page '',  'save cancel', 'formadd'

	pages.List.display()

draw = ->
	bg 0.5
	text place.name,100,100
