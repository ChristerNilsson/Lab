MAX_DIAMETER = _.min [innerWidth,innerHeight]
MAX_RADIUS = MAX_DIAMETER * 0.5
INNER_RADIUS = 100
LINE_WIDTH = 2
RADIUS_STEP = 6
MIN_ARC_ANGLE = 18
MAX_ARC_ANGLE = 36
PALETTE = '#2D0F0E #CE0010 #65223D #D14E34 #EEAA40 #7E8A65 #4C3C49 #972448 #E69651 #EEDDA8'.split ' '

rnd = (x) -> Math.random() * x

circles = []

setup = ->
	createCanvas MAX_DIAMETER,MAX_DIAMETER
	createCircles()
	fc()
	sw LINE_WIDTH

draw = ->
	background PALETTE[0]
	translate width/2, height/2
	for [points,offset,speed],j in circles
		r = INNER_RADIUS + j * RADIUS_STEP
		for i in range points.length-1
			stroke PALETTE[i%10]
			start = offset+points[i]
			stopp = offset+points[i+1]
			arc 0,0, 2*r,2*r, start,stopp
		circles[j][1] += speed

createCircles = ->
	for i in range 100
		circles.push [createArcs(),	radians(rnd 360), radians(-0.5 + rnd 1)]

createArcs = ->
	points = [0]
	d = 0
	while d < 324
		step = MIN_ARC_ANGLE + rnd MAX_ARC_ANGLE - MIN_ARC_ANGLE
		d += step
		points.push radians d
	points.push radians 360
	points