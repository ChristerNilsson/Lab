# De tre punkterna utgörs av h,m och s

hh=0
mm=0
ss=0

setup = ->
	createCanvas windowWidth,windowHeight
	fc()
	hh = hour()
	mm = minute()
	ss = second()

draw = ->
	r = 100
	translate width/2,height/2
	scale _.min([width,height])/200
	fc()
	bg 0.5
	a = radians 30 * (hh+millis()/60/60/1000) - 90
	b = radians  6 * (mm+millis()/60/1000) - 90
	c = radians  6 * (ss+millis()/1000) - 90
	p0 = [0.60*r*cos(a),0.60*r*sin(a)]
	p1 = [0.88*r*cos(b),0.88*r*sin(b)]
	p2 = [0.93*r*cos(c),0.93*r*sin(c)]
	circle 0,0, 0.95*r
	bezier p0[0],p0[1], 0,0, 0,0, p1[0],p1[1]
	bezier p1[0],p1[1], 0,0, 0,0, p2[0],p2[1]