testVector = ->
	a = new Vector 10,20
	assert 10,a.x
	assert 20,a.y
	a = a.rotate 90
	assert -20.000000000000004,a.x
	assert 9.999999999999995,a.y
	b = new Vector 10,10
	assert 45, b.rotation
	assert 14.142135623730951,b.length
	c = b.add b
	assert 20,c.x
	assert 20,c.y
	c = c.sub b
	assert 10,c.x
	assert 10,c.y

testCircle = ->
	c = new Circle 100,200,50
	assert 100,c.x
	assert 200,c.y
	assert 50,c.radius
	assert [100.00000000000001, 200, 0], c.stagepos()
	assert true,c.contains new Vector 110,210
	assert true,c.contains new Vector 129,239
	assert false,c.contains new Vector 131,241

testRect = ->
	r = p6.rect 100,200,10,20
	assert -5,r.points[0].x
	assert -10,r.points[0].y
	assert 5,r.points[1].x
	assert -10,r.points[1].y
	assert 5,r.points[2].x
	assert 10,r.points[2].y
	assert -5,r.points[3].x
	assert 10,r.points[3].y
	assert true,r.inside new Vector 1,1
	assert true,r.inside new Vector 5,10
	assert false,r.inside new Vector 6,10
	assert false,r.inside new Vector 5,11
	assert [100.00000000000001, 200, 0], r.stagepos()
	assert true, r.contains new Vector 100+4,200+4
	assert true, r.contains new Vector 100-4,200-4
	assert true, r.contains new Vector 100-4,200+4
	assert true, r.contains new Vector 100+4,200-4

	r = p6.rect 100,200,10,10
	r.rotation = 45
	print r
	assert true, r.contains new Vector 100+3,200+3
	assert false, r.contains new Vector 100+4,200+4
	assert true, r.contains new Vector 100+7,200+0
	assert false, r.contains new Vector 100+8,200+0
	# assert true, r.contains new Vector 100-4,200-4
	# assert true, r.contains new Vector 100-4,200+4
	# assert true, r.contains new Vector 100+4,200-4

#	assert true,r.contains new Vector 1,1
	# d2 = new Vector 140,230
	# assert true,r.contains d1.sub d2
	# d2 = new Vector 141,231
	# assert false,r.contains d1.sub d2

test = ->
	testVector()
	testCircle()
	testRect()
