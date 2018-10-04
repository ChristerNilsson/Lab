make2DArray = (rows, cols) ->
	arr = new Array rows #like arr[]; but with number of columns hardcoded
	for i in range arr.length
		arr[i] = new Array cols
	return arr

angle = 0
w = 120
cols = null
rows = null
curves = null

setup = () ->
	createCanvas windowWidth, windowHeight
	cols = floor(width / w) - 1
	rows = floor(height / w) - 1
	curves = make2DArray rows,cols

	for j in range rows
		for i in range cols
			curves[j][i] = new Curve()

draw = () ->
	background 0
	d = w - 0.2 * w
	r = d / 2

	noFill()
	stroke 255
	for i in range cols 
		cx = w + i * w + w / 2
		cy = w / 2
		strokeWeight 1
		stroke 255
		circle cx, cy, r
		x = r * cos angle * (i + 1) - HALF_PI
		y = r * sin angle * (i + 1) - HALF_PI
		strokeWeight 8
		stroke 255
		point cx + x, cy + y
		stroke 255, 150
		strokeWeight 1
		line cx + x, 0, cx + x, height

		for j in range rows
			curves[j][i].x = cx + x

	noFill()
	stroke 255
	for j in range rows
		cx = w / 2
		cy = w + j * w + w / 2
		strokeWeight 1
		stroke 255
		circle cx, cy, r
		x = r * cos angle * (j + 1) - HALF_PI
		y = r * sin angle * (j + 1) - HALF_PI
		strokeWeight 8
		stroke 255
		point cx + x, cy + y
		stroke 255, 150
		strokeWeight 1
		line 0, cy + y, width, cy + y

		for i in range cols 
			curves[j][i].y = cy + y

	for j in range rows 
		for i in range cols
			curves[j][i].addPoint()
			curves[j][i].show()

	angle -= 0.01;

	if angle < -TWO_PI
		for j in range rows
			for i in range cols
				curves[j][i].reset()
		# saveFrame("lissajous#####.png");
		angle = 0
	