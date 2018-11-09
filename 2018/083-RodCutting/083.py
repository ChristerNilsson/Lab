import time


# Quadratic + value
def f(v, n):
	c = v + [0] * n
	for i in range(n):
		max_c = c[i]
		for j in range((i+1)//2):
			k = i - j - 1
			temp = c[j] + c[k]
			if temp > max_c:
				max_c = temp
		c[i] = max_c
	return c[n-1]


prices = [1,5,8,9]
assert f(prices,1) == 1
assert f(prices,2) == 5
assert f(prices,3) == 8
assert f(prices,4) == 10
assert f(prices,5) == 13
assert f(prices,6) == 16
assert f(prices,7) == 18
assert f(prices,8) == 21
assert f(prices,9) == 24
assert f(prices,10) == 26

prices = [1,6,10,14]
assert f(prices,1) == 1
assert f(prices,2) == 6
assert f(prices,3) == 10
assert f(prices,4) == 14
assert f(prices,5) == 16
assert f(prices,6) == 20
assert f(prices,7) == 24
assert f(prices,8) == 28
assert f(prices,9) == 30
assert f(prices,10) == 34

prices = [5,6,7,10]
assert f(prices,1) == 5
assert f(prices,2) == 10
assert f(prices,3) == 15
assert f(prices,4) == 20
assert f(prices,5) == 25
assert f(prices,6) == 30
assert f(prices,7) == 35
assert f(prices,8) == 40
assert f(prices,9) == 45
assert f(prices,10) == 50

#################################


# Constant + Value
def fc(prices, n):
	if n == 1: return prices[0]
	q, clen = max([[price/(i+1),i+1] for i, price in enumerate(prices)])
	add = [f(prices,i) % prices[clen-1] for i in range(clen, clen+clen)]
	a = prices[clen-1]
	return a * (n//clen) + add[n%clen]

prices = [1,5,8,9]
assert fc(prices,1) == 1
assert fc(prices,2) == 5
assert fc(prices,3) == 8
assert fc(prices,4) == 10
assert fc(prices,5) == 13
assert fc(prices,6) == 16
assert fc(prices,7) == 18
assert fc(prices,8) == 21
assert fc(prices,9) == 24
assert fc(prices,10) == 26

prices = [1,6,10,14]
assert fc(prices,1) == 1
assert fc(prices,2) == 6
assert fc(prices,3) == 10
assert fc(prices,4) == 14
assert fc(prices,5) == 16
assert fc(prices,6) == 20
assert fc(prices,7) == 24
assert fc(prices,8) == 28
assert fc(prices,9) == 30
assert fc(prices,10) == 34

prices = [5,6,7,10]
assert fc(prices,1) == 5
assert fc(prices,2) == 10
assert fc(prices,3) == 15
assert fc(prices,4) == 20
assert fc(prices,5) == 25
assert fc(prices,6) == 30
assert fc(prices,7) == 35
assert fc(prices,8) == 40
assert fc(prices,9) == 45
assert fc(prices,10) == 50

############################################


# Quadratic + Parts
def g(v, n2, clen):
	n1 = len(v)
	c = v + [0] * n2
	parts = []
	for i in range(n2):
		max_c = c[i]
		indexes = [i]
		for j in range(n2):
			k = i - j - 1
			if k >= 0:
				temp = c[j] + c[k]
				if temp > max_c:
					max_c = temp
					indexes = [k, j]
		c[i] = max_c
		part = [0] * n1
		if i < clen:
			for index in indexes:
				part[index] += 1
		else:
			for m in range(n1):
				for index in indexes:
					part[m] += parts[index][m]
		parts.append(part)
	return parts[-1]


prices = [1, 6, 10, 14]  # 1 3 3.33 3.5 clen=4
assert g(prices,1,4) == [1,0,0,0] # 1
assert g(prices,2,4) == [0,1,0,0] # 6
assert g(prices,3,4) == [0,0,1,0] # 10
assert g(prices,4,4) == [0,0,0,1] # 14
assert g(prices,5,4) == [0,1,1,0] # 16
assert g(prices,6,4) == [0,1,0,1] # 20
assert g(prices,7,4) == [0,0,1,1] # 24
assert g(prices,8,4) == [0,0,0,2] # 28
assert g(prices,9,4) == [0,1,1,1] # 30
assert g(prices,10,4)== [0,1,0,2] # 34

prices = [5, 6, 7, 10]  # 5 3 3.5 2.5 clen=1
assert g(prices,1,1) == [1,0,0,0]
assert g(prices,2,1) == [2,0,0,0]
assert g(prices,3,1) == [3,0,0,0]
assert g(prices,4,1) == [4,0,0,0]
assert g(prices,5,1) == [5,0,0,0]
assert g(prices,6,1) == [6,0,0,0]
assert g(prices,7,1) == [7,0,0,0]

prices = [1, 5, 8, 9]  # 1 2.5 2.67 2.25 clen=3
assert g(prices,1,3) == [1,0,0,0] # 1
assert g(prices,2,3) == [0,1,0,0] # 5
assert g(prices,3,3) == [0,0,1,0] # 8
assert g(prices,4,3) == [0,2,0,0] # 10
assert g(prices,5,3) == [0,1,1,0] # 13
assert g(prices,6,3) == [0,0,2,0] # 16
assert g(prices,7,3) == [0,2,1,0] # 18
assert g(prices,8,3) == [0,1,2,0] # 21
assert g(prices,9,3) == [0,0,3,0] # 24
assert g(prices,10,3)== [0,2,2,0] # 26

#####################################


# Constant + Parts
def gc(prices, n):
	q, clen = max([[price/(i+1),i+1] for i, price in enumerate(prices)])
	if n < clen: return g(prices, n, clen)
	part = g(prices,clen + n % clen,clen)
	part[clen-1] += (n-clen)//clen
	return part

prices = [1,5,8,9]  # 1 2.5 2.67 2.25 clen=3
assert gc(prices,1) == [1,0, 0,0]
assert gc(prices,2) == [0,1, 0,0]
assert gc(prices,3) == [0,0, 1,0]
assert gc(prices,4) == [0,2, 0,0]
assert gc(prices,5) == [0,1, 1,0]
assert gc(prices,6) == [0,0, 2,0]
assert gc(prices,7) == [0,2, 1,0]
assert gc(prices,8) == [0,1, 2,0]
assert gc(prices,9) == [0,0, 3,0]
assert gc(prices,10)== [0,2, 2,0]

prices = [1,6,10,14]  # 1 3 3.33 3.5 clen=4
assert gc(prices,1) == [1,0, 0,0]
assert gc(prices,2) == [0,1, 0,0]
assert gc(prices,3) == [0,0, 1,0]
assert gc(prices,4) == [0,0, 0,1]
assert gc(prices,5) == [0,1, 1,0]
assert gc(prices,6) == [0,1, 0,1]
assert gc(prices,7) == [0,0, 1,1]
assert gc(prices,8) == [0,0, 0,2]
assert gc(prices,9) == [0,1, 1,1]
assert gc(prices,10)== [0,1, 0,2]
assert gc(prices,11)== [0,0, 1,2]
assert gc(prices,12)== [0,0, 0,3]

prices = [5,6,7,10]  # 5 3 3.5 2.5 clen=1
assert gc(prices,1) == [1,0,0,0] # 5
assert gc(prices,2) == [2,0,0,0] # 10
assert gc(prices,3) == [3,0,0,0] # 15
assert gc(prices,4) == [4,0,0,0] # 20
assert gc(prices,5) == [5,0,0,0] # 25
assert gc(prices,6) == [6,0,0,0] # 30
assert gc(prices,7) == [7,0,0,0] # 35
assert gc(prices,8) == [8,0,0,0] # 40
assert gc(prices,9) == [9,0,0,0] # 45
assert gc(prices,10)== [10,0,0,0] # 50

prices = [46, 64, 75, 96] # 46 32 25 24 clen=1
assert gc(prices,1) == [1,0,0,0] # 46
assert gc(prices,2) == [2,0,0,0] # 92
assert gc(prices,3) == [3,0,0,0] # ...
assert gc(prices,4) == [4,0,0,0] #
assert gc(prices,5) == [5,0,0,0] #
assert gc(prices,6) == [6,0,0,0] #
assert gc(prices,7) == [7,0,0,0] #
assert gc(prices,8) == [8,0,0,0] #
assert gc(prices,9) == [9,0,0,0] #
assert gc(prices,10)== [10,0,0,0] #


################ performance ####################

mega = 1000000
giga = 1000000000
tera = 1000000000000

start = time.clock()
assert gc([1, 5, 8, 9],   mega) == [0, 2, 333332, 0]
assert gc([1, 6, 10, 14], mega) == [0, 0, 0, 250000]
assert gc([5, 6, 7, 10],  mega) == [1000000, 0, 0, 0]
print(time.clock()-start) # 20 micros

start = time.clock()
assert gc([1, 5, 8, 9],   giga) == [0, 2, 333333332, 0]
assert gc([1, 6, 10, 14], giga) == [0, 0, 0, 250000000]
assert gc([5, 6, 7, 10],  giga) == [1000000000, 0, 0, 0]
print(time.clock()-start) # 20 micros

start = time.clock()
assert gc([1, 5, 8, 9],   tera) == [0, 2, 333333333332, 0]
assert gc([1, 6, 10, 14], tera) == [0, 0, 0, 250000000000]
assert gc([5, 6, 7, 10],  tera) == [1000000000000, 0, 0, 0]
print(time.clock()-start) # 20 micros
