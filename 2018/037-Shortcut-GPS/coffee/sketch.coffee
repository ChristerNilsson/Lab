# file:///C:/Lab/2018/037-GPS-Shortcut/index.html?radius=50&level=3&seed=0.5&nr=1

# translate, rotate och scale visade sig olämpliga här.
# Bl a då det gällde att detektera krock med röda halvcirklar.

RUNNING = 0
READY = 1
DEAD = 2 
state = RUNNING

released = true
system = null

rotation = 0 # degrees
rotation2 = 0 # degrees

xo=null # origo i mitten av skärmen
yo=null

SCALE = null

# inparametrar
params = null
#radius = null # lilla radien i meter

TRACKED = 5

buttons = []
hist = []
position = null # gps position in meters. 
track = [] # positions

a = 8
b = 9
count = 0
steps = 3
start = null
stopp = null
dw = null
dh = null

class System # hanterar GPS konvertering
	constructor : (@lat,@lon,@w,@h) ->
		p0 = LatLon @lat,@lon
		p1 = p0.destinationPoint @h/2, 0
		@lat2 = p1.lat
		p2 = p0.destinationPoint @w/2, 90
		@lon2 = p2.lon
		p3 = p0.destinationPoint @h/2, 180
		@lat1 = p3.lat
		p4 = p0.destinationPoint @w/2, 270
		@lon1 = p4.lon
	toXY : (lat,lon) ->
		x = round SCALE * map lon, @lon1, @lon2, -@w/2, @w/2
		y = round SCALE * map lat, @lat2, @lat1, -@h/2, @h/2 # turned
		{x,y}
	toWGS84 : (x,y) ->
		lon = map x/SCALE, -@w/2, @w/2, @lon1, @lon2
		lat = map y/SCALE, -@h/2, @h/2, @lat1, @lat2
		{lat,lon}

class Text
	constructor : (@txt,@x,@y,@r=0,@g=0,@b=0) ->
	draw : ->
		fc @r,@g,@b
		text @txt,@x,@y
	execute : ->

class Button
	constructor : (@vinkel,@radius,@radius2,@txt,@r=0,@g=0,@b=0) ->
		@active = false
		@setVinkel @vinkel
		@setVinkel2 0

	setVinkel : (vinkel) ->
		@vinkel = vinkel
		@x = xo + @radius * cos @vinkel
		@y = yo + @radius * sin @vinkel

	setVinkel2 : (v2) -> @v2 = v2

	draw : ->
		sc()
		@active = @inCircle()
		if @radius2 > 0			
			if @radius > 0
				if @inZone() and state == RUNNING then state = DEAD
				d = 2 * @radius2
				fc 0.75,0.75,0.75,0.5
				arc @x,@y,d,d,@v2,180+@v2
				fc 1,0,0,0.5
				arc @x,@y,d,d,180+@v2,@v2
			else
				fc 0.75
				circle @x,@y,@radius2
		fc @r,@g,@b

		push()
		translate @x,@y
		if params.zones and @radius>0 then rotate rotation2
		text @txt,0,0
		pop()

		if @active 
			fc 1,1,0,0.5 # yellow
			circle @x,@y,@radius2

	execute : ->
		if @active
			@event()
			if a==b
				state = READY 
				stopp = millis()

	inCircle : -> @radius2 > dist position.x,position.y,@x,@y

	inZone : -> # the red half circle 
		x1 = @x + @radius2 * cos rotation2-90
		y1 = @y + @radius2 * sin rotation2-90
		x2 = @x + @radius2 * cos rotation2+90
		y2 = @y + @radius2 * sin rotation2+90
		dist1 = dist position.x,position.y,x1,y1
		dist2 = dist position.x,position.y,x2,y2
		@inCircle() and dist1 < dist2 

spara = (value) ->
	count++
	hist.push a
	a = value
	buttons[3].txt = steps - count
	buttons[4].txt = a

locationUpdate = (p) ->
	return 
	lat = p.coords.latitude
	lon = p.coords.longitude
	if system == null
		system = new System lat,lon,width,height
	else
		position = system.toXY lat,lon
		track.push position
		if track.length > TRACKED then track.shift()

