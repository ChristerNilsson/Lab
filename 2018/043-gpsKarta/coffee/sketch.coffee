DELAY = 100 # ms, delay between sounds
DIST = 1 # meter. Movement less than DIST makes no sound 1=walk. 5=bike

DISTANCES = [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000]

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

speaker = null

img = null 
soundUp = null
soundDown = null
soundQueue = 0 # neg=minskat avstånd pos=ökat avstånd

messages = []

[gpsLat,gpsLon] = [0,0]
[trgLat,trgLon] = [0,0]
currentControl = "1"
timeout = null

say = (m) ->
	speechSynthesis.cancel()
	speaker.text = m
	speechSynthesis.speak speaker

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

sayDistance = (a,b) ->
	# if a border is crossed, play a sound
	for distance in DISTANCES
		count = 0
		if a<distance then count += 1
		if b<distance then count += 1
		if count==1
			if distance >= 10 then distance = 'distans ' + distance
			say distance, round(distance)//100

sayBearing = (a,b) -> # a is newer
	# if a border is crossed, play a sound
	a = round(a) // 10
	b = round(b) // 10
	if a != b # 0..35
		if a == 0 then a = 36
		s = a.toString()  
		if s.length == 1 then s = '0' + s
		say 'bäring ' + s[0] + ' ' + s[1]

showSpeed = (sp) -> buttons[0].prompt = myround sp, 1

soundIndicator = (p) ->

	a = LatLon p.coords.latitude,p.coords.longitude # newest
	b = LatLon gpsLat, gpsLon
	c = LatLon trgLat, trgLon # target

	dista = a.distanceTo c
	distb = b.distanceTo c
	distance = round((dista - distb)/DIST)
	buttons[5].prompt = round dista

	sayDistance dista,distb
	bearinga = a.bearingTo c
	bearingb = b.bearingTo c
	if dista >= 10 then sayBearing bearinga,bearingb

	showSpeed abs dista-distb

	if distance != 0 # update only if DIST detected. Otherwise some beeps will be lost.
		gpsLat = p.coords.latitude
		gpsLon = p.coords.longitude

	if abs(distance) < 10 then soundQueue = distance # ett antal DIST
	buttons[7].prompt	= soundQueue

playSound = ->
	if soundQueue == 0 then return
	if soundQueue < 0 and soundDown != null
		soundQueue++
		soundDown.play()
	else if soundQueue > 0 and soundUp != null
		soundQueue--
		soundUp.play()
	buttons[7].prompt	= soundQueue
	if soundQueue==0 then xdraw()

locationUpdate = (p) ->
	soundIndicator p

	position = gps.gps2bmp gpsLat,gpsLon

	track.push position
	if track.length > TRACKED then track.shift()
	xdraw()
	position

locationUpdateFail = (error) ->	if error.code == error.PERMISSION_DENIED then messages = ['Check location permissions']

initSpeaker = ->
	speaker = new SpeechSynthesisUtterance()
	voices = speechSynthesis.getVoices()
	speaker.voice = voices[5]	
	speaker.voiceURI = "native"
	speaker.volume = 1
	speaker.rate = 1
	speaker.pitch = 0.8
	speaker.text = 'Välkommen!'
	#speaker.lang = 'en-US'
	speaker.lang = 'sv-SE'

setup = ->

	createCanvas windowWidth,windowHeight

	WIDTH = img.width
	HEIGHT = img.height

	SCALE = 1
	[cx,cy] = [width,height]
	
	makeCorners()
	setTarget _.keys(controls)[0]

	x = width/2
	y = height/2
	x1 = 100
	x2 = width-100
	y1 = 100
	y2 = height-100

	buttons.push new Button 'S',x1,y1, -> # Store Bike Position
		initSpeaker()
		soundUp = loadSound 'soundUp.wav'
		soundDown = loadSound 'soundDown.wav'
		soundUp.setVolume 0.1
		soundDown.setVolume 0.1
		controls['bike'] = position
		buttons[2].prompt = 'bike'
		clearInterval timeout
		timeout = setInterval playSound, DELAY
		soundQueue = 0

	buttons.push new Button 'U',x,y1, -> cy -= 0.33*height/SCALE 
	buttons.push new Button '',x2,y1, -> setTarget 'bike'

	buttons.push new Button 'L',x1,y, -> cx -= 0.33*width/SCALE
	buttons.push new Button '', x,y, ->	[cx,cy] = position

	buttons.push new Button 'R',x2,y, -> cx += 0.33*width/SCALE
	buttons.push new Button '-',x1,y2, -> if SCALE > 0.5 then SCALE /= 1.5
	buttons.push new Button 'D',x,y2, -> cy += 0.33*height/SCALE
	buttons.push new Button '+',x2,y2, ->	SCALE *= 1.5

	position = [WIDTH/2,HEIGHT/2]

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail,
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	xdraw()

	addEventListener 'touchstart', (evt) ->
		touches = evt.changedTouches
		touch = touches[touches.length-1]
		mx = touch.pageX
		my = touch.pageY
		myMousePressed mx,my

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

drawControl = ->

	latLon2 = LatLon trgLat,trgLon
	latLon1 = LatLon gpsLat,gpsLon

	bearing = latLon1.bearingTo latLon2
	buttons[1].prompt = int bearing
	buttons[3].prompt = currentControl

	control = controls[currentControl]
	x = control[0]
	y = control[1]

	push()
	sc()
	fc 0,0,0,0.25
	translate width/2, height/2
	scale SCALE
	circle x-cx, y-cy, 75
	pop()

drawButtons = -> button.draw() for button in buttons

xdraw = ->
	bg 1,1,0
	fc()
	image img, 0,0, width,height, cx-width/SCALE/2, cy-height/SCALE/2, width/SCALE, height/SCALE
	drawTrack()
	drawControl()
	drawButtons()
	textSize 50
	for message,i in messages
		text message,width/2,50*(i+1)

setTarget = (key) ->
	if controls[currentControl] == null then return
	soundQueue = 0
	currentControl = key
	control = controls[currentControl]
	x = control[0]
	y = control[1]
	[trgLat,trgLon] = gps.bmp2gps x,y	

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
		setTarget key
		xdraw()

# only for debug on laptop
# mousePressed = -> myMousePressed mouseX,mouseY
