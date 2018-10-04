make2DArray = (rows, cols) ->
	arr = new Array rows 
	for i in range arr.length
		arr[i] = new Array cols
	arr

w = 120
angle = null
cols = null
rows = null
curves = null

setup = () ->
	createCanvas windowWidth, windowHeight
	angleMode DEGREES
	cols = width // w 
	rows = height // w 
	curves = make2DArray rows,cols
	reset()

reset = ->
	angle = 0
	for j in range rows
		for i in range cols
			curves[j][i] = new Curve()

draw = () ->
	bg 0
	r = 0.4 * w

	noFill()
	for j in range rows
		for i in range cols
			cy = (j+0.5) * w
			cx = (i+0.5) * w

			if i==0 and j==0
			else if i==0 or j==0
				sw 1
				circle cx, cy, r
				k = if i==0 then j else i
				y = cy + r * sin angle * k - 90 
				x = cx + r * cos angle * k - 90 
				if j==0 then line x, 0, x, height
				if i==0 then line 0, y, width, y
				sw 8
				point x, y
			else
				sw 1
				stroke 255, 50
				y = cy + r * sin angle * j - 90 
				x = cx + r * cos angle * i - 90 
				curves[j][i].addPoint x, y
				curves[j][i].show()

	if angle == 360 then reset() else angle++
	