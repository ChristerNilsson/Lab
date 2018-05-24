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
rotation = 0.1
hc = null

r = new Rune
	container: "body"
	width: 600
	height: 600

halfCircle = (x,y,radius,cr,cg,cb,group) ->
	p = r.polygon x,y,group
	p.fill cr,cg,cb
	for i in range 19
		v = Rune.radians i*10
		p.lineTo radius*Math.cos(v),radius*Math.sin(v)
	p

#doit = ->
group = r.group 300,300
c = r.circle 0,0,200,group
c.fill 0,255,0
for i in range 3
	x = 200 * Math.cos Rune.radians i*120
	y = 200 * Math.sin Rune.radians i*120
	hc = halfCircle x, y,  100, 255,255,0, group
	halfCircle x, y, -100, 255, 0, 0, group
print hc

#for i in range -100,110,10
#	print i,inside i,10,hc.state.vectors 


r.on 'update', =>
	x0 = group.state.x
	y0 = group.state.y
	group.rotate rotation,x0,y0
	for child,i in group.children
		if i>0
			{x,y} = child.state
			#if i==1 then print child.state
			if i==1 then print child.state
			child.rotate rotation,x,y
			#if inside 510-x0-x,310-y0-y,child.state.vectors 
			#	child.fill 0,0,0
			#else
				#child.fill 255,255,255

	rotation += 0.1

r.on 'mousemove', (mouse) =>
	console.log 'mousemove' # happens not

r.on 'draw', =>
	console.log 'draw' # happens not

#doit()

r.play()