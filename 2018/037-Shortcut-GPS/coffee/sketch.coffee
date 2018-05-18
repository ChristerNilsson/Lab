# file:///C:/Lab/2018/037-GPS-Shortcut/index.html?radius=50&level=3&seed=0.5&nr=1

# translate, rotate och scale visade sig olämpliga här.
# Bl a då det gällde att detektera krock med röda halvcirklar.

RUNNING = 0
READY = 1
DEAD = 2 
state = RUNNING

released = true
system = null

rotation1 = 0 # degrees
rotation2 = 0 # degrees

[xo,yo] = [null,null] # origo i mitten av skärmen

SCALE = null
params = null
TRACKED = 5 # circles shows the player's position

buttons = []
hist = []
position = null # gps position
track = [] # positions

[a,b] = [null,null]
count = 0
[start,stopp] = [null,null]

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
		x = xo + SCALE * map lon, @lon1, @lon2, -@w/2, @w/2
		y = yo + SCALE * map lat, @lat2, @lat1, -@h/2, @h/2 # turned
		#x = SCALE * map lon, @lon1, @lon2, 0, @w
		#y = SCALE * map lat, @lat2, @lat1, 0, @h # turned
		{x,y}
	# toWGS84 : (x,y) ->
	# 	lon = map (x-xo)/SCALE, -@w/2, @w/2, @lon1, @lon2
	# 	lat = map (y-yo)/SCALE, -@h/2, @h/2, @lat1, @lat2
	# 	#lon = map x/SCALE, 0, @w, @lon1, @lon2
	# 	#lat = map y/SCALE, 0, @h, @lat1, @lat2
	# 	{lat,lon}

class Text
	constructor : (@txt,@x,@y,@r=0,@g=0,@b=0) ->
	draw : ->
		fc @r,@g,@b
		text @txt,@x,@y
	execute : ->

class Button
	constructor : (@vinkel1,@radius1,@radius2,@txt,@r=0,@g=0,@b=0) ->
		@active = false
		@setVinkel1 @vinkel1
		@setVinkel2 0

	setVinkel1 : (v1) ->
		@vinkel1 = v1
		@x = xo + @radius1 * cos @vinkel1
		@y = yo + @radius1 * sin @vinkel1

	setVinkel2 : (v2) -> @v2 = v2

	draw : ->
		sc()
		@active = @inCircle()
		if @radius2 > 0			
			if @radius1 > 0
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
		if params.speed2>0 and @radius1>0 then rotate rotation2
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
	buttons[3].txt = params.level - count
	buttons[4].txt = a

locationUpdate = (p) ->
	lat = p.coords.latitude
	lon = p.coords.longitude
	if system == null then system = new System lat,lon,width,height
	position = system.toXY lat,lon
	#position.x += xo
	#position.y += yo
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
		params.nr = if args.nr? then args.nr
		params.level = if args.level? then parseInt args.level
		params.seed = if args.seed? then parseFloat args.seed
		params.radius1 = if args.radius1? then parseInt args.radius1 
		params.radius2 = if args.radius2? then parseInt args.radius2 
		params.speed1 = if args.speed1? then parseFloat args.speed1 
		params.speed2 = if args.speed2? then parseFloat args.speed2 
		params.cost = if args.cost? then parseInt args.cost 
		print params

	if not params.nr? then params.nr = '0'
	if not params.level? then params.level = 3 
	if not params.seed? then params.seed = 0.0
	if not params.radius1? then params.radius1 = 300
	if not params.radius2? then params.radius2 = 0.3 * params.radius1
	if not params.speed1? then params.speed1 = 0.5/params.radius1
	if not params.speed2? then params.speed2 = 0.5/params.radius2
	if not params.cost? then params.cost = params.radius1
	print params 

	d = new Date()
	params.seed += 31 * d.getMonth() + d.getDate()
	[a,b] = createProblem params.level,params.seed

	SCALE = min(width,height)/params.radius1/3

	position = {x:xo, y:yo}
	track = [position]

	start = millis()

	angleMode DEGREES
	textAlign CENTER,CENTER
	textSize 50
	labels = "+2 *2 /2".split ' '
	n = labels.length

	for txt,i in labels
		button = new Button i*360/n,SCALE*params.radius1,SCALE*params.radius2,txt
		buttons.push button
	buttons[0].event = -> spara a+2
	buttons[1].event = -> spara a*2
	buttons[2].event = -> if a%2==0 then spara a//2

	buttons.push new Button 0,0,SCALE*params.radius2,params.level # undo
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
	buttons.push new Text params.radius1 + 'm',xo,yo-hs # radius1

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: true
		maximumAge: 30000
		timeout: 27000

	state = RUNNING

draw = ->
	bg 0.5
	fc()
	sc 0
	sw 1
	circle xo,yo,SCALE*params.radius1

	buttons[3].txt = params.level - hist.length 
	if state==READY   then buttons[7].txt = round(stopp-start)/1000 + params.cost*count
	if state==RUNNING then buttons[7].txt = round (millis()-start)/1000 + params.cost*count
	buttons[8].txt = count

	for button in buttons
		button.draw()

	rotation1 = (rotation1 + params.speed1) %% 360
	rotation2 = (rotation2 - params.speed2/0.3) %% 360

	for i in range 3
		button = buttons[i]
		button.setVinkel1 rotation1+i*120
		button.setVinkel2 rotation2

	if state == READY 
		fc 0,1,0,0.5
		rect 0,0,width,height
	if state == DEAD
		fc 1,0,0,0.5
		rect 0,0,width,height

	fc()
	sc 0
	sw 2
	for p,i in track
		circle p.x, p.y, 5*(track.length-i)

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
