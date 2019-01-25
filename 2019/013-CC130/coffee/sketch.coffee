# Coding Challenge 130: Drawing with Fourier Transform and Epicycles
# Daniel Shiffman
# https://thecodingtrain.com/CodingChallenges/130-fourier-transform-drawing.html
# https://youtu.be/MY4luNgGfms
# https://editor.p5js.org/codingtrain/sketches/ldBlISrsQ

x = []
y = []
fourierX = null
fourierY = null
time = 0
path = []
start = 0

pDistance = (p,q,r) -> # q is the point
	A = q.x - p.x
	B = q.y - p.y
	C = r.x - p.x
	D = r.y - p.y
	dot = A * C + B * D
	len_sq = C * C + D * D
	param = if len_sq == 0 then -1 else dot / len_sq
	if param < 0 then s = p
	else if param > 1 then s = r
	else s = createVector p.x + param * C, p.y + param * D
	dist q.x,q.y,s.x,s.y

simplereduce = (points) -> (p for p,i in points when i%8 == 0)

reduce = (points,d) ->
	res = []
	res.push points[0] 

	p = points[0]
	q = points[1]
	r = points[2]
	for i in range 1,points.length-1
		if d < pDistance p,q,r # keep
			res.push q
			p = q
		q = r
		r = points[i+2]			

	res.push _.last points
	res

myround = (x,n) -> round(x*10**n)/10**n

setup = () ->
	createCanvas 800, 600
	newpoints = reduce points, 0.1
	print newpoints
	newpoints = ({x:myround(p.x,2), y:myround(p.y,2)} for p in newpoints)
	print JSON.stringify newpoints

	x = (p.x for p in newpoints)
	y = (p.y for p in newpoints)
	
	fourierX = dft x
	fourierY = dft y

	fourierX.sort (a, b) => b.amp - a.amp
	fourierY.sort (a, b) => b.amp - a.amp

	start = new Date()

epiCycles = (x, y, rotation, fourier) ->
	for {freq,amp,phase} in fourier
		x += amp * cos freq * time + phase + rotation
		y += amp * sin freq * time + phase + rotation
	createVector x, y

draw = ->
	background 0
	noFill()
	stroke 255

	vx = epiCycles width / 2 + 100, 100, 0, fourierX
	vy = epiCycles 100, height / 2 + 100, HALF_PI, fourierY
	v = createVector vx.x, vy.y
	path.unshift v

	strokeWeight 2
	beginShape()
	for p in path
		vertex p.x, p.y
		#point p.x,p.y
	strokeWeight 1		
	endShape()

	dt = TWO_PI / fourierY.length
	time += dt

	if time > TWO_PI
		noLoop()
		time = 0
		path = []
		print (new Date()) - start
		start = new Date() 
