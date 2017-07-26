# De tre punkterna utgörs av h,m och s

setup = ->
	createCanvas windowWidth,windowHeight
	fc()

draw = ->
	r = 100
	translate width/2,height/2
	scale _.min([width,height])/200
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
	[x0,y0] = [0.60*r*cos(a),0.60*r*sin(a)]
	[x1,y1] = [0.88*r*cos(b),0.88*r*sin(b)]
	[x2,y2] = [0.93*r*cos(c),0.93*r*sin(c)]
	circle 0,0, 0.95*r
	bezier x0,y0, 0,0, 0,0, x1,y1
	bezier x1,y1, 0,0, 0,0, x2,y2