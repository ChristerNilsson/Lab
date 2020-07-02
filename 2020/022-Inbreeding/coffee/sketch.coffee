# http://www.husdyr.kvl.dk/htm/kc/popgen/genetics/4/5.htm

facit = [
	[0, 0,   0,    0,   0,    0,     0,     0]
	[0, 1,   1/2,  1/2, 1/2,  1/2,   1/2,   1/2]
	[0, 1/2, 1,    1/4, 1/4,  5/8,   1/4,   7/16]
	[0, 1/2, 1/4,  1,   1/4,  5/8,   5/8,   5/8]
	[0, 1/2, 1/4,  1/4, 1,    1/4,   5/8,   7/16]
	[0, 1/2, 5/8,  5/8, 1/4,  1+1/8, 7/16,  25/32]
	[0, 1/2, 1/4,  5/8, 5/8,  7/16,  1+1/8, 25/32]
	[0, 1/2, 7/16, 5/8, 7/16, 25/32, 25/32, 1+7/32]
]

parents = []

person = (sire=0,dame=0) => parents.push {sire,dame}

person() # not used
person() # oldest, index=1
person 1 # sire=1 dame=unknown
person 1
person 1
person 3,2
person 3,4
person 5,6

N = parents.length

matrix = (0 for i in range N for j in range N)

for i in range 1,N
	matrix[i][i] = 1
	p = parents[i]
	matrix[i][i] += matrix[p.sire][p.dame]/2
	for j in range i+1,N
		p = parents[j]
		matrix[i][j] = matrix[j][i] = (matrix[i][p.sire] + matrix[i][p.dame])/2

for i in range 1,N
	for j in range 1,N
		assert matrix[i][j], facit[i][j]

calc = (a,b) => matrix[a][b]

assert 1/4,  calc 3,2
assert 1/4,  calc 3,4
assert 7/16, calc 5,6
