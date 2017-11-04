# extra: hantera flera turtles med olika färger.
# inför en klass. Varje turtle håller reda på sin path och färg

A = 30
D = 20
x = 300
y = 300
a = 0
path = [[x,y,a]]

move = (d) ->
	x += d * cos radians a
	y += d * sin radians a
	path.push [x,y,a]

turn = (da) -> a += da

setup = ->
	createCanvas 600,600
	keyPressed()

keyPressed = ->
	if keyCode == UP_ARROW then move D
	if keyCode == DOWN_ARROW then move -D
	if keyCode == LEFT_ARROW then turn -A
	if keyCode == RIGHT_ARROW then turn A
	if key=='Z' and path.length > 1 then [x,y,a] = path.pop()

	bg 1
	x0 = 300
	y0 = 300
	for [x,y,v] in path
		line x0,y0,x,y
		x0 = x
		y0 = y

	translate x,y
	rotate radians a
	circle 0,0,10
	line 0,0,10,0