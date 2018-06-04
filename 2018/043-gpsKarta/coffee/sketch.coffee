spara = ([lat,lon],[x,y]) -> {lat, lon, x, y}

A = spara [59.300736, 18.125648],[554,433] 
B = spara [59.300593, 18.163456],[5422,158] 
C = spara [59.265339, 18.159501],[5384,9114] 
D = spara [59.281411, 18.122435],[338,5298] # Sockenvägen/Ätravägen
E = spara [59.266262, 18.144961],[3496,8980] # Garden Center

# Testpunkter
P1 = spara [59.275687,18.155340], [4697, 6518] # krknök
P2 = spara [59.280348,18.155122],[4590,5310] # trevägsskylt
P3 = B
P4 = spara [59.279172,18.149319],[3877,5681] # Bron

N = null
O = null
P = null
Q = null

WIDTH = 6912
HEIGHT = 9216
cx = 0 # center (image coordinates)
cy = 0
SCALE = 1

swidth = 0
sheight = 0

released = true 

gps = null
TRACKED = 5 # circles shows the player's position
position = null # gps position
track = [] # five latest GPS positions

buttons = []

img = null
message = ''
preload = -> img = loadImage 'karta.jpg'

myround = (x) ->
	x *= 1000000
	x = round x
	x/1000000

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
	F = vercal A,D,0
	G = vercal B,C,0
	H = hortal A,B,WIDTH
	I = hortal E,C,WIDTH
	J = vercal B,C,HEIGHT
	K = vercal A,D,HEIGHT
	L = hortal E,C,0
	M = hortal A,B,0

	N = corner F,G,M,L,0,    0
	O = corner F,G,H,I,WIDTH,0
	P = corner K,J,H,I,WIDTH,HEIGHT
	Q = corner K,J,M,L,0,    HEIGHT

	gps = new GPS N,O,P,Q,WIDTH,HEIGHT

	# show 'A',A
	# show 'B',B
	# show 'C',C
	# show 'D',D
	# show 'E',E
	# show 'F',F
	# show 'G',G
	# show 'H',H
	# show 'I',I
	# show 'J',J
	# show 'K',K
	# show 'L',L
	# show 'M',M
	# show 'N',N
	# show 'O',O
	# show 'P',P
	# show 'Q',Q

calcx = (x,y,a,b) ->
	lon = map x, a.x,b.x, a.lon,b.lon
	lat = map x, a.x,b.x, a.lat,b.lat  
	{lat,lon,x,y} 	

calcy = (x,y,a,b) ->
	lon = map y, a.y,b.y, a.lon,b.lon
	lat = map y, a.y,b.y, a.lat,b.lat  
	{lat,lon,x,y} 	

bmp2gps = (mx,my) ->
	q1 = calcx mx,0,N,O
	q2 = calcx mx,HEIGHT,Q,P
	q = calcy mx,my,q1,q2
	[myround(q.lat,6),myround(q.lon,6)]

check_bmp2gps = (p,error) ->
	[lat,lon] = bmp2gps p.x,p.y 
	assert error, [myround(100000*(lat-p.lat),6), myround(50000*(lon-p.lon),6)]

locationUpdate = (p) ->
	#messages = []
	lat = p.coords.latitude
	lon = p.coords.longitude
	#print 'locationupdate',lat,lon
	position = {lat,lon} 
	track.push position
	if track.length > TRACKED then track.shift()

locationUpdateFail = (error) ->	if error.code == error.PERMISSION_DENIED then messages = ['Check location permissions']

setup = ->
	createCanvas windowWidth,windowHeight

	x = width/2
	y = height/2
	x1 = 100
	x2 = width-100
	y1 = 100
	y2 = height-100

	buttons.push new Button 'X',x1,y1
	buttons.push new Button 'up',x,y1, -> cy -= height/2/SCALE
	buttons.push new Button 'Y',x2,y1
	buttons.push new Button 'left',x1,y, -> cx -= width/2/SCALE
	buttons.push new Button 'C',x,y, ->
		{lat,lon} = position
		{x,y} = gps.gps2bmp lat,lon
		cx = x #- width/SCALE/2 
		cy = y #- height/SCALE/2 
	buttons.push new Button 'right',x2,y, -> cx += width/2/SCALE
	buttons.push new Button 'down',x,y2, -> cy += height/2/SCALE
	buttons.push new Button '-',x1,y2, -> SCALE /= 1.2
	buttons.push new Button '+',x2,y2, -> SCALE *= 1.2

	[cx,cy]=[WIDTH/2,HEIGHT/2] # A
	#[sx,sy]=[5000,0] # B
	#[sx,sy]=[3500,8000] # C
	#[sx,sy]=[0,4000] # D
	#[sx,sy]=[3000,8000] # E
	#[sx,sy]=[3500,6000] # krknök
	#[sx,sy]=[3500,5000] # trevägsskylt

	textSize 50

	makeCorners()

	# check_gps2bmp P1, [5,6]
	# check_gps2bmp P2, [23,37]
	# check_gps2bmp P3, [0,0]
	# check_gps2bmp P4, [-5,7]

	check_bmp2gps P1,[2.4,-1.2]
	check_bmp2gps P2,[14.9, -7.35]
	check_bmp2gps P3,[0.2,0]
	check_bmp2gps P4,[2.3,2.75]

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	lat = 59.280348
	lon = 18.155122
	position = {lat,lon}
	track.push position	

drawGpsCircles = ->
	w = width
	h = height
	push()
	translate w/2, h/2
	scale SCALE
	for p,i in track
		{lat,lon} = p		
		{x,y} = gps.gps2bmp lat,lon
		circle x-cx, y-cy, 5*(track.length-i)
	pop()

draw = ->
	bg 0
	image img, 0,0, width,height, cx-width/SCALE/2, cy-height/SCALE/2, width/SCALE, height/SCALE
	fc()
	sw 2
	sc 1,1,0 # YELLOW
	drawGpsCircles()
	sw 1
	sc 1,1,0,0.5
	buttons[0].prompt = int cx
	buttons[2].prompt = int cy
	for button in buttons
		button.draw()

	fc 1
	text message,100,100

mouseReleased = -> # to make Android work
	released = true
	false

mousePressed = ->
	if not released then return # to make Android work
	released = false
	for button in buttons
		if button.radius > dist mouseX,mouseY,button.x,button.y then button.click()
