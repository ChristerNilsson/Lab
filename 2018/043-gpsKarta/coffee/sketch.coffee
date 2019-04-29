spara = (lat,lon, x,y) -> {lat,lon, x,y}

# 2019-SommarN
A = spara 59.300716, 18.125680, 197,278 # Lilla halvön
B = spara 59.299235, 18.169492, 4306,367 # Kranglans väg/Östervägen
C = spara 59.285443, 18.124585, 236,3082 # Ishockeyrink Mitten
D = spara 59.287806, 18.170784, 4525,2454 # Mittenhus t v

FILENAME = '2019-SommarN.jpg' 

controls = 
	1: [1830,333]
	2: [1506,521]
	3: [907,711]
	4: [1193,873]
	5: [472,617]
	6: [228,841]
	7: [672,1013]
	8: [1125,1196]
	9: [1430,1290]
	10: [4361,503]
	11: [4118,1106]
	12: [3830,640]
	13: [3192,1133]
	14: [2664,873]
	15: [2322,1862]
	16: [4120,2699]
	17: [4181,3069]
	19: [3340,2904]
	20: [2691,2554]
	24: [3366,3217]
	26: [390,1935]
	27: [547,2143]
	28: [1462,2293]
	29: [1055,2620]
	30: [371,2502]
	31: [1090,3104]
	32: [2250,2750]

# 2019-SommarS
# A = spara 59.279157, 18.149313, 2599,676 # Mellanbron
# B = spara 59.275129, 18.169590, 4531,1328 # Ulvsjön Vändplan Huset
# C = spara 59.270072, 18.150229, 2763,2334 # Brotorpsbron
# D = spara 59.267894, 18.167087, 4339,2645 # Älta huset

# FILENAME = '2019-SommarS.jpg' 

# controls = 
# 	21: [4303,255]
# 	22: [4066,407]
# 	23: [3436,158]
# 	25: [3534,485]
# 	34: [1709,65]
# 	35: [1212,151]
# 	36: [2215,1008]
# 	37: [2571,1186]
# 	38: [2894,485]
# 	39: [3245,778]
# 	40: [4317,1003]
# 	41: [4303,685]
# 	42: [3868,1292]
# 	43: [3426,1281]
# 	44: [3536,1650]
# 	45: [4538,1763]
# 	46: [3926,2133]
# 	47: [3104,2025]
# 	48: [4256,2514]
# 	49: [3773,2493]
# 	50: [3231,2757]

#################

DATA = "gpsKarta"
WIDTH = null
HEIGHT = null
[cx,cy] = [0,0] # center (image coordinates)
SCALE = 1

gps = null
TRACKED = 5 # circles shows the player's position
position = null # gps position (pixels)
track = [] # five latest GPS positions (pixels)
buttons = []
points = [] # remembers e.g. car/bike position
img = null 
heading = 360
messages = []
lastLatLon = null
currLatLon = null

[gpsLat,gpsLon] = [0,0]
currentControl = "1"

preload = -> img = loadImage FILENAME

myround = (x,dec=6) ->
	x *= 10**dec
	x = round x
	x/10**dec

show = (prompt,p) -> print prompt,"http://maps.google.com/maps?q=#{p.lat},#{p.lon}"	

vercal = (a,b,y) ->
	x = map y, a.y,b.y, a.x,b.x
	lat = map y, a.y,b.y, a.lat,b.lat
	lon = map y, a.y,b.y, a.lon,b.lon  
	{lat,lon,x,y} 	

hortal = (a,b,x) ->
	y = map x, a.x,b.x, a.y,b.y
	lat = map x, a.x,b.x, a.lat,b.lat
	lon = map x, a.x,b.x, a.lon,b.lon  
	{lat,lon,x,y} 	

corner = (a,b,c,d,x,y)->
	lat = map y, c.y,d.y, c.lat,d.lat  
	lon = map x, a.x,b.x, a.lon,b.lon
	{lat,lon,x,y}

makeCorners = ->

	ac0 = vercal A,C,0  	                  # beräkna x
	ac1 = vercal A,C,HEIGHT
	bd0 = vercal B,D,0
	bd1 = vercal B,D,HEIGHT

	ab0 = hortal A,B,0                      # beräkna y
	ab1 = hortal A,B,WIDTH
	cd0 = hortal C,D,0
	cd1 = hortal C,D,WIDTH

	nw = corner ac0,bd0,ab0,cd0, 0,    0		# beräkna hörnen
	ne = corner ac0,bd0,ab1,cd1, WIDTH,0
	se = corner ac1,bd1,ab1,cd1, WIDTH,HEIGHT
	sw = corner ac1,bd1,ab0,cd0, 0,    HEIGHT

	gps = new GPS nw,ne,se,sw,WIDTH,HEIGHT

locationUpdate = (p) ->
	gpsLat = p.coords.latitude
	gpsLon = p.coords.longitude
	lastLatLon = currLatLon
	currLatLon = LatLon gpsLat,gpsLon
	position = gps.gps2bmp gpsLat,gpsLon
	if lastLatLon != null and currLatLon != null
		heading = lastLatLon.bearingto currLatLon
		if isNan heading then heading = null
	else
		heading = null
	track.push position
	if track.length > TRACKED then track.shift()
	xdraw()
	position

locationUpdateFail = (error) ->	if error.code == error.PERMISSION_DENIED then messages = ['Check location permissions']

