# De tre punkterna utgörs av h,m och s

R = 100
R0 = 60
R1 = 88
R2 = 93
R3 = 95

state = 1

bezier2 = (x0,y0,x1,y1,x2,y2) ->
	x3 = lerp(x0,x1,2/3)
	y3 = lerp(y0,y1,2/3)
	x4 = lerp(x2,x1,2/3)
	y4 = lerp(y2,y1,2/3)
	bezier x0,y0,x3,y3,x4,y4,x2,y2

setup = ->
	createCanvas windowWidth,windowHeight
	fc()
	mousePressed()

draw = ->
	translate width/2,height/2
	scale _.min([width,height])/R/2
	fc()
	d = new Date()
	s = d.getSeconds() + d.getMilliseconds()/1000
	m = d.getMinutes() + s/60
	h = d.getHours()   + m/60
	a = radians 30 * h - 90
	b = radians  6 * m - 90
	c = radians  6 * s - 90
	[x0,y0] = [R0*cos(a),R0*sin(a)]
	[x1,y1] = [R1*cos(b),R1*sin(b)]
	[x2,y2] = [R2*cos(c),R2*sin(c)]
	bg 0.5
	#bezier x0,y0, 0,0, 0,0, x1,y1
	#bezier x1,y1, 0,0, 0,0, x2,y2
	bezier2 x0,y0, 0,0, x1,y1
	bezier2 x1,y1, 0,0, x2,y2
	circle 0,0,R3

mousePressed = ->
	state = 31 - state
	frameRate state