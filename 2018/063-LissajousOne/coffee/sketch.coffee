r = 300
dangleX = 0
dangleY = 0

setup = ->
	createCanvas 2*r, 2*r
	angleMode DEGREES

makePoint = (angle) ->
	dangleY += (mouseY-r)/100000
	dangleX += (mouseX-r)/100000
	x = r + r * cos 3 * angle + dangleX 
	y = r + r * sin 5 * angle + dangleY  
	[x,y]

draw = ->
	bg 0

	noFill()
	stroke 255

	beginShape()
	for angle in range 360
		[x,y] = makePoint angle
		vertex x, y
		if angle % 10 == 0 
			sw if angle==0 then 8 else 4
			point x,y

	[x,y] = makePoint 360
	vertex x, y
	sw 1
	endShape()
