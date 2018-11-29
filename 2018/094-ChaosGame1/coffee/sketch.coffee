# Part 1: https://youtu.be/7gNzMtYo9n4

points = []
x = null
y = null

setup = ->
	createCanvas windowWidth, windowHeight
	for i in range 3
		points.push [random(width),random(height)]

	x = random width
	y = random height
	bg 0  
	sc 1

draw = ->
	for i in range 100
		point x, y
		[px,py] = _.sample points
		x = lerp x, px, 0.5
		y = lerp y, py, 0.5
