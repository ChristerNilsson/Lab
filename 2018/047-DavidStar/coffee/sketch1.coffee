turtles = []
i = 0
N = 3
DIST = 0

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
		turtles.push [x,y,v*(i+0.5+0.25*N)]
		x = 300 * cos v * (i+0.5)
		y = 300 * sin v * (i+0.5)
		turtles.push [x,y,v*(i+1+0.25*N)]
	DIST = sqrt dx*dx+dy*dy

draw = ->
	i++
	if i < DIST
		translate width/2,height/2
		for [x,y,dir],j in turtles
			if j%2==0 then sc 1,0,0 else sc 0,1,0
			point x+i*cos(dir),y+i*sin(dir)