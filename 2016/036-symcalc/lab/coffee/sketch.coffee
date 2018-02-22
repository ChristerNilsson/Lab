xmin=0
xmax=0
ymin=0
ymax=0

xmin0=0
xmax0=0
ymin0=0
ymax0=0

mymouse=0
decimals=0 # för axlarnas lablar

x0=0 # startpunkt för lablar och rutnät
y0=0

delta=0

xgap = 5
ygap = 5

# översätt till pixlar
pixelX = (x) -> map x,xmin,xmax,0,width
pixelY = (y) -> map y,ymax,ymin,0,height
pixelR = (r) -> map r,0,xmax-xmin,0,width 

# utvidga xmin,ymin och xmax,ymax
minmax = (x,y) ->
	xmin = min xmin,x
	xmax = max xmax,x
	ymin = min ymin,y
	ymax = max ymax,y

# utvidga xmin,xmax, ymin,ymax
init_xmin_xmax_ymin_ymax = -> 
	for key,value of data 
		t = key[0]
		if t == 'p' 
			minmax value.x,value.y
		else if t == 'c'
			r = abs value.radius
			minmax value.x-r,value.y-r
			minmax value.x+r,value.y+r
		else if t == 'l'
			minmax value.x1,value.y1
			minmax value.x2,value.y2
		else if t == 't'
			minmax value.x1,value.y1
			minmax value.x2,value.y2
			minmax value.x3,value.y3

	# utvidga xmin,xmax, ymin,ymax med 10%
	# och se se till att rutnätet blir kvadratiskt
	dx = xmax - xmin
	dy = ymax - ymin
	d = 1.1 * max dx,dy
	if d == 0 then d=1
	cx = 0.5 * (xmin + xmax)
	cy = 0.5 * (ymin + ymax)
	d = d/2
	xmin = cx - d
	xmax = cx + d
	ymin = cy - d
	ymax = cy + d

setup = ->
	createCanvas 800,800
	textSize 20
	mymouse = new p5.Vector 0,0
	init_xmin_xmax_ymin_ymax()
	mydraw()

# rita cirkel och label
cirkel = (label,o) -> 
	x = pixelX o.x
	y = pixelY o.y
	r = pixelR o.radius
	strokeWeight 1 
	stroke 255,0,0 
	noFill() 
	ellipse x,y,2*r,2*r
	noStroke()
	fill 255,0,0 
	textAlign LEFT,BOTTOM 
	text label, x, y

# rita triangel och label
triangel = (label,o) -> 
	x1 = pixelX o.x1
	y1 = pixelY o.y1
	x2 = pixelX o.x2
	y2 = pixelY o.y2
	x3 = pixelX o.x3
	y3 = pixelY o.y3
	strokeWeight 2
	stroke 255
	noFill()
	triangle x1,y1,x2,y2,x3,y3
	noStroke()
	fill 255
	textAlign RIGHT,TOP
	text label, (x1+x2+x3)/3, (y1+y2+y3)/3

# rita punkt och label
punkt = (label,o) ->
	x = pixelX o.x
	y = pixelY o.y
	strokeWeight 4
	stroke 0,255,0
	noFill()
	point x,y
	noStroke()
	fill 0,255,0
	textAlign RIGHT,TOP
	text label, x, y

# rita linje och label
linje = (label,o) -> # YELLOW
	x1 = pixelX o.x1
	y1 = pixelY o.y1
	x2 = pixelX o.x2
	y2 = pixelY o.y2
	dx = 10 * (x2-x1)
	dy = 10 * (y2-y1)
	strokeWeight 2 
	stroke 255,255,0 
	line x1-dx, y1-dy, x1+dx, y1+dy
	noStroke()
	fill 255,255,0 
	textAlign RIGHT,BOTTOM 
	text label, (x1+x2)/2, (y1+y2)/2

