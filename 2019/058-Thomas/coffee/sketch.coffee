x = 100
y = 100
vx = 2
vy = 1.5
R = 100
setup = ->
	createCanvas windowWidth,windowHeight

draw = ->
	bg 0.5
	fc 1,0,0
	sc 1,1,1
	sw 5
	circle x,y,R
	if x+R > width then vx = -vx
	if x-R < 0 then vx = -vx
	if y+R > height 
		vy = -vy
	else
		vy+=1
	#if y-R < 0 then vy = -vy

	x+=vx
	y+=vy