locationUpdateFail = (error) ->

setup = ->
	createCanvas windowWidth,windowHeight
	#createCanvas 800,800

	[xo,yo] = [width/2,height/2]

	params = {}
	if '?' in window.location.href
		args = getParameters()
		params.nr = args.nr
		params.radius = parseInt args.radius 
		params.level = parseInt args.level
		params.seed = parseFloat args.seed
		params.rotate = args.rotate == 'true' 
		params.zones = args.zones == 'true' 
	else
		params.nr = '1'
		params.radius = 50 # meter 10 20 50 100 200 500
		params.level = 3
		params.seed = 0.5
		params.rotate = true
		params.zones = true

	# calculated params
	params.radius2 = 0.3 * params.radius
	params.speed = if params.rotate then 1/params.radius else 0
	params.cost = params.radius 

	d = new Date()
	params.seed += 31 * d.getMonth() + d.getDate()
	[a,b] = createProblem params.level,params.seed

	SCALE = min(width,height)/params.radius/3

	position = {x:xo, y:yo} 
	track = [position]

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	start = millis()

	angleMode DEGREES
	textAlign CENTER,CENTER
	textSize 50
	labels = "+2 *2 /2".split ' '
	n = labels.length

	for txt,i in labels
		button = new Button i*360/n,SCALE*params.radius,SCALE*params.radius2,txt
		#button.rotates = true
		buttons.push button
	buttons[0].event = -> spara a+2
	buttons[1].event = -> spara a*2
	buttons[2].event = -> if a%2==0 then spara a//2

	buttons.push new Button 0,0,SCALE*params.radius2,steps # undo
	buttons[3].event = ->
		if hist.length > 0
			a = hist.pop()
			buttons[4].txt = a

	ws = 0.4*width
	hs = 0.46*height

	buttons.push new Text a,xo-ws,yo-hs,1,0,0 # a
	buttons.push new Text b,xo+ws,yo-hs,0,1,0 # b
	buttons.push new Text '#'+params.nr,xo-ws,yo+hs
	buttons.push new Text '0',xo,yo+hs # sekunder
	buttons.push new Text '0',xo+ws,yo+hs # count
	buttons.push new Text params.radius + 'm',xo,yo-hs # radius

	state = RUNNING

draw = ->
	position = {x:mouseX, y:mouseY}
	track = [position]
	bg 0.5
	fc()
	sc 0
	sw 1
	circle xo,yo,SCALE*params.radius

	buttons[3].txt = steps-hist.length 
	if state==READY   then buttons[7].txt = round(stopp-start)/1000 + params.cost*count
	if state==RUNNING then buttons[7].txt = round (millis()-start)/1000 + params.cost*count
	buttons[8].txt = count

	for button in buttons
		button.draw()

	fc()
	sc 1,1,0
	sw 1
	for p,i in track
		circle p.x, p.y, 5*(track.length-i)

	rotation = (rotation + params.speed) %% 360
	rotation2 = (rotation2 - params.speed/0.3) %% 360

	for i in range 3
		button = buttons[i]
		button.setVinkel rotation+i*120
		button.setVinkel2 rotation2

	if state == READY 
		fc 0,1,0,0.5
		rect 0,0,width,height
	if state == DEAD
		fc 1,0,0,0.5
		rect 0,0,width,height

createProblem = (level,seed) ->
	n = int Math.pow 2, 4+level/3 # nodes
	a = myrandom 1,n/2
	lst = [a]
	tree = [a]
	lst2 = []
	save = (item) ->
		if item <= n and item not in tree
			lst2.push item
			tree.push item
	for j in range params.level
		lst2 = []
		for item in lst
			save item + 2 
			save item * 2
			if item%2 == 0 then save item / 2
		lst = lst2
	i = myrandom 0,lst.length
	b = lst[i]
	[a,b]

myrandom = (a,b) ->
  x = 10000 * Math.sin params.seed
  x = x - Math.floor(x)
  int a+x*(b-a)

mouseReleased = -> # to make Android work
	released = true
	false

mousePressed = ->
	if not released then return # to make Android work
	released = false
	if state != RUNNING then return
	for button in buttons
		button.execute()
