FILENAME = 'karta.jpg'

spara = (lat,lon, x,y) -> {lat,lon, x,y}
B = spara 59.300593,18.163456, 5422,158 
A = spara 59.300736,18.125648, 554,433
C = spara 59.265339,18.159501, 5384,9114 
D = spara 59.281411,18.122435, 338,5298  # Sockenvägen/Ätravägen
E = spara 59.266262,18.144961, 3496,8980 # Garden Center

DATA = "gpsKarta"
WIDTH = 6912
HEIGHT = 9216
[cx,cy] = [0,0] # center (image coordinates)
SCALE = 1

released = true # to make Android work

gps = null
TRACKED = 5 # circles shows the player's position
position = null # gps position (pixels)
track = [] # five latest GPS positions (pixels)
buttons = []
points = [] # remembers e.g. car/bike position
img = null 
bearing = 360

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
	lon = map x, a.x,b.x, a.lon,b.lon
	lat = map y, c.y,d.y, c.lat,d.lat  
	{lat,lon,x,y} 	

makeCorners = ->
	ad0 = vercal A,D,0
	ad1 = vercal A,D,HEIGHT
	bc0 = vercal B,C,0
	bc1 = vercal B,C,HEIGHT

	ab0 = hortal A,B,0
	ab1 = hortal A,B,WIDTH
	ec0 = hortal E,C,0
	ec1 = hortal E,C,WIDTH

	nw = corner ad0,bc0,ab0,ec0,0,    0
	ne = corner ad0,bc0,ab1,ec1,WIDTH,0
	se = corner ad1,bc1,ab1,ec1,WIDTH,HEIGHT
	sw = corner ad1,bc1,ab0,ec0,0,    HEIGHT

	gps = new GPS nw,ne,se,sw,WIDTH,HEIGHT

	# Testpunkter
	P1 = spara 59.275687,18.155340, 4697, 6518 # krknök
	P2 = spara 59.280348,18.155122, 4590,5310 # trevägsskylt
	P3 = B
	P4 = spara 59.279172,18.149319, 3877,5681 # Bron

	gps.assert_gps2bmp P1, [6,7]
	gps.assert_gps2bmp P2, [24,38]
	gps.assert_gps2bmp P3, [0,1]
	gps.assert_gps2bmp P4, [-4,7]

	gps.assert_bmp2gps P1,[2.4,-1.2]
	gps.assert_bmp2gps P2,[14.9, -7.35]
	gps.assert_bmp2gps P3,[0.2,0]
	gps.assert_bmp2gps P4,[2.3,2.75]

locationUpdate = (p) ->
	lat = p.coords.latitude
	lon = p.coords.longitude
	position = gps.gps2bmp lat,lon
	track.push position
	if track.length > TRACKED then track.shift()

locationUpdateFail = (error) ->	if error.code == error.PERMISSION_DENIED then messages = ['Check location permissions']

setupCompass = -> window.addEventListener "deviceorientation", (event) ->	bearing = round event.alpha 

storeData = -> localStorage[DATA] = JSON.stringify points	
fetchData = -> if localStorage[DATA] then points = JSON.parse localStorage[DATA]

setup = ->
	createCanvas windowWidth,windowHeight

	[cx,cy] = [WIDTH/2,HEIGHT/2] 

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

	buttons.push new Button 'U',x,y1, -> cy -= 0.5*height/SCALE

	buttons.push new Button '0',x2,y1, -> 
		if points.length > 0 
			points.pop()
			storeData()

	buttons.push new Button 'L',x1,y, -> cx -= 0.5*width/SCALE
	buttons.push new Button 'C',x,y, ->	[cx,cy] = position
	buttons.push new Button 'R',x2,y, -> cx += 0.5*width/SCALE
	buttons.push new Button 'D',x,y2, -> cy += 0.5*height/SCALE
	buttons.push new Button '-',x1,y2, -> SCALE /= 1.5
	buttons.push new Button '+',x2,y2, -> SCALE *= 1.5

	makeCorners()

	position = [WIDTH/2,HEIGHT/2]

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	setupCompass()

drawTrack = ->
	push()
	fc()
	sw 2
	sc 1,1,0 # YELLOW
	translate width/2, height/2
	scale SCALE
	for [x,y],i in track
		circle x-cx, y-cy, 5*(track.length-i)
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

drawButtons = ->
	buttons[2].prompt = points.length
	buttons[4].prompt = 360 - bearing
	for button in buttons
		button.draw()

drawCompass = ->
	push()
	strokeCap SQUARE
	translate width/2, height/2
	rotate radians bearing
	sw 10
	sc 1,0,0
	line 0,-100,0,-150
	sc 1
	line 0,100,0,150
	pop()

draw = ->
	bg 0
	fc()
	image img, 0,0, width,height, cx-width/SCALE/2, cy-height/SCALE/2, width/SCALE, height/SCALE
	drawTrack()
	drawPoints()
	drawCompass()
	drawButtons()

mouseTouched = -> 
	# if not released then return false # to make Android work
	# released = false            # to make Android work
	# for button in buttons
	# 	if button.contains mouseX,mouseY then button.click()
	false       # to make Android work

mouseReleased = ->            # to make Android work
	released = true             # to make Android work
	false                       # to make Android work

mousePressed = ->
	if not released then return false # to make Android work
	released = false            # to make Android work
	for button in buttons
		if button.contains mouseX,mouseY then button.click()
	false                       # to make Android work