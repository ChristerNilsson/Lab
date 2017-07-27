# De tre punkterna utgörs av h,m och s

R = 100
R0 = 60
R1 = 88
R2 = 93
R3 = 95

state = 1

setup = ->
	createCanvas windowWidth,windowHeight
	fc()
	mousePressed()

draw = ->
	translate width/2,height/2
	scale _.min([width,height])/R/2
	fc()
	bg 0.5
	d = new Date()
	h = d.getHours()
	m = d.getMinutes()
	s = d.getSeconds()
	ms = d.getMilliseconds()
	a = radians -90 + 30 * (h+m/60+s/3600)
	b = radians -90 +  6 * (m+s/60)
	c = radians -90 +  6 * (s+ms/1000)
	[x0,y0] = [R0*cos(a),R0*sin(a)]
	[x1,y1] = [R1*cos(b),R1*sin(b)]
	[x2,y2] = [R2*cos(c),R2*sin(c)]
	bezier x0,y0, 0,0, 0,0, x1,y1
	bezier x1,y1, 0,0, 0,0, x2,y2
	circle 0,0, R3

mousePressed = ->
	state = 31 - state
	frameRate state