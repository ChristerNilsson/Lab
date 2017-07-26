# De tre punkterna utgörs av h,m och s

hh=0
mm=0
ss=0

setup = ->
	createCanvas 400,400
	fc()
	hh = hour()
	mm = minute()
	ss = second()

draw = ->
	bg 0.5
	r = 190
	x = 200
	y = 200
	a = radians 30 * (hh+millis()/60/60/1000) - 90
	b = radians  6 * (mm+millis()/60/1000) - 90
	c = radians  6 * (ss+millis()/1000) - 90
	p0 = [x+0.6*r*cos(a),y+0.6*r*sin(a)]
	p1 = [x+0.95*r*cos(b),y+0.95*r*sin(b)]
	p2 = [x+r*cos(c),y+r*sin(c)]
	#circle 200,200,5
	circle 200,200,195
	bezier p0[0],p0[1], x,y, x,y, p1[0],p1[1]
	bezier p1[0],p1[1], x,y, x,y, p2[0],p2[1]