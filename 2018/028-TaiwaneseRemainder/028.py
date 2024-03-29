def chinese_remainder(n, a):
	sum = 0
	prod = reduce(lambda a, b: a * b, n)
	for n_i, a_i in zip(n, a):
		p = prod / n_i
		sum += a_i * mul_inv(p, n_i) * p
	return sum % prod

def mul_inv(a, b):
	#if a%b < 0 : return a%b+b else: return a%b

	print 'mul_inv',a,b
	b0 = b
	x0, x1 = 0, 1
	if b == 1:
		print '  result',1
		return 1
	while a > 1:
		print '  while',a,b,x0,x1
		q = a / b
		a, b = b, a % b
		x0, x1 = x1 - q * x0, x0
	print '  while', a, b, x0, x1
	if x1 < 0: x1 += b0
	print '  result',x1
	return x1

#assert 23 == chinese_remainder([3, 5, 7], [2, 3, 2])
#assert 29 == chinese_remainder([2,3,5], [1,2,4])
# print chinese_remainder([3,13,17], [0,2,13])
# print chinese_remainder([2,11,13,19], [0,6,4,8])
# print chinese_remainder([3,5,13,19], [1,4,0,17])
# print chinese_remainder([2,5,11,13], [0,2,9,9])
#
# print chinese_remainder([3,13,17,19], [1,10,1,15])

#print chinese_remainder([2,11,13,19], [1,4,8,11])
#print chinese_remainder([3,11,13,17], [2,9,2,0])
print chinese_remainder([2,3,5,7], [0,1,2,3])
#print chinese_remainder([2,5,17,19], [1,1,15,18])
#print chinese_remainder([3,5,11,19], [2,3,10,3])
#print chinese_remainder([2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73], [1,0,2,3,2,11,1,6,14,11,20,30,34,17,19,6,18,38,12,45,34])
#print chinese_remainder([71,73], [45,34])
#print chinese_remainder([2,3,5,13,17,19], [0,2,0,1,0,18])


	#assert 1000 == chinese_remainder([11, 12, 13], [10,4,12])

#assert 937307771161836294247413550632295202816 == chinese_remainder([17353461355013928499, 3882485124428619605195281, 13563122655762143587], [7631415079307304117, 1248561880341424820456626, 2756437267211517231])
#Wolfram Language:
#ChineseRemainder[{7631415079307304117, 1248561880341424820456626, 2756437267211517231}, {17353461355013928499, 3882485124428619605195281, 13563122655762143587}]