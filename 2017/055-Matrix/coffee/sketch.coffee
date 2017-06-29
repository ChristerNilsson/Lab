# https://github.com/shiffman/Neural-Network-p5
# https://docs.scipy.org/doc/numpy-dev/user/quickstart.html

expand = (lst) ->
	n = 1
	for a in lst
		n *= a
	big = []
	lst = lst.slice().reverse()
	for index in range n
		small = []
		for a in lst
			small.unshift index % a
			index = index // a
		big.push small
	big

class Matrix # any D
	constructor : (@data) -> @shape = [@data.length]
	reshape : (@shape) -> @
	map : (f) -> new Matrix((f x for x in @data)).reshape @shape

	broadcast : (other,f) ->
		n = 1
		target = [] # the combined shape
		a = @shape
		b = other.shape
		antal = Math.max a.length,b.length
		for i in range antal
			ai = if i >= a.length then 1 else a[i]
			bi = if i >= b.length then 1 else b[i]
			target.push Math.max ai, bi
			n *= _.last target
		data = []
		for indices in expand target
			data.push f @index(indices), other.index(indices)
		new Matrix(data).reshape target

	fixData : (other) ->
		if other instanceof Matrix then return other
		new Matrix [other]

	matrix : (shape=@shape.slice(), data=@data) ->
		if shape.length==1 then return data
		arg = shape.pop()
		@matrix shape, (data[i...i+arg] for i in range 0,data.length,arg)

	index : (indices) ->
		res = 0
		for arg,i in indices
			si = if i >= @shape.length then 1 else @shape[i]
			res = res * si + if si==1 then 0 else arg
		res
	cell : ->	@data[@index Array.prototype.slice.call(arguments)]

	add : (other) -> # any D
		other = @fixData other
		@broadcast other, (i,j) => @data[i] + other.data[j]

	sub : (other) -> # any D
		other = @fixData other
		@broadcast other, (i,j) => @data[i] - other.data[j]

	mul : (other) -> # any D
		other = @fixData other
		@broadcast other, (i,j) => @data[i] * other.data[j]

	toArray : -> @data
	copy    : -> new Matrix(@data).reshape @shape
	randint : (n=10) -> Math.floor n * Math.random()

	transpose : -> # 2D only
		data = []
		for i in range @shape[1]
			for j in range @shape[0]
				data.push @cell j,i
		new Matrix(data).reshape [@shape[1],@shape[0]]

	dot : (other) -> # 2D only
		sum = (i,j) => (@cell(i,k) * other.cell(k,j) for k in range @shape[1]).reduce ((a, b) -> a + b), 0
		new Matrix(_.flatten((sum(j,i) for i in range @shape[0] for j in range other.shape[1]))).reshape [@shape[0], other.shape[1]]

