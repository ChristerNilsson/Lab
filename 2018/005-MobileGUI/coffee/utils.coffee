tests = {}

addCell = (tr,value) ->
	td = document.createElement "td"
	td.appendChild value
	tr.appendChild td

# Visa vinkelavvikelse med färgton. 
# -180 = black
#  -90 = red
#    0 = white
#   90 = green 
#  180 = black
calcColor = (delta) -> # -180 <= delta <= 180
	if      -180 <= delta <  -90 then res = lerpColor BLACK, RED,  (delta+180)/90
	else if  -90 <= delta <    0 then res = lerpColor RED,   WHITE,(delta+90)/90
	else if    0 <= delta <   90 then res = lerpColor WHITE, GREEN,(delta+0)/90
	else if   90 <= delta <= 180 then res = lerpColor GREEN, BLACK,(delta-90)/90
	else res = color 255,255,0,255 # yellow, error 
	res.levels
tests.calcColor = ->
	assert [255,255,255,255], calcColor 0
	assert [128,255,128,255], calcColor 45
	assert [0,255,0,255], calcColor 90
	assert [0,128,0,255], calcColor 135
	assert [0,0,0,255], calcColor 180
	assert [255,128,128,255], calcColor -45
	assert [255,0,0,255], calcColor -90
	assert [128,0,0,255], calcColor -135
	assert [0,0,0,255], calcColor -180

	assert [255,255,0,255], calcColor -225
	assert [255,255,0,255], calcColor -270
	assert [255,255,0,255], calcColor -315
	assert [255,255,0,255], calcColor -360
	assert [255,255,0,255], calcColor 225
	assert [255,255,0,255], calcColor 270
	assert [255,255,0,255], calcColor 315
	assert [255,255,0,255], calcColor 360

calcDelta = (delta) ->
	if delta < -180 then delta += 360
	if delta > +180 then delta -= 360
	delta
tests.calcDelta = ->
	assert 0, calcDelta -360
	assert 90, calcDelta -270
	assert -180, calcDelta -180
	assert -90, calcDelta -90
	assert 0, calcDelta 0
	assert 90, calcDelta 90
	assert 180, calcDelta 180
	assert -90, calcDelta 270
	assert 0, calcDelta 360

calcETA = (ta,tp,a,p,b) ->
	dt = (tp-ta)/1000 # sekunder	
	ap = distance_on_geoid a,p # meter
	pb = distance_on_geoid p,b # meter 
	if ap>0 then dt/ap*(ap+pb) else 0 # sekunder	
tests.calcETA = ->
	a  = {lat:59.000000, lng:18.100000}
	b  = {lat:59.200000, lng:18.100000}
	p0 = {lat:59.000000, lng:18.000000}
	p1 = {lat:59.100000, lng:18.000000}
	p2 = {lat:59.200000, lng:18.000000}
	p3 = {lat:59.100000, lng:18.100000}
	assert 5009.176237166901,  calcETA 0,1000000,a,p0,b   
	assert 1999.3916011809056, calcETA 0,1000000,a,p1,b 
	assert 1247.9772474262074, calcETA 0,1000000,a,p2,b  
	assert 1999.9999999998727, calcETA 0,1000000,a,p3,b  

calcHeading = (p1,p2) ->
	q1 = LatLon p1.lat,p1.lng
	q2 = LatLon p2.lat,p2.lng
	q1.bearingTo q2
tests.calcHeading = ->
	a = {lat:59.000000, lng:18.100000}
	b = {lat:59.100000, lng:18.100000}
	p = {lat:59.050000, lng:18.000000}
	assert   0, calcHeading a,b 
	assert 180, calcHeading b,a 
	assert 314.2148752824801,  calcHeading a,p 
	assert 134.12913607386804, calcHeading p,a 
	assert  45.74342946571903, calcHeading p,b 
	assert 225.82921355457827, calcHeading b,p 

