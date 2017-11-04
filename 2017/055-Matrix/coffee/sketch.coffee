# https://github.com/shiffman/Neural-Network-p5
# https://docs.scipy.org/doc/numpy-dev/user/quickstart.html

expand = (target,n) ->
	big = []
	target = target.slice().reverse()
	for index in range n
		small = []
		for a in target
			small.unshift index % a
			index //= a
		big.push small
	big

class Matrix # any D
	constructor : (@data) -> @shape = [@data.length]
	reshape : (@shape) -> @
	map     : (f) -> new Matrix((f x for x in @data)).reshape @shape
	cell    : (indices) -> @data[@index indices]
	fixData : (other) -> if other instanceof Matrix then other else new Matrix [other]
	toArray : -> @data
	copy    : -> new Matrix(@data).reshape @shape
	randint : (n=10) -> Math.floor n * Math.random()
	add     : (other) -> @broadcast other, (a,b) -> a + b
	sub     : (other) -> @broadcast other, (a,b) -> a - b
	mul     : (other) -> @broadcast other, (a,b) -> a * b

	broadcast : (other,f) ->
		other = @fixData other
		a = @shape
		b = other.shape
		antal = Math.max a.length,b.length
		target = (Math.max a[i]||1, b[i]||1 for i in range antal)
		n = target.reduce ((a,b) -> a * b), 1
		data = (f @cell(indices), other.cell(indices) for indices in expand target,n)
		new Matrix(data).reshape target

	matrix : (shape=@shape.slice(), data=@data) ->
		if shape.length==1 then return data
		arg = shape.pop()
		@matrix shape, (data[i...i+arg] for i in range 0,data.length,arg)

	index : (indices) ->
		res = 0
		for arg,i in indices
			res *= @shape[i]||1
			res += if (@shape[i]||1) == 1 then 0 else arg
		res

	transpose : -> # 2D only
		data = (data||[]).concat (@cell [j,i] for j in range @shape[0]) for i in range @shape[1]
		new Matrix(data).reshape [@shape[1],@shape[0]]

	dot : (other) -> # 2D only
		sum = (i,j) => (@cell([i,k]) * other.cell([k,j]) for k in range @shape[1]).reduce ((a, b) -> a + b), 0
		new Matrix(_.flatten((sum(j,i) for i in range @shape[0] for j in range other.shape[1]))).reshape [@shape[0], other.shape[1]]
