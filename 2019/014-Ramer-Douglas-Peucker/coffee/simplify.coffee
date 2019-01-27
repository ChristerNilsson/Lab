# (c) 2017, Vladimir Agafonkin
# Simplify.js, a high-performance JS polyline simplification library
# mourner.github.io/simplify-js

chrono = [] # points found in chronological order

# square distance from a point to a segment
getDist = (p, p1, p2) -> # this function is called 52819 times
	{x,y} = p1
	[dx,dy] = [p2.x - x, p2.y - y]
	if dx != 0 or dy != 0
		t = ((p.x - x) * dx + (p.y - y) * dy) / (dx * dx + dy * dy)
		if t > 1 then {x,y} = p2
		else if t < 0 then {x,y} = p1
		else [x,y] = [x+dx*t, y+dy*t]
	[dx,dy] = [p.x - x, p.y - y]
	dx * dx + dy * dy
p1 = {x:0,y:0}
p2 = {x:20,y:15}
assert 100, getDist {x:0,y:-10},p1,p2 
assert 256, getDist {x:20,y:-5},p1,p2 
assert 100, getDist {x:20,y:25},p1,p2 

simplify = (points, tolerance=1) ->
	step = (first, last, level=0) ->
		if last-first <= 1 then return 
		dmax = tolerance * tolerance
		for i in range first + 1, last # find most distant point and keep it.
			d = getDist points[i], points[first], points[last]
			if d > dmax then [index,dmax] = [i,d]
		if dmax > tolerance * tolerance
			chrono.push [first,index,last,level,sqrt dmax]
			step first, index, level+1
			res.push points[index]
			step index, last, level+1
	res = [points[0]]
	step 0, points.length-1
	res.push _.last points
	res
