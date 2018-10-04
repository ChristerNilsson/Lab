make2DArray = (rows, cols) ->
	arr = new Array rows 
	for i in range arr.length
		arr[i] = new Array cols
	arr

angle = 0
w = 120
cols = null
rows = null
curves = null

setup = () ->
	createCanvas windowWidth, windowHeight
	angleMode DEGREES
	cols = floor width / w 
	rows = floor height / w 
	curves = make2DArray rows,cols

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
				y = r * sin angle * k - 90
				x = r * cos angle * k - 90
				if j==0 then line cx + x, 0, cx + x, height
				if i==0 then line 0, cy + y, width, cy + y
				sw 8
				point cx + x, cy + y
			else
				sw 1
				stroke 255, 50
				y = r * sin angle * j - 90
				x = r * cos angle * i - 90
				curves[j][i].addPoint cx + x, cy + y
				curves[j][i].show()

	angle++

	if angle == 360
		for j in range rows
			for i in range cols
				curves[j][i].reset()
		angle = 0
	