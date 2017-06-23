# https://github.com/shiffman/Neural-Network-p5

class Matrix
	constructor : (@rows, @cols) -> @matrix = (0 for j in range @cols for i in range @rows)

	iterate : (f) ->
		result = new Matrix @cols, @rows
		result.matrix = (f i,j for j in range @cols for i in range @rows)
		result

	map : (f) -> @iterate (i,j) => f @matrix[i][j]

	add : (other) ->
		if other instanceof Matrix
			@iterate (i,j) => @matrix[i][j] + other.matrix[i][j]
		else
			@iterate (i,j) => @matrix[i][j] + other

	sub : (other) ->
		if other instanceof Matrix
			@iterate (i,j) => @matrix[i][j] - other.matrix[i][j]
		else
			@iterate (i,j) => @matrix[i][j] - other

	mul : (other) ->
		if other instanceof Matrix
			@iterate (i,j) => @matrix[i][j] * other.matrix[i][j]
		else
			@iterate (i,j) => @matrix[i][j] * other

	toArray   : -> _.flatten @matrix
	copy      : -> @iterate (i,j) => @matrix[i][j]
	transpose : -> @iterate (i,j) => @matrix[j][i]
	randint : (n=10) -> @iterate (i,j) -> Math.floor n * Math.random()

	dot : (other) ->
		@iterate (i,j) =>
			sum = 0
			for k in range @cols
				sum += @matrix[i][k] * other.matrix[k][j]
			sum

a = new Matrix 2,2
b = new Matrix 2,2

assert a.matrix, [[0,0],[0,0]]

a.matrix = [[1,2],[3,4]]
b.matrix = [[5,6],[7,8]]

assert a.add(b).matrix, [[6,8],[10,12]]
assert b.sub(a).matrix, [[4,4],[4,4]]
assert a.mul(b).matrix, [[5,12],[21,32]]

assert a.add(2).matrix, [[3,4],[5,6]]
assert a.sub(2).matrix, [[-1,0],[1,2]]
assert a.mul(2).matrix, [[2,4],[6,8]]

assert a.toArray(), [1,2,3,4]
assert a.copy().matrix, [[1,2],[3,4]]
assert a.transpose().matrix, [[1,3],[2,4]]
assert a.dot(b).matrix, [[19,22],[43,50]]

c = a.map (x) -> x*x
assert [[1,4],[9,16]], c.matrix

print a.randint 20