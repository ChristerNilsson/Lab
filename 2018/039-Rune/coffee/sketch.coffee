# no mouse events works
# rotate relative does not work
# contains does not work

# `
# function inside1(x,y, vs) {
#     // ray-casting algorithm based on
#     // http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html

#     //var x = point[0], y = point[1];

#     var inside = false;
#     for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
#         var xi = vs[i].x, yi = vs[i].y;
#         var xj = vs[j].x, yj = vs[j].y;

#         var intersect = ((yi > y) != (yj > y))
#             && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
#         if (intersect) inside = !inside;
#     }

#     return inside;
# };
# `

inside = (x,y, vs) ->
	res = false
	lst = range vs.length
	lst.unshift lst.pop()
	for j,i in lst
		xi = vs[i].x
		yi = vs[i].y
		xj = vs[j].x
		yj = vs[j].y
		intersect = ((yi > y) != (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
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

halfCircle = (x,y,radius,cr,cg,cb,group) ->
	p = r.polygon x,y,group
	p.fill cr,cg,cb
	p.lineTo -50,0
	p.lineTo -50,radius
	p.lineTo 50,radius
	p.lineTo 50,0
	p

group = r.group 300,300
c = r.circle 0,0,200,group
c.fill 0,255,0

for i in range 4
	x = 200 * Math.cos Rune.radians 90*i
	y = 200 * Math.sin Rune.radians 90*i
	r.circle x,y,50,group
	#halfCircle x,y, 50,255,  0,0,group
	#halfCircle x,y,-50,255,255,0,group

r.on 'update', =>
	{x,y,rotation} = group.state
	group.rotate rotation+0.1,x,y
	# for child,i in group.children
	# 	if i>0
	# 		{x,y,rotation} = child.state
	# 		child.rotate rotation-0.2,x,y

r.el.addEventListener 'mousedown', (mouse) ->	
	for child,i in group.children
		if i>0
			pos = new Rune.Vector 300,300
			{x,y} = child.state
			pos = pos.add new Rune.Vector(x,y).rotate group.state.rotation
			d = dist pos.x,pos.y,mouse.x,mouse.y
			if d<50
				child.fill 0,0,0
			else
				child.fill 255,255,255

r.play()