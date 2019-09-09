x = -99
level = 0
diameter = 20
SCALE = 4

setup = ->
	createCanvas 201*SCALE-2,201*SCALE-2
	cursor CROSS
	newGame 0

grid = ->
	sc 1
	sw 0.5
	fc 0
	textSize 8
	for i in range 0,201,20
		rect i,0,20,20
		text i,i,16

newPoint = (d) ->
	diameter = d
	x = random 201
	x = d * round x/d

newGame = (dlevel) ->
	bg 1
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

	textSize 12
	textAlign CENTER,CENTER
	fc 1,1,0
	sc()
	text 'x',170,7
	text x,190,7

mousePressed = -> 
	if abs(x-mouseX/SCALE) < diameter/2 then newGame 1 else newGame -1