drawLineX = (x1,y1,x2,y2,thick) ->
	if pixelX(x1) < xgap then return
	if pixelX(x1) > width-xgap then return
	strokeWeight if thick then 3 else 1
	stroke 0 # BLACK
	line pixelX(x1),pixelY(y1)-ygap, pixelX(x2),pixelY(y2)+ygap

drawLineY = (x1,y1,x2,y2,thick) ->
	if pixelY(y1) < ygap then return
	if pixelY(y1) > height-ygap then return
	strokeWeight if thick then 3 else 1
	stroke 0 # BLACK
	line pixelX(x1)+xgap,pixelY(y1), pixelX(x2)-xgap,pixelY(y2)

drawLabel = (label,x,y,alignHor,alignVer) ->
	noStroke()
	fill 0 # BLACK
	textAlign alignHor, alignVer
	text label, x, y  

normalisera = (x) ->
	q = floor Math.log10 x
	[x/10**q, q]

# Visa cirka fem-tio gridlines
calcDelta = (c,d) ->
	[e,q] = normalisera d # 1 <= e < 10, q = ... -2,-1,0,1,2,3 ...
	dekad = 10 ** q
	p = 0.2
	if e >= 1.6 then p = 0.5
	if e >= 4 then p = 1.0
	if e >= 4 then adj = 1 else adj = 0
	delta = p * dekad
	decimals = 1-q-adj
	if decimals < 0 then decimals = 0
	delta * round c/delta

# Beräkna rutnätets startpunkt och rutstorlek
# decide delta and where to print axis and labels.
calcGrid = ->
	x0 = calcDelta (xmin+xmax)/2,xmax-xmin
	while x0 > xmin 
		x0 -= delta
	x0 += delta

	y0 = calcDelta (ymin+ymax)/2,ymax-ymin
	while y0 > ymin 
		y0 -= delta
	y0 += delta

# rita rutnät och axlar
drawGrid = ->
	xgap = 20 + 12*decimals
	ygap = 25 
	for x in _.range x0,xmax,delta # riktiga värden
		thick = -delta/2 < x < delta/2 
		drawLineX x,ymin, x,ymax, thick
		label = x.toFixed decimals
		drawLabel label, pixelX(x),height, CENTER, BOTTOM
		drawLabel label, pixelX(x),0,      CENTER, TOP

	for y in _.range y0,ymax,delta
		thick =  -delta/2 < y < delta/2
		drawLineY xmin,y, xmax,y, thick
		label = y.toFixed decimals
		drawLabel label, 3,      pixelY(y), LEFT, CENTER
		drawLabel label, width-3,pixelY(y), RIGHT, CENTER

drawObjects = ->
	for name,o of data
		if name[0] == 'l' then linje name,o
		if name[0] == 't' then triangel name,o
		if name[0] == 'c' then cirkel name,o
	for name,o of data
		if name[0] == 'p' then punkt name,o

mydraw = ->
	background 128
	calcGrid()
	drawGrid()
	drawObjects()

# zooma in och ut
mouseWheel = (event) ->
	x = map winMouseX,0,width,xmin,xmax
	y = map winMouseY,height,0,ymin,ymax
	factor = 1 + event.delta*0.001
	xmin = x - (x-xmin) * factor
	xmax = x - (x-xmax) * factor
	ymin = y - (y-ymin) * factor
	ymax = y - (y-ymax) * factor
	mydraw()

# memorera musen
mousePressed = (event) ->
	mymouse.set winMouseX, winMouseY
	xmin0 = xmin
	xmax0 = xmax
	ymin0 = ymin
	ymax0 = ymax

# flytta fönstret
mouseDragged = (event) ->
	dx = map mymouse.x - winMouseX,0,width,0,xmax0-xmin0
	dy = map mymouse.y - winMouseY,0,height,0,ymax0-ymin0
	xmin = xmin0 + dx
	xmax = xmax0 + dx
	ymin = ymin0 - dy
	ymax = ymax0 - dy
	mydraw()
