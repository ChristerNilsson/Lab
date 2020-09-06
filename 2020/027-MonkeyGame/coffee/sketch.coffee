range = _.range 
rectangles = []
counter = 0
LEVEL = 5
start = 0

setup = ->
	createCanvas 600,600
	textAlign CENTER,CENTER
	skapa()

skapa = ->
	start = frameCount
	counter = 0
	show = true
	while rectangles.length < LEVEL
		i = rectangles.length
		x = 30+random 540
		y = 30+random 540
		rectangle = [x,y,i]
		antal = 0
		for [a,b,c] in rectangles  
			if abs(x-a) < 60 and abs(y-b) < 60  then antal++
		if antal == 0 then rectangles.push [x,y,i]

draw = ->
	background 0
	for rectangle in rectangles
		[x,y,nr] = rectangle
		fill 255
		rect x-30,y-30,60,60
		textSize 50
		fill 0
		if frameCount < start + 60 then text nr,x,y+4
	fill 255
	text counter,30,30

mousePressed = ->
	rectangle = rectangles[0]
	[x,y,i] = rectangle
	#if mouseX < 600 and mouseY < 600 then counter++
	if x-30 < mouseX < x+30 and y-30 < mouseY < y+30
		counter++
		rectangles.shift()
	if rectangles.length==0
		if counter==LEVEL
			LEVEL++
		else
			LEVEL--
			if LEVEL==0 then LEVEL++
		skapa()
