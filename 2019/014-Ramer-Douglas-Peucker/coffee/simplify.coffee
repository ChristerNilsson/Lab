# (c) 2017, Vladimir Agafonkin
# Simplify.js, a high-performance JS polyline simplification library
# mourner.github.io/simplify-js

chrono = [] # points found in chronological order

# square distance from a point to a segment
getSqSegDist = (p, p1, p2) ->
	{x,y} = p1
	[dx,dy] = [p2.x - x, p2.y - y]
	if dx != 0 or dy != 0
		t = ((p.x - x) * dx + (p.y - y) * dy) / (dx * dx + dy * dy)
		if t > 1 then {x,y} = p2
		else if t > 0 then [x,y] = [x+dx*t, y+dy*t]
	[dx,dy] = [p.x - x, p.y - y]
	dx * dx + dy * dy

simplify = (points, tolerance=1) ->
	simplifyDPStep = (first, last, level=0) ->
		if last-first <= 1 then return 
		maxSqDist = tolerance * tolerance

		# find most distant point and keep it.
		for i in range first + 1, last
			sqDist = getSqSegDist points[i], points[first], points[last]
			if sqDist > maxSqDist then [index,maxSqDist] = [i,sqDist]

		if maxSqDist > tolerance * tolerance
			chrono.push [first,index,last,level]
			simplifyDPStep first, index, level+1
			simplified.push points[index]
			simplifyDPStep index, last, level+1

	simplified = []
	simplifyDPStep 0, points.length-1
	[points[0]].concat simplified.concat [_.last points]
