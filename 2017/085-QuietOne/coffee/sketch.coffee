# http://scruss.com/blog/2017/08/05/a-quiet-one/

SIDE = 300
HALF = SIDE/2
W = SIDE/20

setup = -> createCanvas 3*SIDE,3*SIDE

draw = ->
	square = (x,y) ->
		translate x,y
		for i in range 4
			rotate radians 90
			quad x0,y0,x1,y1,x2,y2,x3,y3
		translate -x,-y

	bg 1
	sw W

	a = SIDE/(2+sqrt(2)) # Makes angles 90 degrees
	b = SIDE-a

	[x0,y0] = [0,0]
	[x1,y1] = [a,0]
	[x2,y2] = [a + a/sqrt(2), a/sqrt(2)]
	[x3,y3] = [0,b]

	[x0,y0] = [x0-HALF,y0-HALF]
	[x1,y1] = [x1-HALF,y1-HALF]
	[x2,y2] = [x2-HALF,y2-HALF]
	[x3,y3] = [x3-HALF,y3-HALF]

	translate width/2,height/2
	d = (sqrt(2)-1)*HALF

	square -HALF-d,-HALF+d
	square  HALF-d,-HALF-d
	square  HALF+d, HALF-d
	square -HALF+d, HALF+d