# (c) 2017, Vladimir Agafonkin
# Simplify.js, a high-performance JS polyline simplification library
# mourner.github.io/simplify-js

# square distance between 2 points
getSqDist = (p1, p2) ->
	dx = p1.x - p2.x
	dy = p1.y - p2.y
	dx * dx + dy * dy

# square distance from a point to a segment
getSqSegDist = (p, p1, p2) ->

	x = p1.x
	y = p1.y
	dx = p2.x - x
	dy = p2.y - y

	if dx != 0 || dy != 0

		t = ((p.x - x) * dx + (p.y - y) * dy) / (dx * dx + dy * dy)

		if t > 1
			x = p2.x
			y = p2.y
		else if t > 0
			x += dx * t
			y += dy * t

	dx = p.x - x
	dy = p.y - y

	dx * dx + dy * dy

# rest of the code doesn't care about point format
# basic distance-based simplification
simplifyRadialDist = (points, sqTolerance) ->

	prevPoint = points[0]
	newPoints = [prevPoint]

	for point in points
		if getSqDist(point, prevPoint) > sqTolerance
			newPoints.push point
			prevPoint = point

	if prevPoint != point then newPoints.push point
	newPoints

simplifyDPStep = (points, first, last, sqTolerance, simplified) ->
	maxSqDist = sqTolerance
	index = null

	# find most distant point and keep it.
	for i in range first + 1, last, 1
		sqDist = getSqSegDist points[i], points[first], points[last]
		if sqDist > maxSqDist
			index = i
			maxSqDist = sqDist

	if maxSqDist > sqTolerance
		print index,sqrt(maxSqDist),points[index]
		if index - first > 1 then simplifyDPStep points, first, index, sqTolerance, simplified
		simplified.push points[index]
		if last - index > 1 then simplifyDPStep points, index, last, sqTolerance, simplified

# simplification using Ramer-Douglas-Peucker algorithm
simplifyDouglasPeucker = (points, sqTolerance) ->
	last = points.length - 1
	simplified = [points[0]]
	simplifyDPStep points, 0, last, sqTolerance, simplified
	simplified.push points[last]
	simplified

# both algorithms combined for awesome performance
simplify = (points, tolerance=1, highestQuality=false) ->
	if points.length <= 2 then return points
	sqTolerance = tolerance * tolerance
	if highestQuality then points = simplifyRadialDist points, sqTolerance
	res = simplifyDouglasPeucker points, sqTolerance
	print res
	res 
