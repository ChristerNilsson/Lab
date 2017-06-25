# https://github.com/shiffman/Neural-Network-p5
# https://docs.scipy.org/doc/numpy-dev/user/quickstart.html

class Matrix
	constructor : (@data, @shape=[@data.length]) ->
	reshape : (@shape) -> # check n
	iterate : (f) -> new Matrix (f i for i in range @data.length), @shape

	map : (f) -> @iterate (i) => f @data[i]
	fixData : (other) -> if other instanceof Matrix then other.data else [other]

	matrix : (shape=@shape.slice(), data=@data) ->
		if shape.length==1 then return data
		arg = shape.pop()
		@matrix shape, (data[i...i+arg] for i in range 0,@data.length,arg)

	cell : ->
		index = 0
		for arg,i in arguments
			index = index * @shape[i] + arg
		@data[index]

	add : (other) ->
		data = @fixData other
		@iterate (i) => @data[i] + data[i % data.length]

	sub : (other) ->
		data = @fixData other
		@iterate (i) => @data[i] - data[i % data.length]

	mul : (other) ->
		data = @fixData other
		@iterate (i) => @data[i] * data[i % data.length]

	toArray   : -> @data
	copy      : -> @iterate (i) => @data[i]
	randint : (n=10) -> @iterate (i) -> Math.floor n * Math.random()

	transpose : ->
		matrix = @iterate (index) => @cell index % @shape[0], Math.floor index/@shape[0]
		matrix.reshape [@shape[1],@shape[0]]
		matrix

	# dot : (other) ->
	# 	sum = (i,j) =>
	# 		s = 0
	# 		for k in range @shape[1]
	# 			s += @cell(i,k) * other.cell(k,j)
	# 		s
	# 	new Matrix _.flatten((sum(i,j) for i in range @shape[0] for j in range other.shape[1])), [@shape[0], other.shape[1]]

	dot : (other) ->
		sum = (i,j) => (@cell(i,k) * other.cell(k,j) for k in range @shape[1]).reduce ((a, b) -> a + b), 0
		new Matrix _.flatten((sum(i,j) for i in range @shape[0] for j in range other.shape[1])), [@shape[0], other.shape[1]]

a = new Matrix [1,2,3,4,5,6],[2,3]
assert a.matrix(), [[1,2,3],[4,5,6]]

a = new Matrix [1,2,3,4],[2,2]
assert a.matrix(), [[1,2],[3,4]]

a = new Matrix [0,0,0,0]
assert a.shape, [4]
a.reshape [2,2]
assert a.shape, [2,2]

assert a.data, [0,0,0,0]
assert a.matrix(), [[0,0],[0,0]]

a = new Matrix [1,2,3,4]
b = new Matrix [5,6,7,8]
assert a.cell(0), 1
assert a.cell(1), 2
assert a.cell(2), 3
assert a.cell(3), 4
a.reshape [2,2]
b.reshape [2,2]
assert a.cell(0,0), 1
assert a.cell(0,1), 2
assert a.cell(1,0), 3
assert a.cell(1,1), 4

c = a.add(b)
assert c.matrix(), [[6,8],[10,12]]
b = a.add(new Matrix [2,3])
assert b.matrix(), [[3,5],[5,7]]

assert a.add(10).matrix(), [[11,12],[13,14]]

assert b.sub(a).matrix(), [[2,3],[2,3]]
assert a.mul(b).matrix(), [[3,10],[15,28]]

assert a.add(2).matrix(), [[3,4],[5,6]]
assert a.sub(2).matrix(), [[-1,0],[1,2]]
assert a.mul(2).matrix(), [[2,4],[6,8]]

assert a.data, [1,2,3,4]
assert a.copy().matrix(), [[1,2],[3,4]]
assert a.transpose().data, [1,3,2,4]

assert a.dot(b).matrix(), [[13,29],[19,43]]

c = a.map (x) -> x*x
assert [[1,4],[9,16]], c.matrix()

d = new Matrix [1,2,3,4,5,6], [2,3] # i,j

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
assert g.cell(0,0,0), 0
assert g.cell(1,2,3), 23

h = new Matrix range(15),[3,5]
assert h.matrix(), [[0,1,2,3,4],[5,6,7,8,9],[10,11,12,13,14]]