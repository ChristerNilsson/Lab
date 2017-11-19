x=y=100
tx=ty=0
level = 0
diameter = 20
SCALE = 4

setup = ->
	c = createCanvas 201*SCALE-2,201*SCALE-2
	c.parent 'canvas'
	newPoint 20
	newGame 0

grid = ->
	sc 1
	sw 0.5
	for i in range 0,201,20
		line i,0,i,200
		line 0,i,200,i

newPoint = (d) ->
	diameter = d
	x = random 201
	y = random 201
	x = d * round x/d
	y = d * round y/d

newGame = (dlevel) ->
	bg 0
	scale SCALE
	textAlign CENTER,CENTER
	textSize 150
	if dlevel >=  0 then fc 0,0.5,0
	if dlevel == -1 then fc 1,0.5,0
	level += dlevel
	if level < 0 then level = 0
	sc()
	text level,100.5,100.5
	grid()
	
	newPoint 20
	if level >= 10 then newPoint 10
	if level >= 20 then newPoint 8
	if level >= 30 then newPoint 6
	if level >= 40 then newPoint 4
	if level >= 50 then newPoint 3
	if level >= 60 then newPoint 2

	sw 1
	sc 1,1,0
	fc()
	circle x,y,diameter/2
	sw 2
	point x,y

	sc 1,0,0
	sw 2
	point tx*SCALE, ty*SCALE

	textSize 12
	textAlign CENTER,CENTER
	fc 1,1,0
	sc()

	text 't',170,170
	seconds = int millis()/1000
	text seconds,190,190

enter = ->
	if keyCode == 13
		coords.select()
		if ',' in coords.value then arr = coords.value.split ','
		if ' ' in coords.value then arr = coords.value.split ' '
		if arr.length == 2
			tx = parseInt arr[0]
			ty = parseInt arr[1]
			if diameter/2 > dist x,y,tx,ty then newGame 1 else newGame -1