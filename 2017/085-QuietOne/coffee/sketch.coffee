# http://scruss.com/blog/2017/08/05/a-quiet-one/

SIDE = 300
HALF = SIDE/2

setup = -> createCanvas 3*SIDE,3*SIDE

draw = ->
	square = (x,y) ->
		push()
		translate x,y
		for i in range 4
			rotate radians 90
			quad x0,y0,x1,y1,x2,y2,x3,y3
		pop()

	bg 1
	sw map mouseX,0,width,1,20

	a = SIDE/(2+sqrt(2)) # Makes angles 90 degrees
	b = SIDE-a

	[x0,y0] = [             -HALF,          -HALF]
	[x1,y1] = [            a-HALF,          -HALF]
	[x2,y2] = [a + a/sqrt(2)-HALF, a/sqrt(2)-HALF]
	[x3,y3] = [             -HALF,         b-HALF]

	translate width/2,height/2
	d = (sqrt(2)-1)*HALF

	square -HALF-d,-HALF+d
	square  HALF-d,-HALF-d
	square  HALF+d, HALF-d
	square -HALF+d, HALF+d