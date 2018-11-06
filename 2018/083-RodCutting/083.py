# https://www.youtube.com/watch?v=ElFrskby_7M
# https://www.youtube.com/watch?v=0y5UkZc-C8Y

def cut_rod(v, n2):
	n1 = len(v)
	v += [0] * (n2 - n1)
	c = [0] * n2
	parts = []
	for i in range(n2):
		max_c = v[i]
		indexes = [i]
		for j in range(i):
			k = i - j - 1
			temp = c[j] + c[k]
			if temp > max_c:
				max_c = temp
				indexes = [k, j]
		c[i] = max_c
		part = [0] * n1
		if i<n1:
			for index in indexes:
				part[index] += 1
		else:
			for m in range(n1):
				for index in indexes:
					part[m] += parts[index][m]
		parts.append(part)
	return c, parts

prices = [1,5,8,9]

n = 10
print('Prices:',prices)
lst,parts = cut_rod(prices, n)
for i in range(n): #[0,1,2,3,4,5,6,7,8,9,995,996,997,998,999]:
	print('Rod with size',i+1,'is cut',parts[i],'and valued',lst[i])
