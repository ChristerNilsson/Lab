current=0
fastKey=0
p1 = null
p2 = null
treshold = 0.385

setup = () ->
	#createCanvas 1500,1000 
	createCanvas windowWidth-20, windowHeight-20
	xs = (p.x for p in points)
	ys = (p.y for p in points)

	p1 = {x:min(xs), y:min(ys)} 
	p2 = {x:max(xs), y:max(ys)}

	newpoints = simplify points, treshold	
	print chrono

show = (p) -> 
	xfactor = 1500/(p2.x-p1.x)
	yfactor = 1000/(p2.y-p1.y)
	factor = 0.9 * min xfactor,yfactor
	point factor*(-1.1*p1.x+p.x), factor*(-1.1*p1.y+p.y)

info = (title,x,y,r,g,b,sw) ->
	noStroke()
	fill 255
	text title,x+20,y
	stroke r,g,b
	strokeWeight sw
	point x,y-10

myround = (x,n) -> round(x*10**n) / 10**n

block = ([level,i],r,g,b) ->
	#if i==undefined or level == undefined then return 
	fill r,g,b 
	x = 1100+level*20
	y = 25+1.9*i
	rect x,y,20,1

drawTree = ->
	fill 128
	hash = {}
	hash[0] = [-1,-1]
	hash[4999] = [-1,500]
	for [pi,qi,ri,level],i in chrono
		hash[qi] = [level,i]
		x = 1100+level*20
		y = 25+1.9*i
		rect x,y,20,1
	block hash[0],128,128,128
	block hash[4999],128,128,128

	[pi,qi,ri,level] = chrono[current]
	block hash[pi],255,0,0
	block hash[qi],255,255,0
	block hash[ri],255,0,0

draw = ->
	scale height/1000
	background 0

	drawTree()

	noFill()
	x1 = 75
	textSize 24

	[pi,qi,ri,level] = chrono[current]
	info 'current end points',x1,875, 255,0,0, 12
	show points[pi]
	show points[ri]
	info 'most distant point',x1,925, 255,255,0, 12
	show points[qi]

	push()
	p = points[qi]
	fill 255,255,0
	noStroke()
	xfactor = 1500/(p2.x-p1.x)
	yfactor = 1000/(p2.y-p1.y)
	factor = 0.9 * min xfactor,yfactor	
	text current, 5+factor*(-1.1*p1.x+p.x), -5+factor*(-1.1*p1.y+p.y)	
	pop()

	info 'found points',x1,950, 0,255,0, 7
	show points[0]
	for i in range current+1
		[pi,qi,ri,level] = chrono[i]
		show points[qi]

	info "simplified #{chrono.length} points",x1,975, 0,255,0, 3
	show points[qi] for [pi,qi,ri,level] in chrono

	info "original #{points.length} points",x1,850, 255,255,255, 1
	show p for p in points 

	info 'current line',x1,900, 255,0,0, 1
	[pi,qi,ri,level] = chrono[current]
	show points[i] for i in range pi,ri

	noStroke()
	x2 = 100
	text 'Ramer-Douglas-Peucker',25,40
	text "current: #{current}",x2,650
	text "recursion level: #{chrono[current][3]}",x2,675
	text "distance: #{myround chrono[current][4],2}",x2,700
	text "treshold: #{treshold}",x2,725
	text 'up = fast backward',x2,750
	text 'left = prev    right = next',x2,775
	text 'down = fast forward',x2,800

	if fastKey == DOWN_ARROW then current++
	if fastKey == UP_ARROW then current--
	current = constrain current,0,chrono.length-1

keyPressed = -> 
	if keyCode == RIGHT_ARROW then current++
	if keyCode == LEFT_ARROW then current--
	current = constrain current,0,chrono.length-1
	fastKey = keyCode 

keyReleased = -> fastKey = 0
