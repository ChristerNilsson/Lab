current=0
fastKey=0

setup = () ->
	createCanvas windowWidth-20, windowHeight-20
	newpoints = simplify points,0.39	
	textSize 30

show = (p) -> point 2.5*(300+p.x),2.5*(200+p.y)

info = (title,x,y,r,g,b,sw) ->
	noStroke()
	fill 255
	text title,x+20,y
	stroke r,g,b
	strokeWeight sw
	point x,y-10

draw = ->
	background 0
	noFill()

	[pi,qi,ri,level] = chrono[current]
	info 'current end points',300,800,255,0,0,10
	show points[pi]
	show points[ri]
	info 'most distant point',300,900,255,255,0,10
	show points[qi]

	info 'found points',300,950,0,255,0,7
	for i in range current
		[pi,qi,ri,level] = chrono[i]
		show points[qi]

	info "simplified #{chrono.length} points",300,1000,0,255,0,3
	show points[qi] for [pi,qi,ri,level] in chrono

	info "original #{points.length} points",300,750,255,255,255,1
	show p for p in points 

	info 'current line',300,850,255,0,0,1
	[pi,qi,ri,level] = chrono[current]
	show points[i] for i in range pi,ri

	noStroke()
	text 'Ramer-Douglas-Peucker',50,100	
	text "#{current} current",1400-7,700	
	text 'Up = Fast Forward',1400,800
	text 'Left = Prev',1300,850
	text 'Right = Next',1500,850
	text 'Down = Fast Backward',1400,900
	text "#{chrono[current][3]} recursion level",1400-7,1000

	if fastKey == DOWN_ARROW then current--
	if fastKey == UP_ARROW then current++
	current = constrain current,0,chrono.length-1

keyPressed = -> 
	if keyCode == RIGHT_ARROW then current++
	if keyCode == LEFT_ARROW then current--
	current = constrain current,0,chrono.length-1
	fastKey = keyCode 

keyReleased = -> fastKey = 0