calcSpeed = (ta,tp,a,p,b) -> # anger den hastighet man har från startpunkten
	dt = (tp-ta)/1000 # sekunder
	ap = distance_on_geoid a,p # meter
	if dt>0 then ap/dt else 0 # m/s
tests.calcSpeed = ->
	a = {lat:59.000000, lng:18.100000}
	b = {lat:59.100000, lng:18.100000}
	p = {lat:59.050000, lng:18.000000}
	assert 7.978798475908504, calcSpeed 0,1000000,a,p,b # 1000 sekunder

# calcSpeed = (ta,tp,a,p,b) -> # anger den hastighet man närmar sig målet med. Typ vmg utan vinklar
# 	ab = distance_on_geoid a,b # meter
# 	pb = distance_on_geoid p,b # meter
# 	dt = (tp-ta)/1000 # sekunder
# 	if dt>0 then (ab-pb)/dt else 0 # m/s
# tests.calcSpeed = ->
# 	a = {lat:59.000000, lng:18.100000}
# 	b = {lat:59.100000, lng:18.100000}
# 	p = {lat:59.050000, lng:18.000000}
# 	assert 3.1466610127605774, calcSpeed 0,1000000,a,p,b # 1000 sekunder

# https://cdn.rawgit.com/chrisveness/geodesy/v1.1.2/latlon-spherical.js
distance_on_geoid = (p1,p2) ->
	q1 = LatLon p1.lat,p1.lng
	q2 = LatLon p2.lat,p2.lng
	q1.distanceTo q2	
tests.distance_on_geoid = ->
	a = {lat:59.000000, lng:18.100000}
	b = {lat:59.100000, lng:18.100000}
	p = {lat:59.050000, lng:18.000000}
	assert 11119.492664456597, distance_on_geoid(a,b)
	assert 7972.831651696019, distance_on_geoid(p,b)

getField = (name) ->
	element = document.getElementById name
	if element then element.value else null

isNumeric = (val) -> val == Number parseFloat val
tests.isNumeric = ->
	assert true,isNumeric 1.2
	assert true,isNumeric 1
	assert false,isNumeric "1.2"
	assert false,isNumeric null
	assert false,isNumeric undefined 
	assert false,isNumeric NaN	

makeButton = (title,n,f) ->
	s = "#{Math.floor(100/n)}%"
	#print title,s
	b = document.createElement 'input'
	b.style.width = s
	#b.style.fontSize = "100%"
	b.style.fontSize = '100%'
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
	b.style.fontSize = "100%"	
	b.style.width = "100%"
	if readonly then b.setAttribute "readonly", true
	if title=='name' then b.autofocus = true
	#b.onfocus = "setTimeout(function () { this.select(); }, 50)"
	#b.onclick = "this.setSelectionRange(0, this.value.length)"
	b

precisionRound = (number, precision) ->
  factor = Math.pow 10, precision
  Math.round(number * factor) / factor
tests.precisionRound = ->
	assert 3.1, precisionRound 3.1415,1
	assert 3,   precisionRound 3.1415,0
	assert 40,  precisionRound 37.1415,-1

prettyDate = (date) ->
	y = date.getFullYear()
	m = ("0"+(date.getMonth()+1)).slice(-2)
	d = ("0" + date.getDate()).slice(-2) 
	hh = ("0" + date.getHours()).slice(-2)
	mm = ("0" + date.getMinutes()).slice(-2)
	ss = ("0" + date.getSeconds()).slice(-2)
	"#{y}-#{m}-#{d} #{hh}:#{mm}:#{ss}"
tests.prettyDate = ->
	assert "2018-01-20 02:34:56",prettyDate new Date 2018,0,20, 2,34,56
	assert "2018-02-20 12:34:56",prettyDate new Date 2018,1,20,12,34,56

test = ->
	start = millis()
	print "test start" 
	for key,tst of tests
		try 
			tst()
		catch e
			print 'Click on tests.' + key + ' to see failing assert.'
			print ' first', e.actual
			print 'second', e.expected		
			print e.stack
	print "test ready", round(millis()-start)+' ms'
