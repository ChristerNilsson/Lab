current=0
fastKey=0
p1 = null
p2 = null
treshold = 0.39

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

draw = ->
	scale height/1000
	background 0
	noFill()

	x1 = 0.05 * 1500
	textSize 32

	[pi,qi,ri,level] = chrono[current]
	info 'current end points',x1,750, 255,0,0, 12
	show points[pi]
	show points[ri]
	info 'most distant point',x1,850, 255,255,0, 12
	show points[qi]

	info 'found points',x1,900, 0,255,0, 7
	show points[0]
	for i in range current+1
		[pi,qi,ri,level] = chrono[i]
		show points[qi]

	info "simplified #{chrono.length} points",x1,950, 0,255,0, 3
	show points[qi] for [pi,qi,ri,level] in chrono

	info "original #{points.length} points",x1,700, 255,255,255, 1
	show p for p in points 

	info 'current line',x1,800, 255,0,0, 1
	[pi,qi,ri,level] = chrono[current]
	show points[i] for i in range pi,ri

	noStroke()
	x2 = 1150
	text 'Ramer-Douglas-Peucker',0.9*x2,100
	text "current: #{current}",x2,600
	text "distance: #{myround chrono[current][4],2}",x2,650
	text "treshold: #{treshold}",x2,700
	text 'up = fast forward',x2,750
	text 'left = prev    right = next',x2,800
	text 'down = fast backward',x2,850
	text "recursion level: #{chrono[current][3]}",x2,900

	if fastKey == DOWN_ARROW then current--
	if fastKey == UP_ARROW then current++
	current = constrain current,0,chrono.length-1

keyPressed = -> 
	if keyCode == RIGHT_ARROW then current++
	if keyCode == LEFT_ARROW then current--
	current = constrain current,0,chrono.length-1
	fastKey = keyCode 

keyReleased = -> fastKey = 0
