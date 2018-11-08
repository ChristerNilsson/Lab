import time

# def cut_rod(v, n2):
# 	n1 = len(v)
# 	c = v + [0] * (n2 - n1)
# 	parts = []
# 	for i in range(n2):
# 		max_c = c[i]
# 		indexes = [i]
# 		for j in range(i):
# 			k = i - j - 1
# 			temp = c[j] + c[k]
# 			if temp > max_c:
# 				max_c = temp
# 				indexes = [k, j]
# 		c[i] = max_c
# 		part = [0] * n1
# 		if i<n1:
# 			for index in indexes:
# 				part[index] += 1
# 		else:
# 			for m in range(n1):
# 				for index in indexes:
# 					part[m] += parts[index][m]
# 		parts.append(part)
# 	return c, parts

# Normal Dynamic Programming
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

# Constant Time Rod Cutting
def g(prices, n):
	if n==1: return prices[0]
	q,clen = max([[price/(i+1),i+1] for i,price in enumerate(prices)])
	add = [f(prices,i) % prices[clen-1] for i in range(clen, clen+clen)]
	a = prices[clen-1]
	return a * (n//clen) + add[n%clen]

prices = [1,5,8,9]
n = 1000
#print(g(prices,n))

start = time.clock()
flist = [f(prices,i) for i in range(1,n)]
print(time.clock()-start)

start = time.clock()
glist = [g(prices,i) for i in range(1,n)]
print(time.clock()-start)

assert flist==glist
print(glist)


# assert f([1,5,8,9],1) == 1
# assert f([1,5,8,9],2) == 5
# assert f([1,5,8,9],3) == 8
# assert f([1,5,8,9],4) == 10
# assert f([1,5,8,9],5) == 13
# assert f([1,5,8,9],6) == 16
# assert f([1,5,8,9],7) == 18
# assert f([1,5,8,9],8) == 21
# assert f([1,5,8,9],9) == 24
# assert f([1,5,8,9],10) == 26
#assert f([1,5,8,9],10000) == 26666

# n = 10000
# print('Prices:',prices)
# lst,parts = cut_rod(prices, n)
# for i in range(n): #[0,1,2,3,4,5,6,7,8,9,995,996,997,998,999]:
# 	print('Rod with size',i+1,'is cut',parts[i],'and valued',lst[i])

