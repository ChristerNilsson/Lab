addCell = (tr,value) ->
	td = document.createElement "td"
	td.appendChild value
	tr.appendChild td

calcDelta = (delta) ->
	if delta < -180 then delta += 360
	if delta > +180 then delta -= 360
	delta

calcHeading = (p1,p2) ->
	#print 'calcHeading',p1
	#print 'calcHeading',p2
	q1 = LatLon p1.lat,p1.lng
	q2 = LatLon p2.lat,p2.lng
	q1.bearingTo q2

# https://cdn.rawgit.com/chrisveness/geodesy/v1.1.2/latlon-spherical.js
distance_on_geoid = (p1,p2) ->
	q1 = LatLon p1.lat,p1.lng
	q2 = LatLon p2.lat,p2.lng
	q1.distanceTo q2	

getField = (name) ->
	element = document.getElementById name
	if element then element.value else null

isNumeric = (val) -> val == Number parseFloat val

makeButton = (title,n,f) ->
	print 'makeButton',title,n
	b = document.createElement 'input'
	b.style.width = "#{Math.floor(100/n)}%"
	b.style.fontSize = "100%"
	b.style.webkitAppearance = "none"
	b.style.borderRadius = 0
	b.style.padding = 0
	b.type = 'button'
	b.value = title
	b.onclick = f
	b

makeDiv = (value) ->
	b = document.createElement 'div'
	b.innerHTML = value
	b

makeInput = (title,value,readonly=false) ->
	b = document.createElement 'input'
	b.id = title
	b.value = value
	b.placeholder = title
	if readonly then b.setAttribute "readonly", true
	if title=='name' then b.autofocus = true
	b.onclick = "this.setSelectionRange(0, this.value.length)"
	b

precisionRound = (number, precision) ->
  factor = Math.pow 10, precision
  Math.round(number * factor) / factor

prettyDate = (date) ->
	y = date.getFullYear()
	m = ("0"+(date.getMonth()+1)).slice(-2)
	d = ("0" + date.getDate()).slice(-2) 
	hh = ("0" + date.getHours()).slice(-2)
	mm = ("0" + date.getMinutes()).slice(-2)
	ss = ("0" + date.getSeconds()).slice(-2)
	"#{y}-#{m}-#{d} #{hh}:#{mm}:#{ss}"