# setupCompass = ->
# 	window.addEventListener "deviceorientation", (event) ->
# 		bearing = round event.alpha 
# 		xdraw()

storeData = -> localStorage[DATA] = JSON.stringify points	
fetchData = -> if localStorage[DATA] then points = JSON.parse localStorage[DATA]

setup = ->

	createCanvas windowWidth,windowHeight

	WIDTH = img.width
	HEIGHT = img.height

	SCALE = 1 
	[cx,cy] = [width,height] 
	
	fetchData()

	x = width/2
	y = height/2
	x1 = 100
	x2 = width-100
	y1 = 100
	y2 = height-100

	buttons.push new Button 'S',x1,y1, -> 
		points.push position
		storeData()

	buttons.push new Button 'U',x,y1, -> cy -= 0.25*height/SCALE
	buttons.push new Button '0',x2,y1, -> 
		if points.length > 0 
			points.pop()
			storeData()

	buttons.push new Button 'L',x1,y, -> cx -= 0.25*width/SCALE
	buttons.push new Button ' ',x,y, ->	[cx,cy] = position
	buttons.push new Button 'R',x2,y, -> cx += 0.25*width/SCALE
	buttons.push new Button '-',x1,y2, -> if SCALE > 0.5 then SCALE /= 1.2
	buttons.push new Button 'D',x,y2, -> cy += 0.25*height/SCALE
	buttons.push new Button '+',x2,y2, ->	SCALE *= 1.2

	makeCorners()

	position = [WIDTH/2,HEIGHT/2]

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	#setupCompass()
	xdraw()

	addEventListener 'touchstart', (evt) ->
		touches = evt.changedTouches
		touch = touches[touches.length-1]
		mx = touch.pageX
		my = touch.pageY
		myMousePressed mx,my

	# test 
	# 	lat: 59.279170
	# 	lon: 18.149327 
	# 	x: 1932
	# 	y: 2923

	# test # Bron Ö om golfstugan
	# 	lat:59.285496
	# 	lon: 18.150525 
	# 	x: 2662
	# 	y: 2830
	# test A
	# test B
	# test C
	# test D

	# test # Brotorpsbron
	# 	lat: 59.270066 
	# 	lon: 18.150228
	# 	x: 2171
	# 	y: 4124

# test = ({lat,lon,x,y}) ->
# 	print 'test'
# 	hash =
# 		coords:
# 			latitude:  lat
# 			longitude: lon
# 	print x,y,locationUpdate hash

drawTrack = ->
	push()
	fc()
	sw 4
	sc 0 # BLACK
	translate width/2, height/2
	scale SCALE
	for [x,y],i in track
		circle x-cx, y-cy, 10 * (track.length-i)
	pop()

drawPoints = ->
	push()
	sc()
	fc 1,0,0,0.5 # RED
	translate width/2, height/2
	scale SCALE
	for [x,y],i in points
		circle x-cx, y-cy, 20
	pop()

drawControl = ->
	control = controls[currentControl]
	#print control
	x = control[0]
	y = control[1]

	[lat,lon] = gps.bmp2gps x,y
	latLon2 = LatLon lat,lon
	latLon1 = LatLon gpsLat,gpsLon
	distance = latLon1.distanceTo latLon2
	bearing = latLon1.bearingTo latLon2
	buttons[3].prompt = currentControl
	buttons[4].prompt = int bearing

	if heading == null
		buttons[1].prompt = ''
		buttons[7].prompt = ''
	else
		buttons[1].prompt = int heading
		buttons[7].prompt = int bearing - heading
	if distance == null
		buttons[5].prompt = ''
	else
		buttons[5].prompt = int distance

	push()
	sc()
	fc 0,0,0,0.5
	translate width/2, height/2
	scale SCALE
	circle x-cx, y-cy, 75
	pop()

drawButtons = ->
	buttons[2].prompt = points.length
	for button in buttons
		button.draw()

# drawCompass = ->
# 	push()
# 	strokeCap SQUARE
# 	translate width/2, height/2
# 	rotate radians bearing
# 	sw 10
# 	sc 1,0,0
# 	line 0,-100,0,-1502
# 	sc 1
# 	line 0,100,0,150
# 	pop()

xdraw = ->
	bg 1,1,0
	fc()
	image img, 0,0, width,height, cx-width/SCALE/2, cy-height/SCALE/2, width/SCALE, height/SCALE
	drawTrack()
	drawPoints()
	drawControl()
	#drawCompass()
	drawButtons()
	textSize 50
	for message,i in messages
		text message,width/2,50*(i+1)

# keyPressed = ->
# 	#         S  U  P  L SP  R  D   -   +
# 	index = [83,85,80,76,32,82,68,189,187].indexOf keyCode
# 	if index != -1 
# 		buttons[index].click()
# 		xdraw()

myMousePressed = (mx,my) ->
	for button in buttons
		if button.contains mx,my
			button.click()
			xdraw()
			return
	arr = ([dist(cx-width/SCALE/2 + mx/SCALE, cy-height/SCALE/2+my/SCALE, control[0], control[1]), key] for key,control of controls)
	closestControl = _.min arr, (item) -> item[0]
	[d,key] = closestControl
	if d < 85 
		currentControl = key
		xdraw()

#mousePressed = -> myMousePressed mouseX,mouseY
