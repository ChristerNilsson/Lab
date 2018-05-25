halfCircle = (x0,y0,radius,cr,cg,cb,group) ->
	p = r.polygon x0,y0,group
	p.fill cr,cg,cb
	for v in range 0,190,10
		x = radius*Math.cos Rune.radians v
		y = radius*Math.sin Rune.radians v
		p.lineTo x,y
	p

group = null

r = new Rune
	container: "body"
	width: 600
	height: 600

group = r.group 300,300
c = r.circle 0,0,200,group
c.fill 0,255,0

for i in range 4
	x = 200 * Math.cos Rune.radians 90*i
	y = 200 * Math.sin Rune.radians 90*i
	halfCircle x,y,-50,255,255,0,group
	halfCircle x,y,+50,255,  0,0,group

dist = (x1,y1,x2,y2) ->
	dx = x1-x2
	dy = y1-y2
	Math.sqrt(dx*dx+dy*dy)

r.on 'update', =>
	{x,y,rotation} = group.state
	group.rotate rotation+0.1,x,y
	for child,i in group.children
		if i>0
			{x,y,rotation} = child.state
			child.rotate rotation-0.2,x,y

stagepos = (child) -> # returns resulting [pos, rotation]
	lst = []
	current = child
	while current
		lst.unshift current.state
		current = current.parent
	vec = new Rune.Vector 0,0	

	rot = 0
	rotres = 0
	for {x,y,rotation} in lst
		rotres += rotation
		v1 = new Rune.Vector x, y
		v2 = v1.rotate rot
		rot = rotation
		vec = vec.add v2
	[vec,rotres]

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

contains = (child, m) ->
	[p2,rotation] = stagepos child
	p3 = m.sub p2
	p4 = p3.rotate -rotation
	inside p4, child.state.vectors

r.el.addEventListener 'mousemove', (mouse) ->	
	m = new Rune.Vector mouse.x,mouse.y
	for child,i in group.children
		if i > 0 
			child.fill if contains child, m then 0 else 255

r.play()