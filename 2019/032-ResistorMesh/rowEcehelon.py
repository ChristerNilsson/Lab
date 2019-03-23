#argmax = lambda iterable, func: max(iterable, key=func)

def argmax(a,k):
	col = [abs(row[k]) for row in a]
	return col.index(max(col))

def eliminate(a):
	m = len(a)
	n = len(a[0])
	h = 0
	k = 0
	while h < m and k < n:
		i_max = h + argmax(a[h:],k)
		if a[i_max][k] == 0: k += 1
		else:
			a[h],a[i_max] = a[i_max],a[h] # swap
			for i in range(h + 1,m):
				f = a[i][k] / a[h][k]
				a[i][k] = 0
				for j in range(k+1, n): a[i][j] -= a[h][j] * f
			h += 1
			k += 1
	return a

a = []
a.append([1,3,1,9])
a.append([1,1,-1,1])
a.append([3,11,5,35])

assert 2 == argmax(a,0)
assert 2 == argmax(a,1)
assert 2 == argmax(a,2)
assert 2 == argmax(a,3)

b = eliminate(a)
assert [3, 11, 5, 35] == b[0]
assert [0, -2.6666666666666665, -2.6666666666666665, -10.666666666666666] == b[1]
assert [0, 0, 0, 0] == b[2]

