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

# d1 = maximum distance from q to pr
# d2 = maximum line length pq
reduce = (points,d1,d2) ->
	res = []
	res.push points[0] 
	p = points[0]
	q = points[1]
	r = points[2]
	for i in range 1,points.length-1
		if d1 < pDistance(p,q,r) or dist(p.x,p.y,q.x,q.y) > d2 # keep
			res.push q
			p = q
		q = r
		r = points[i+2]			
	res.push _.last points
	res

myround = (x,n) -> round(x*10**n)/10**n

setup = () ->
	createCanvas windowWidth, windowHeight
	#newpoints = reduce points, 0.1185,1000 # 500 points
	#newpoints = reduce points, 0.182,20 # 500 points (slightly better)

	#newpoints = simplify points,0.39,false	# 500 really nice.
	#newpoints = simplify points,0.39,true	# 
	newpoints = simplify points,1	# 333 acceptable

	print newpoints.length
	#newpoints = ({x:myround(p.x,2), y:myround(p.y,2)} for p in newpoints)
	#print JSON.stringify newpoints

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

	translate -2000,-1100
	scale 2.5

	#translate -1900,-900
	#scale 4

	#translate -2300,-1500
	#scale 5

	vx = epiCycles width / 2 + 100, 100, 0, fourierX
	vy = epiCycles 100, height / 2 + 100, HALF_PI, fourierY
	v = createVector vx.x, vy.y
	path.unshift v

	#strokeWeight 1/4
	stroke 255,0,0
	beginShape()
	for p,i in path
		vertex p.x, p.y
		if i%4==0 then stroke 255,0,0 
		if i%4==1 then stroke 255,255,0 
		if i%4==2 then stroke 0,255,0 
		if i%4==3 then stroke 0,0,255 

		rect p.x-1/2,p.y-1/2,1,1
		#point p.x-1/2,p.y-1/2 # seems to be less accurate

	stroke 255
	endShape()

	dt = TWO_PI / fourierY.length
	time += dt

	if time > TWO_PI
		noLoop()
		time = 0
		path = []
		print (new Date()) - start
		start = new Date() 
