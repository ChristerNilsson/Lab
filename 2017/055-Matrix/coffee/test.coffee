test = ->

	assert expand([3],3), [[0],[1],[2]]
	assert expand([1,2],2), [[0,0],[0,1]]
	assert expand([2,3],6), [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2]]

	# 1D

	a = new Matrix [1,2,3,4,5,6]

	b = new Matrix [10]
	assert (a.add b).matrix(), [11,12,13,14,15,16]

	b = new Matrix [10,20,30,40,50,60]
	assert (a.add b).matrix(), [11,22,33,44,55,66]

	# 2D

	a = new Matrix([1,2,3,4,5,6]).reshape [2,3]

	b = new Matrix [10]
	c = a.add b
	assert c.matrix(), [[11,12,13],[14,15,16]],'xxx'

	b = new Matrix([10,20,30]).reshape [1,3]
	assert (a.add b).matrix(), [[11,22,33],[14,25,36]]

	b = new Matrix([10,20]).reshape [2,1]
	assert (a.add b).matrix(), [[11,12,13],[24,25,26]]

	b = new Matrix([1,2,3,4,5,6]).reshape [2,3]
	assert (a.add b).matrix(), [[2,4,6],[8,10,12]]

	# 3D

	a = new Matrix(range 1,25).reshape [2,3,4]

	b = new Matrix [10]
	c = a.add b
	assert c.data, range 11,35
	assert c.shape, [2,3,4]
	assert c.matrix(), [[[11,12,13,14],[15,16,17,18],[19,20,21,22]],[[23,24,25,26],[27,28,29,30],[31,32,33,34]]]

	b = new Matrix([10,20,30,40]).reshape [1,1,4]
	c = a.add b
	assert c.data,[11,22,33,44, 15,26,37,48, 19,30,41,52, 23,34,45,56, 27,38,49,60, 31,42,53,64]
	assert c.shape,[2,3,4]

	b = new Matrix([10,20,30]).reshape [1,3,1]
	c = a.add b
	assert c.data, [11,12,13,14, 25,26,27,28, 39,40,41,42, 23,24,25,26, 37,38,39,40, 51,52,53,54]
	assert c.shape,[2,3,4]

	a = new Matrix(range 24).reshape [2,3,4]
	b = new Matrix(range 12).reshape [1,3,4]
	c = a.add b
	assert c.data, [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34]
	assert c.shape,[2,3,4]

	a = new Matrix(range 24).reshape [2,3,4]
	b = new Matrix([10,20]).reshape [2,1,1]
	c = a.add b
	assert c.data, [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43]
	assert c.shape,[2,3,4]

	a = new Matrix(range 24).reshape [2,3,4]
	b = new Matrix([100,200,300,400,500,600,700,800]).reshape [2,1,4]
	c = a.add b
	assert c.data, [100, 201, 302, 403, 104, 205, 306, 407, 108, 209, 310, 411, 512, 613, 714, 815, 516, 617, 718, 819, 520, 621, 722, 823]
	assert c.shape,[2,3,4]

	a = new Matrix(range 24).reshape [2,3,4]
	b = new Matrix([100,200,300,400,500,600]).reshape [2,3,1]
	c = a.add b
	assert c.data, [100, 101, 102, 103, 204, 205, 206, 207, 308, 309, 310, 311, 412, 413, 414, 415, 516, 517, 518, 519, 620, 621, 622, 623]
	assert c.shape,[2,3,4]

	a = new Matrix(range 24).reshape [2,3,4]
	b = new Matrix(range 24).reshape [2,3,4]
	c = a.add b
	assert c.data, [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46]
	assert c.shape,[2,3,4]

	# ############### asserts ######################

	a = new Matrix([1,2,3,4,5,6]).reshape [2,3]
	assert a.matrix(), [[1,2,3],[4,5,6]]

	a = new Matrix([1,2,3,4]).reshape [2,2]
	assert a.matrix(), [[1,2],[3,4]]

	a = new Matrix [0,0,0,0]
	assert a.shape, [4]
	a.reshape [2,2]
	assert a.shape, [2,2]

	assert a.data, [0,0,0,0]
	assert a.matrix(), [[0,0],[0,0]]

	a = new Matrix [1,2,3,4]
	b = new Matrix [5,6,7,8]
	a.reshape [2,2]
	b.reshape [2,2]
	assert (a.add b).matrix(), [[6,8],[10,12]]
	assert (b.add a).matrix(), [[6,8],[10,12]]

	assert a.add(10).matrix(), [[11,12],[13,14]]

	assert b.sub(a).matrix(), [[4,4],[4,4]]
	assert a.mul(b).matrix(), [[5,12],[21,32]]

	assert a.add(2).matrix(), [[3,4],[5,6]]
	assert a.sub(2).matrix(), [[-1,0],[1,2]]
	assert a.mul(2).matrix(), [[2,4],[6,8]]

	assert a.data, [1,2,3,4]
	assert a.copy().data, [1,2,3,4]
	assert a.shape, [2,2]
	assert a.copy().matrix(), [[1,2],[3,4]]
	assert a.transpose().data, [1,3,2,4]

	assert a.dot(b).matrix(), [[19,22],[43,50]]

	c = a.map (x) -> x*x
	assert [[1,4],[9,16]], c.matrix()

	d = new Matrix([1,2,3,4,5,6]).reshape [2,3] # i,j

	e = d.transpose()
	assert e.data, [1,4,2,5,3,6]
	assert e.shape, [3,2]

	e = d.add 3
	assert e.data,[4,5,6,7,8,9]
	assert e.shape, [2,3]
	assert e.matrix(), [[4,5,6],[7,8,9]]

	e = d.transpose()
	assert e.dot(d).matrix(), [[17,22,27],[22,29,36],[27,36,45]]
	assert d.dot(e).matrix(), [[14,32],[32,77]]

	# 3D
	g = new Matrix range 24
	g.reshape [2,3,4] # i,j,k
	assert g.matrix()[0], [[0,1,2,3],[4,5,6,7],[8,9,10,11]]
	assert g.matrix()[0][0], [0,1,2,3]
	assert g.matrix()[0][0][0], 0
	assert g.cell([0,0,0]), 0
	assert g.cell([1,2,3]), 23

	h = new Matrix(range(15)).reshape [3,5]
	assert h.matrix(), [[0,1,2,3,4],[5,6,7,8,9],[10,11,12,13,14]]

	# ######################################### from numpy

	a = new Matrix([1,2,3,4,5,6]).reshape [2,3]
	b = new Matrix([1,2,3,4,5,6]).reshape [3,2]

	assert a.shape, [2,3]
	assert b.shape, [3,2]

	assert a.matrix(), [[1,2,3],[4,5,6]]
	assert b.matrix(), [[1,2],[3,4],[5,6]]

	assert a.dot(b).matrix(), [[22,28], [49,64]]
	assert b.dot(a).matrix(), [[ 9,12,15], [19,26,33], [29,40,51]]

	# # ######################

	a = new Matrix([1,2]).reshape [1,2]
	b = new Matrix([1,2]).reshape [2,1]

	assert a.shape, [1,2]
	assert b.shape, [2,1]

	assert a.matrix(),  [[1,2]]
	assert b.matrix(),  [[1], [2]]

	assert a.dot(b).matrix(), [[5]]
	assert b.dot(a).matrix(), [[1,2], [2,4]]

	quad = new Matrix([1,2,3,4]).reshape [2,2]
	assert quad.add(a).matrix(), [[2,4], [4,6]] # ok
	assert quad.add(b).matrix(), [[2,3], [5,6]]

	a = new Matrix [1,2,3,4]
	b = new Matrix [5,6,7,8]
	assert a.cell([0]), 1
	assert a.cell([1]), 2
	assert a.cell([2]), 3
	assert a.cell([3]), 4
	a.reshape [2,2]
	b.reshape [2,2]
	assert a.cell([0,0]), 1
	assert a.cell([0,1]), 2
	assert a.cell([1,0]), 3
	assert a.cell([1,1]), 4

	# mixed

	a = new Matrix([1,2,3]).reshape [1,3]
	b = new Matrix([10,20]).reshape [2,1]
	assert a.add(b).matrix(), [[11,12,13],[21,22,23]]

	print 'Ready!'

test()