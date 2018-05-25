# no mouse events works
# rotate relative does not work
# contains does not work

# `
#   // Code from ContainsPoint function here:
#   // http://polyk.ivank.net
#   contains: function(x, y) {
#     // get stage position
#     var addPos = this.stagepos();

#     // map array of vectors to flat array of xy numbers
#     // This might be slow, so let's rewrite this at some point.

#     var p = Utils.flatten(
#       this.state.vectors.map(function(vector) {
#         return [addPos.x + vector.x, addPos.y + vector.y];
#       }, this)
#     );

#     var n = p.length >> 1;
#     var ax,
#       ay = p[2 * n - 3] - y,
#       bx = p[2 * n - 2] - x,
#       by = p[2 * n - 1] - y;

#     var lup;
#     for (var i = 0; i < n; i++) {
#       ax = bx;
#       ay = by;
#       bx = p[2 * i] - x;
#       by = p[2 * i + 1] - y;
#       if (ay == by) continue;
#       lup = by > ay;
#     }

#     var depth = 0;
#     for (var i = 0; i < n; i++) {
#       ax = bx;
#       ay = by;
#       bx = p[2 * i] - x;
#       by = p[2 * i + 1] - y;
#       if (ay < 0 && by < 0) continue; // both "up" or both "down"
#       if (ay > 0 && by > 0) continue; // both "up" or both "down"
#       if (ax < 0 && bx < 0) continue; // both points on the left

#       if (ay == by && Math.min(ax, bx) <= 0) return true;
#       if (ay == by) continue;

#       var lx = ax + (bx - ax) * -ay / (by - ay);
#       if (lx == 0) return true; // point on edge
#       if (lx > 0) depth++;
#       if (ay == 0 && lup && by > ay) depth--; // hit vertex, both up
#       if (ay == 0 && !lup && by < ay) depth--; // hit vertex, both down
#       lup = by > ay;
#     }

#     return (depth & 1) == 1;
#   },
# `

# `
# function inside(v, vs) {
#     // ray-casting algorithm based on
#     // http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html

#     //var x = point[0], y = point[1];

#     var inside = false;
#     for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
#         var xi = vs[i].x, yi = vs[i].y;
#         var xj = vs[j].x, yj = vs[j].y;

#         var intersect = ((yi > v.y) != (yj > v.y))
#             && (v.x < (xj - xi) * (v.y - yi) / (yj - yi) + xi);
#         if (intersect) inside = !inside;
#     }

#     return inside;
# };
# `

inside = (v, vs) ->
	res = false
	lst = range vs.length
	lst.unshift lst.pop()
	for j,i in lst
		xi = vs[i].x
		yi = vs[i].y
		xj = vs[j].x
		yj = vs[j].y
		intersect = ((yi > v.y) != (yj > v.y)) and (v.x < (xj - xi) * (v.y - yi) / (yj - yi) + xi)
		if intersect then res = !res
	res

group = null

r = new Rune
	container: "body"
	width: 600
	height: 600

dist = (x1,y1,x2,y2) ->
	dx = x1-x2
	dy = y1-y2
	Math.sqrt(dx*dx+dy*dy)

# halfCircle = (x,y,radius,cr,cg,cb,group) ->
# 	p = r.polygon x,y,group
# 	p.fill cr,cg,cb
# 	p.lineTo -50,0
# 	p.lineTo -50,radius
# 	p.lineTo 50,radius
# 	p.lineTo 50,0
# 	p

halfCircle = (x0,y0,radius,cr,cg,cb,group) ->
	p = r.polygon x0,y0,group
	p.fill cr,cg,cb
	for v in range 0,190,10
		x = radius*Math.cos Rune.radians v
		y = radius*Math.sin Rune.radians v
		p.lineTo x,y
	p

group = r.group 300,300
c = r.circle 0,0,200,group
c.fill 0,255,0

for i in range 4
	x = 200 * Math.cos Rune.radians 90*i
	y = 200 * Math.sin Rune.radians 90*i
	halfCircle x,y,-50,255,255,0,group
	halfCircle x,y,+50,255,  0,0,group

r.on 'update', =>
	{x,y,rotation} = group.state
	group.rotate rotation+0.1,x,y
	for child,i in group.children
		if i>0
			{x,y,rotation} = child.state
			child.rotate rotation+0.1,x,y

r.el.addEventListener 'mousemove', (mouse) ->	
	m = new Rune.Vector mouse.x,mouse.y
	p1 = new Rune.Vector 300,300
	for child,i in group.children
		if i>0
			{x,y} = child.state
			p2 = p1.add new Rune.Vector(x,y).rotate group.state.rotation
			p3 = m.sub p2
			p4 = p3.rotate -group.state.rotation-child.state.rotation
			child.fill if inside p4, child.state.vectors then 0 else 255

r.play()