x=y=-99
level = 0
diameter = 20
SCALE = 4

setup = ->
	createCanvas 201*SCALE-2,201*SCALE-2
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
	if dlevel>= 0 then fc 0,0.5,0
	if dlevel==-1 then fc 1,0.5,0
	level += dlevel
	if level<0 then level = 0
	sc()
	text level,100.5,100.5
	grid()
	
	sw 1
	sc 1,1,0
	fc()
	circle x,y,diameter/2
	sw 2
	point x,y

	sc 1,0,0
	sw 2
	point mouseX/SCALE, mouseY/SCALE

	newPoint 20
	if level >= 10 then newPoint 10
	if level >= 20 then newPoint 8
	if level >= 30 then newPoint 6
	if level >= 40 then newPoint 4

	textSize 12
	textAlign CENTER,CENTER
	fc 1,1,0
	sc()
	text 'x',170,10
	text x,190,10
	text 'y',10,170
	text y,10,190

	text 't',170,170
	seconds = int millis()/1000
	text seconds,190,190

mousePressed = -> if diameter/2 > dist x,y,mouseX/SCALE,mouseY/SCALE then newGame 1 else newGame -1
