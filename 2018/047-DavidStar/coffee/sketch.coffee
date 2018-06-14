turtles = []
i = 0
N = 3 # 3,4,5,6
DIST = 0

class Turtle
	constructor : (@x,@y,@r=1,@g=1,@b=1,@dir=0) ->
	fd : ->
		sc @r,@g,@b
		dx = cos @dir
		dy = sin @dir
		line @x,@y,@x+dx,@y+dy
		[@x,@y] = [@x+dx,@y+dy]

setup = ->
	createCanvas 700,700
	angleMode DEGREES
	sw 20
	bg 0

	v = 360/N

	for i in range N
		x = 300 * cos v * i
		y = 300 * sin v * i
		if i==0 then [dx,dy] = [x,y]
		if i==1 then [dx,dy] = [dx-x,dy-y]
		turtles.push new Turtle x,y,1,0,0,v*(i+0.5+0.25*N)
		x = 300 * cos v * (i+0.5)
		y = 300 * sin v * (i+0.5)
		turtles.push new Turtle x,y,0,1,0,v*(i+1+0.25*N)
	DIST = sqrt dx*dx+dy*dy

draw = ->
	i++
	if i < DIST
		translate width/2,height/2
		for t in turtles
			t.fd()