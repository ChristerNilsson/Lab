import copy
from fractions import Fraction

def argmax(a,k):
	col = [abs(row[k]) for row in a]
	return col.index(max(col))

def gauss(a, b):
	n, p = len(a), len(a[0])
	for i in range(n):
		t = abs(a[i][i])
		k = i
		for j in range(i + 1, n):
			if abs(a[j][i]) > t:
				t = abs(a[j][i])
				k = j
		if k != i:
			a[i], a[k] = a[k], a[i]
			b[i], b[k] = b[k], b[i]
		t = 1 / a[i][i]
		for j in range(i + 1, n):
			a[i][j] *= t
		b[i] *= t
		for j in range(i + 1, n):
			t = a[j][i]
			for k in range(i + 1, n):
				a[j][k] -= t * a[i][k]
			b[j] -= t * b[i]
	for i in range(n - 1, -1, -1):
		for j in range(i):
			b[j] -= a[j][i] * b[i]
	return b

def network(n,k0,k1,s):
	I = Fraction(1, 1)
	v = [0*I] * n
	a = [copy.copy(v) for i in range(n)]
	arr = s.split('|')
	for resistor in arr:
		n1,n2,r = resistor.split(' ')
		n1 = int(n1)
		n2 = int(n2)
		r = Fraction(1,int(r))
		a[n1][n1] += r
		a[n2][n2] += r
		if n1>0: a[n1][n2] += -r
		if n2>0: a[n2][n1] += -r
	a[k0][k0] = I
	b = [0*I] * n
	b[k1] = I
	return gauss(a,b)[k1]

assert 10             == network(7,0,1,"0 2 6|2 3 4|3 4 10|4 5 2|5 6 8|6 1 4|3 5 6|3 6 6|3 1 8|2 1 8")
assert 3/2            == network(3*3,0,3*3-1,"0 1 1|1 2 1|3 4 1|4 5 1|6 7 1|7 8 1|0 3 1|3 6 1|1 4 1|4 7 1|2 5 1|5 8 1")
assert Fraction(13,7) == network(4*4,0,4*4-1,"0 1 1|1 2 1|2 3 1|4 5 1|5 6 1|6 7 1|8 9 1|9 10 1|10 11 1|12 13 1|13 14 1|14 15 1|0 4 1|4 8 1|8 12 1|1 5 1|5 9 1|9 13 1|2 6 1|6 10 1|10 14 1|3 7 1|7 11 1|11 15 1")
assert 180            == network(4,0,3,"0 1 150|0 2 50|1 3 300|2 3 250")
