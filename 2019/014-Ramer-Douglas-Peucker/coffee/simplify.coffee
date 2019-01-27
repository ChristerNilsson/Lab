# (c) 2017, Vladimir Agafonkin
# Simplify.js, a high-performance JS polyline simplification library
# mourner.github.io/simplify-js

chrono = [] # points found in chronological order

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

simplify = (points, tolerance=1) ->
	simplifyDPStep = (first, last, level=0) ->
		if last-first <= 1 then return 
		maxSqDist = tolerance * tolerance

		# find most distant point and keep it.
		for i in range first + 1, last
			sqDist = getSqSegDist points[i], points[first], points[last]
			if sqDist > maxSqDist
				index = i
				maxSqDist = sqDist

		if maxSqDist > tolerance * tolerance
			chrono.push [first,index,last,level]
			simplifyDPStep first, index, level+1
			simplified.push points[index]
			simplifyDPStep index, last, level+1

	simplified = []
	simplifyDPStep 0, points.length-1
	[points[0]].concat simplified.concat [_.last points]
