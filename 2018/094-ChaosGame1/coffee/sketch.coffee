points = []
[x,y] = [0,0]

setup = ->
	createCanvas windowWidth, windowHeight
	for i in range 3
		points.push [random(width),random(height)]

draw = ->
	for i in range 100
		point x, y
		[px,py] = _.sample points
		[x,y] = [lerp(x, px, 0.5), lerp(y, py, 0.5)]