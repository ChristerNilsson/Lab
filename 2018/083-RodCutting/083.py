import random
import time

# Constant Time bygger på att man sätter kostnaderna for storre delar till noll. Kanske inte ok.

def findCycle(prices): # Find best price per unit
	lst = [[price / (i + 1), i + 1] for i, price in enumerate(prices)]
	#print(' '.join(["{:0}:{:.3}".format(index,value) for value,index in lst]))
	q, clen = max(lst)
	print(prices,clen)
	# Offset can be smaller, but hard to find rules for this.
	return [len(prices)*clen,clen] # Offset and cycle length

# Find optimum using dynamic programming
def g(v, n2,show=False):
	start = time.clock()
	antal = 0
	nn = n2*n2//4
	n1 = len(v)
	c = v + [0] * n2
	parts = []
	for i in range(n2):
		max_c = c[i]
		indexes = [i]
		for j in range((i+1) // 2):
			antal += 1
			k = i - j - 1
			temp = c[j] + c[k]
			if temp > max_c:
				max_c = temp
				indexes = [k, j]

		# if show and i%1000==0 and antal>0:
		# 	s = "{:.2f}% of {:.6f} seconds".format(100 * antal / nn, nn / antal * (time.clock() - start))
		# 	sys.stdout.write("\r" + s)

		c[i] = max_c
		part = [0] * n1
		#print(indexes)
		if len(indexes) == 1:
			part[indexes[0]] = 1
		else:
			for m in range(min(i,n1)):
				for index in indexes:
					part[m] += parts[index][m]

		parts.append(part)
		#print(' ' if i+1<10 else '',i+1,part,c[i],c[i]-c[i-1])

	#print(antal,nn)
	#sys.stdout.write("\r")
	#sys.stdout.flush()
	#print()
	return [part,c[0:n1]]


# Find optimal parts using quick method
def gc(prices, n): # n and offset are 1-based
	if n < offset: return g(prices, n)
	part,c = g(prices, offset + (n-offset) % clen)
	part[clen-1] += (n-offset) // clen # add to best paid unit size
	return part,c

#########################

offset = None
clen = None

def solveSlow(prices,n):  return g(prices, n, True)
def solveQuick(prices,n): return gc(prices, n)
def total(parts,prices):  return sum([parts[i] * prices[i] for i in range(len(parts))])

def solve(prices,N):
	global offset, clen
	offset, clen = findCycle(prices)
	#print(offset,clen)
	return solveQuick(prices,N)

def testBench(N):
	#print()
	#print('N',N)
	start = time.clock()
	prices = [8, 40, 40, 162, 191, 244, 261, 264, 265, 337, 348, 353, 445, 497, 506, 582, 852, 887, 913, 927]
	#prices = [1,5,8,9,10,17,17,20]
	#prices=[25, 31, 42, 52, 92, 107, 115, 117, 140, 161, 168, 214, 246, 247, 269, 359, 366, 414, 421, 449, 455, 508, 598, 599, 611, 616, 626, 648, 658, 660, 669, 701, 752, 760, 790, 876, 897, 898, 954, 977]
	#print('Prices',prices)
	count,newPrices = solve(prices,N)
	#print('Prices',prices)
	#print('prices',newPrices)
	#print('RodSize',N)
	#print('Size','Price','Count')
	#for i in range(len(prices)):
	#	print("{0:4}".format(i+1), "{0:5}".format(prices[i]),"{0:5}".format(count[i]))
	#print('Count',count)
	total1 = total(count,prices)
	#print('Total',total1)
	#print('Method A:', "{:6f} secs".format(time.clock() - start))

	#print()
	start = time.clock()
	count,newPrices = solveSlow(prices,N)
	#print('Count',count)
	total2 = total(count,prices)
	#print('Total',total2)
	#print('prices',newPrices)
	#print('Method B:', "{:6f} secs".format(time.clock() - start))

	if total1!=total2:
		print('Diff!',N)


# for N in [1006]: #range(1000,1020):
# 	testBench(N)

########################### TEST #################################

TRACE = False
#TRACE = True

def testa(prices,N=1000):
	#print()
	#print(prices)

	#N = random.randint(1000,1020)
	#print(N)

	global offset, clen
	offset, clen = findCycle(prices)
	#print('offset',offset,'clen',clen)

	part1,newPrices1 = solveSlow(prices,N)
	lstsum1 = total(part1,prices)

	part2,newPrices2 = solveQuick(prices,N)
	lstsum2 = total(part2,prices)

	#print(prices)
	#print('part1',part1)
	#print('part2',part2)
	#print('lstsum',lstsum1,lstsum2)
	#print('newPrices1',newPrices1)
	#print('newPrices2',newPrices2)

	assert lstsum1 == lstsum2
	#assert part1 == part2 # might be different if same value per unit
	assert newPrices1 == newPrices2

#for N in [8,10,100,1000]:
#		testa([1,5,8,9,10,17,17,20],N)

# #
# # GRUPP B
testa([5, 32, 41, 44, 51, 80, 84, 85, 86, 95]) # clen=2
testa([1, 10, 46, 58, 74, 75, 79, 89, 89, 94]) # clen=3
testa([3, 10, 31, 38, 42, 52, 57, 69, 75, 93]) # clen=3
testa([3, 3, 17, 60, 63, 69, 73, 81, 82, 93]) # clen=4
testa([16, 17, 19, 21, 21, 30, 45, 47, 83, 85]) # clen=1
testa([2, 39, 43, 49, 69, 90, 91, 92, 94, 96])  # clen=2
testa([9, 22, 26, 31, 46, 49, 55, 55, 93, 97])  # clen=2
testa([5, 32, 41, 44, 51, 80, 84, 85, 86, 95])  # clen=2
testa([0, 0, 31, 41, 62, 66, 72, 79, 93, 99])   # clen=5
testa([15, 26, 27, 35, 54, 54, 54, 72, 74, 91]) # clen=1
# #
# # GRUPP C
testa([1, 6, 8, 26, 31, 44, 64, 65, 73, 91]) # hopp=2 clen=7
testa([3, 8, 18, 24, 30, 32, 77, 82, 98, 99]) # hopp=2 clen=7
testa([3, 6, 7, 12, 15, 47, 55, 76, 86, 88]) # hoppar 2 clen=9
testa([2, 4, 6, 24, 25, 35, 39, 75, 76, 84])    # hoppar 6 clen=8
testa([1, 3, 15, 17, 19, 28, 64, 71, 78, 84])   # hoppar 3 clen=7
testa([2, 4, 7, 19, 22, 37, 39, 60, 75, 78])   # hoppar 5 clen=9
testa([7, 12, 24, 30, 31, 39, 42, 52, 79, 94])  # clen=10
testa([1,3,4,7,9,11,13,17,19,21]) # clen=8
testa([1, 3, 15, 17, 19, 28, 64, 71, 78, 84]) # clen=7
testa([3, 3, 9, 10, 17, 25, 37, 62, 80, 88]) #

testa([55, 110, 143, 201, 205, 227, 239, 353, 369, 376, 423, 467, 536, 547, 582, 696, 822, 849, 936, 973])
testa([16, 45, 48, 51, 85, 125, 147, 158, 293, 351, 374, 398, 417, 424, 439, 625, 651, 677, 872, 913]) # clen = 19
testa([14, 70, 188, 516, 534, 539, 579, 605, 609, 619, 696, 702, 744, 792, 818, 822, 866, 891, 910, 954]) # clen=4
testa([12, 75, 130, 163, 238, 250, 254, 258, 269, 362, 365, 367, 414, 580, 675, 761, 787, 823, 825, 931]) # clen=5
testa([50, 103, 113, 117, 350, 395, 462, 503, 520, 596, 656, 699, 755, 797, 826, 899, 920, 945, 962, 982]) # clen=5
testa([7, 71, 86, 98, 181, 372, 400, 435, 506, 537, 615, 632, 664, 764, 812, 890, 921, 977, 977, 999]) # clen=6

while 0 and True:
	prices = [int(1000 * random.random()) for i in range(30)]
	prices.sort()
	testa(prices)

#############
# Graveyard #
#############

# def g(v, n2):
# 	lst = [[price / (i + 1), i + 1] for i, price in enumerate(v)]
# 	print(lst)
#
# 	n1 = len(v)
# 	c = v + [0] * n2
# 	parts = []
# 	for i in range(n2):
# 		max_c = c[i]
# 		indexes = [i]
# 		for j in range(i):  # i
# 			k = i - j - 1
# 			if k >= 0:
# 				temp = c[j] + c[k]
# 				if temp > max_c:
# 					max_c = temp
# 					indexes = [k, j]
#
# 		c[i] = max_c
# 		part = [0] * n1
# 		if i <= n1:
# 			for index in indexes:
# 				part[index] = part[index] + 1
# 		else:
# 			for m in range(n1):
# 				for index in indexes:
# 					part[m] = part[m] + parts[index][m]
# 		parts.append(part)
# 		if i + 1 < 10:
# 			print('', i + 1, part, c[i], c[i] - c[i - 1])
# 		else:
# 			print(i + 1, part, c[i], c[i] - c[i - 1])
#
# 	for p in parts:
# 		print(p)
# 	return parts[-1]  # ,c[0:n1]]


# # Quadratic + value
# def f(v, n):
# 	c = v + [0] * n
# 	for i in range(n):
# 		max_c = c[i]
# 		for j in range(i):  # (i+1)//2
# 			k = i - j - 1
# 			if k >= 0:
# 				temp = c[j] + c[k]
# 				if temp >= max_c:
# 					max_c = temp
# 			else:
# 				print('k<0')
# 		c[i] = max_c
# 	return c[n-1]

# # Constant + Value
# def fc(prices, n):
# 	if n == 1: return prices[0]
# 	q, clen = max([[price/(i+1),i+1] for i, price in enumerate(prices)])
# 	add = [f(prices,i) % prices[clen-1] for i in range(clen, clen+clen)]
# 	a = prices[clen-1]
# 	return a * (n//clen) + add[n%clen]


#print(lst2)
#assert lst1 == lst2

# prices = [1,5,8,9]  # 1 2.5 2.67 2.25 clen=3
# assert gc(prices,1) == [1,0, 0,0]
# assert gc(prices,2) == [0,1, 0,0]
# assert gc(prices,3) == [0,0, 1,0]
# assert gc(prices,4) == [0,2, 0,0]
# assert gc(prices,5) == [0,1, 1,0]
# assert gc(prices,6) == [0,0, 2,0]
# assert gc(prices,7) == [0,2, 1,0]
# assert gc(prices,8) == [0,1, 2,0]
# assert gc(prices,9) == [0,0, 3,0]
# assert gc(prices,10)== [0,2, 2,0]
#
# prices = [1,6,10,14]  # 1 3 3.33 3.5 clen=4
# assert gc(prices,1) == [1,0, 0,0]
# assert gc(prices,2) == [0,1, 0,0]
# assert gc(prices,3) == [0,0, 1,0]
# assert gc(prices,4) == [0,0, 0,1]
# assert gc(prices,5) == [0,1, 1,0]
# assert gc(prices,6) == [0,1, 0,1]
# assert gc(prices,7) == [0,0, 1,1]
# assert gc(prices,8) == [0,0, 0,2]
# assert gc(prices,9) == [0,1, 1,1]
# assert gc(prices,10)== [0,1, 0,2]
# assert gc(prices,11)== [0,0, 1,2]
# assert gc(prices,12)== [0,0, 0,3]
#
# prices = [5,6,7,10]  # 5 3 3.5 2.5 clen=1
# assert gc(prices,1) == [1,0,0,0] # 5
# assert gc(prices,2) == [2,0,0,0] # 10
# assert gc(prices,3) == [3,0,0,0] # 15
# assert gc(prices,4) == [4,0,0,0] # 20
# assert gc(prices,5) == [5,0,0,0] # 25
# assert gc(prices,6) == [6,0,0,0] # 30
# assert gc(prices,7) == [7,0,0,0] # 35
# assert gc(prices,8) == [8,0,0,0] # 40
# assert gc(prices,9) == [9,0,0,0] # 45
# assert gc(prices,10)== [10,0,0,0] # 50
#
# prices = [46, 64, 75, 96] # 46 32 25 24 clen=1
# assert gc(prices,1) == [1,0,0,0] # 46
# assert gc(prices,2) == [2,0,0,0] # 92
# assert gc(prices,3) == [3,0,0,0] # ...
# assert gc(prices,4) == [4,0,0,0] #
# assert gc(prices,5) == [5,0,0,0] #
# assert gc(prices,6) == [6,0,0,0] #
# assert gc(prices,7) == [7,0,0,0] #
# assert gc(prices,8) == [8,0,0,0] #
# assert gc(prices,9) == [9,0,0,0] #
# assert gc(prices,10)== [10,0,0,0] #
#
#
# ################ performance ####################
#
# mega = 1000000
# giga = 1000000000
# tera = 1000000000000
#
# start = time.clock()
# assert gc([1, 5, 8, 9],   mega) == [0, 2, 333332, 0]
# assert gc([1, 6, 10, 14], mega) == [0, 0, 0, 250000]
# assert gc([5, 6, 7, 10],  mega) == [1000000, 0, 0, 0]
# print(time.clock()-start) # 20 micros
#
# start = time.clock()
# assert gc([1, 5, 8, 9],   giga) == [0, 2, 333333332, 0]
# assert gc([1, 6, 10, 14], giga) == [0, 0, 0, 250000000]
# assert gc([5, 6, 7, 10],  giga) == [1000000000, 0, 0, 0]
# print(time.clock()-start) # 20 micros
#
# start = time.clock()
# assert gc([1, 5, 8, 9],   tera) == [0, 2, 333333333332, 0]
# assert gc([1, 6, 10, 14], tera) == [0, 0, 0, 250000000000]
# assert gc([5, 6, 7, 10],  tera) == [1000000000000, 0, 0, 0]
# print(time.clock()-start) # 20 micros


#prices = [1,3,4,7,9,11,13,17,19,21]
#print([round(prices[i]/(i+1),3) for i in range(len(prices))])

# assert g(prices,1) == [1,0,0,0,0,0,0,0,0,0]
# assert g(prices,2) == [0,1,0,0,0,0,0,0,0,0]
# assert g(prices,3) == [0,0,1,0,0,0,0,0,0,0]
# assert g(prices,4) == [0,0,0,1,0,0,0,0,0,0]
# assert g(prices,5) == [0,0,0,0,1,0,0,0,0,0]
# assert g(prices,6) == [0,0,0,0,0,1,0,0,0,0]
# assert g(prices,7) == [0,0,0,0,0,0,1,0,0,0]
#
# assert g(prices,8) == [0,0,0,0,0,0,0,1,0,0]
# assert g(prices,9) == [0,0,0,0,0,0,0,0,1,0]
# assert g(prices,10)== [0,0,0,0,0,0,0,0,0,1]
# assert g(prices,11)== [1,0,0,0,0,0,0,0,0,1]
# assert g(prices,12)== [0,1,0,0,0,0,0,0,0,1]
# assert g(prices,13)== [0,0,0,1,0,0,0,0,1,0]
# assert g(prices,14)== [0,0,0,1,0,0,0,0,0,1]
# assert g(prices,15)== [0,0,0,0,1,0,0,0,0,1]
#
# assert g(prices,16)== [0,0,0,0,0,0,0,2,0,0]
# assert g(prices,17)== [0,0,0,0,0,0,0,1,1,0]
# assert g(prices,18)== [0,0,0,0,0,0,0,1,0,1]
# assert g(prices,19)== [0,0,0,0,0,0,0,0,1,1]
# assert g(prices,20)== [0,0,0,0,0,0,0,0,0,2]
# assert g(prices,21)== [1,0,0,0,0,0,0,0,0,2]
# assert g(prices,22)== [0,1,0,0,0,0,0,0,0,2]
# assert g(prices,23)== [0,0,0,1,0,0,0,0,1,1]
#
# assert g(prices,24)== [0,0,0,0,0,0,0,3,0,0]
# assert g(prices,25)== [0,0,0,0,0,0,0,2,1,0]
# assert g(prices,26)== [0,0,0,0,0,0,0,2,0,1]
# assert g(prices,27)== [0,0,0,0,0,0,0,1,1,1]
# assert g(prices,28)== [0,0,0,0,0,0,0,1,0,2]
# assert g(prices,29)== [0,0,0,0,0,0,0,0,1,2]
# assert g(prices,30)== [0,0,0,0,0,0,0,0,0,3]
# assert g(prices,31)== [1,0,0,0,0,0,0,0,0,3]
#
# assert g(prices,32)== [0,0,0,0,0,0,0,4,0,0]

# 32 [0, 0, 0, 0, 0, 0, 0, 4, 0, 0] 68
# 33 [0, 0, 0, 0, 0, 0, 0, 3, 1, 0] 70
# 34 [0, 0, 0, 0, 0, 0, 0, 3, 0, 1] 72
# 35 [0, 0, 0, 0, 0, 0, 0, 2, 1, 1] 74
# 36 [0, 0, 0, 0, 0, 0, 0, 2, 0, 2] 76
# 37 [0, 0, 0, 0, 0, 0, 0, 1, 1, 2] 78
# 38 [0, 0, 0, 0, 0, 0, 0, 1, 0, 3] 80
# 39 [0, 0, 0, 0, 0, 0, 0, 0, 1, 3] 82

# 40 [0, 0, 0, 0, 0, 0, 0, 5, 0, 0] 85
# 41 [0, 0, 0, 0, 0, 0, 0, 4, 1, 0] 87
# 42 [0, 0, 0, 0, 0, 0, 0, 4, 0, 1] 89
# 43 [0, 0, 0, 0, 0, 0, 0, 3, 1, 1] 91
# 44 [0, 0, 0, 0, 0, 0, 0, 3, 0, 2] 93
# 45 [0, 0, 0, 0, 0, 0, 0, 2, 1, 2] 95
# 46 [0, 0, 0, 0, 0, 0, 0, 2, 0, 3] 97
# 47 [0, 0, 0, 0, 0, 0, 0, 1, 1, 3] 99

# 48 [0, 0, 0, 0, 0, 0, 0, 6, 0, 0] 102
# 49 [0, 0, 0, 0, 0, 0, 0, 5, 1, 0] 104
# 50 [0, 0, 0, 0, 0, 0, 0, 5, 0, 1] 106
# 51 [0, 0, 0, 0, 0, 0, 0, 4, 1, 1] 108
# 52 [0, 0, 0, 0, 0, 0, 0, 4, 0, 2] 110
# 53 [0, 0, 0, 0, 0, 0, 0, 3, 1, 2] 112
# 54 [0, 0, 0, 0, 0, 0, 0, 3, 0, 3] 114
# 55 [0, 0, 0, 0, 0, 0, 0, 2, 1, 3] 116

# 56 [0, 0, 0, 0, 0, 0, 0, 7, 0, 0] 119
# 57 [0, 0, 0, 0, 0, 0, 0, 6, 1, 0] 121
# 58 [0, 0, 0, 0, 0, 0, 0, 6, 0, 1] 123
# 59 [0, 0, 0, 0, 0, 0, 0, 5, 1, 1] 125
# 60 [0, 0, 0, 0, 0, 0, 0, 5, 0, 2] 127
# 61 [0, 0, 0, 0, 0, 0, 0, 4, 1, 2] 129
# 62 [0, 0, 0, 0, 0, 0, 0, 4, 0, 3] 131
# 63 [0, 0, 0, 0, 0, 0, 0, 3, 1, 3] 133

# 64 [0, 0, 0, 0, 0, 0, 0, 8, 0, 0] 136
# 65 [0, 0, 0, 0, 0, 0, 0, 7, 1, 0] 138
# 66 [0, 0, 0, 0, 0, 0, 0, 7, 0, 1] 140
# 67 [0, 0, 0, 0, 0, 0, 0, 6, 1, 1] 142
# 68 [0, 0, 0, 0, 0, 0, 0, 6, 0, 2] 144
# 69 [0, 0, 0, 0, 0, 0, 0, 5, 1, 2] 146
# 70 [0, 0, 0, 0, 0, 0, 0, 5, 0, 3] 148
# 71 [0, 0, 0, 0, 0, 0, 0, 4, 1, 3] 150

# 72 [0, 0, 0, 0, 0, 0, 0, 9, 0, 0] 153
# 73 [0, 0, 0, 0, 0, 0, 0, 8, 1, 0] 155
# 74 [0, 0, 0, 0, 0, 0, 0, 8, 0, 1] 157
# 75 [0, 0, 0, 0, 0, 0, 0, 7, 1, 1] 159
# 76 [0, 0, 0, 0, 0, 0, 0, 7, 0, 2] 161
# 77 [0, 0, 0, 0, 0, 0, 0, 6, 1, 2] 163
# 78 [0, 0, 0, 0, 0, 0, 0, 6, 0, 3] 165
# 79 [0, 0, 0, 0, 0, 0, 0, 5, 1, 3] 167

# for i in range(1,80+1):
# 	antal = g(prices, i, 8)
# 	sum = 0
# 	for j in range(10):
# 		sum += prices[j]*antal[j]
# 	print(i,antal,sum)

#prices = [1, 6, 10, 14]  # 1 3 3.33 3.5 clen=4
# assert g(prices,1,4) == [1,0,0,0] # 1
# assert g(prices,2,4) == [0,1,0,0] # 6
# assert g(prices,3,4) == [0,0,1,0] # 10
# assert g(prices,4,4) == [0,0,0,1] # 14
# assert g(prices,5,4) == [0,1,1,0] # 16
# assert g(prices,6,4) == [0,1,0,1] # 20
# assert g(prices,7,4) == [0,0,1,1] # 24
# assert g(prices,8,4) == [0,0,0,2] # 28
#assert g(prices,9,4) == [0,1,1,1] # 30
#assert g(prices,10,4)== [0,1,0,2] # 34

#prices = [5, 6, 7, 10]  # 5 3 3.5 2.5 clen=1
# assert g(prices,1,1) == [1,0,0,0]
# assert g(prices,2,1) == [2,0,0,0]
# assert g(prices,3,1) == [3,0,0,0]
# assert g(prices,4,1) == [4,0,0,0]
# assert g(prices,5,1) == [5,0,0,0]
# assert g(prices,6,1) == [6,0,0,0]
# assert g(prices,7,1) == [7,0,0,0]

#prices = [1, 5, 8, 9]  # 1 2.5 2.67 2.25 clen=3
# assert g(prices,1,3) == [1,0,0,0] # 1
# assert g(prices,2,3) == [0,1,0,0] # 5
# assert g(prices,3,3) == [0,0,1,0] # 8
# assert g(prices,4,3) == [0,2,0,0] # 10
# assert g(prices,5,3) == [0,1,1,0] # 13
# assert g(prices,6,3) == [0,0,2,0] # 16
# assert g(prices,7,3) == [0,2,1,0] # 18
# assert g(prices,8,3) == [0,1,2,0] # 21
# assert g(prices,9,3) == [0,0,3,0] # 24
# assert g(prices,10,3)== [0,2,2,0] # 26

#####################################

#prices = [1, 3, 4, 7, 9, 11, 13, 17, 19, 21]
#print('clen',clen)
#offset = findCycle(prices,clen) # offset är en multipel av clen
#print(offset)

# prices = [1,5,8,9]
# assert f(prices,1) == 1
# assert f(prices,2) == 5
# assert f(prices,3) == 8
# assert f(prices,4) == 10
# assert f(prices,5) == 13
# assert f(prices,6) == 16
# assert f(prices,7) == 18
# assert f(prices,8) == 21
# assert f(prices,9) == 24
# assert f(prices,10) == 26
#
# prices = [1,6,10,14]
# assert f(prices,1) == 1
# assert f(prices,2) == 6
# assert f(prices,3) == 10
# assert f(prices,4) == 14
# assert f(prices,5) == 16
# assert f(prices,6) == 20
# assert f(prices,7) == 24
# assert f(prices,8) == 28
# assert f(prices,9) == 30
# assert f(prices,10) == 34
#
# prices = [5,6,7,10]
# assert f(prices,1) == 5
# assert f(prices,2) == 10
# assert f(prices,3) == 15
# assert f(prices,4) == 20
# assert f(prices,5) == 25
# assert f(prices,6) == 30
# assert f(prices,7) == 35
# assert f(prices,8) == 40
# assert f(prices,9) == 45
# assert f(prices,10) == 50

#for i in range(1,11):
#	print(fc([1,3,4,7,9,11,13,17,19,21],i))

# prices = [1,5,8,9]
# assert fc(prices,1) == 1
# assert fc(prices,2) == 5
# assert fc(prices,3) == 8
# assert fc(prices,4) == 10
# assert fc(prices,5) == 13
# assert fc(prices,6) == 16
# assert fc(prices,7) == 18
# assert fc(prices,8) == 21
# assert fc(prices,9) == 24
# assert fc(prices,10) == 26
#
# prices = [1,6,10,14]
# assert fc(prices,1) == 1
# assert fc(prices,2) == 6
# assert fc(prices,3) == 10
# assert fc(prices,4) == 14
# assert fc(prices,5) == 16
# assert fc(prices,6) == 20
# assert fc(prices,7) == 24
# assert fc(prices,8) == 28
# assert fc(prices,9) == 30
# assert fc(prices,10) == 34
#
# prices = [5,6,7,10]
# assert fc(prices,1) == 5
# assert fc(prices,2) == 10
# assert fc(prices,3) == 15
# assert fc(prices,4) == 20
# assert fc(prices,5) == 25
# assert fc(prices,6) == 30
# assert fc(prices,7) == 35
# assert fc(prices,8) == 40
# assert fc(prices,9) == 45
# assert fc(prices,10) == 50

# def differences(lst):
# 	return [lst[i + 1] - lst[i] for i in range(len(lst) - 1)]
# assert differences([1,2,7,9]) == [1,5,2]

# def findCycle3(prices):
# 	lst = [[price / (i + 1), i + 1] for i, price in enumerate(prices)]
# 	q, clen = max(lst)
# 	repeats = 1 + 2*len(prices)//clen
# 	i = len(prices)
# 	while True:
# 		lst2 = differences([f(prices, j+1) for j in range(i,i+repeats * clen)])
# 		ok = True
# 		for j in range(clen,len(lst2)):
# 			if lst2[j]!=lst2[j%clen]:
# 				ok = False
# 		if ok:
# 			break
# 		i += 1
# 	return [i+clen,clen]
#
# def findCycle2(prices): # oka med ett. 2*clen element
# 	lst = [[price / (i + 1), i + 1] for i, price in enumerate(prices)]
# 	q, clen = max(lst)
# 	print(lst)
# 	i = len(prices)
# 	while True:
# 		lst2 = differences([f(prices, j+1) for j in range(i,i+clen+clen+1)])
# 		if lst2[0:clen]==lst2[clen:clen+clen]:
# 			print([f(prices, j + 1) for j in range(i + clen + clen + 1)])
# 			print(lst2)
# 			break
# 		i += 1
# 	print('offset',i)
# 	print('clen',clen)
# 	return [i+clen,clen] # i-clen-clen gav bug
# #print(findCycle([1, 3, 4, 7, 9, 11, 13, 17, 19, 21]) , [32,8])
#
#
# def findCycle1(prices):
# 	lst = [[price / (i + 1), i + 1] for i, price in enumerate(prices)]
# 	print(lst)
# 	q, clen = max(lst)
# 	print(q,clen)
# 	i = len(prices)
# 	lst1 = []
# 	lst2 = differences([f(prices, j+1) for j in range(i,i+clen+1)])
# 	res = lst2
# 	while lst1 != lst2:
# 		#print('lst1', lst1)
# 		#print('lst2', lst2)
# 		lista = [f(prices, j+1) for j in range(i+clen,i+clen+clen+1)]
# 		#print(lista)
# 		lst1 = lst2
# 		lst2 = differences(lista)
# 		res = res + lst2
# 		i += clen
# 	if TRACE: print('diff',res)
# 	print('offset',i)
# 	print('clen',clen)
# 	# print('lst1',i-clen-clen,lst1)
# 	# print('lst2',i+clen,lst2)
# 	return [i+4*clen,clen] # i-clen-clen gav bug

#################################
