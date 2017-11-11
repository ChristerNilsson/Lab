x=y=-99
level = 0
diameter = 20

setup = ->
	createCanvas 201,201
	newGame 0

grid = ->
	sc 1
	sw 1
	for i in range 0,201,20
		line i,0,i,200
		line 0,i,200,i

newPoint = (r) ->
	radius = r
	x = random 201
	y = random 201
	x = int(x/r)*r
	y = int(y/r)*r

newGame = (dlevel) ->
	bg 0
	textAlign CENTER,CENTER
	textSize 150
	if dlevel>= 0 then fc 0,0.5,0
	if dlevel==-1 then fc 1,0.5,0
	level += dlevel
	sc()
	text level,100,100
	grid()
	
	sw 2
	sc 1,1,0
	fc()
	circle x,y,diameter/2
	sw 1
	point x,y

	sc 1,0,0
	sw 2
	point mouseX,mouseY

	newPoint 20
	if level > 10 then newPoint 10
	if level > 20 then newPoint 5
	if level > 30 then newPoint 2
	if level > 40 then newPoint 1

	textSize 12
	textAlign CENTER,CENTER
	fc 1,1,0
	sc()
	text 'x',90,150
	text x,110,150
	text 'y',90,170
	text y,110,170

mousePressed = -> 
	if 5 > dist x,y,mouseX,mouseY
		newGame 1
	else if level>0
		newGame -1
	else newGame 0
