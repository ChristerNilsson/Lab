# -*- coding: utf-8 -*-

import random

# Startar man med jämnt fördelad antalslista funkar denna rutin bra och snabbt.
# Start med alla mynt av samma valör ger ofta loopar, typ 3028, 3026, 3028...
# Myntens valörer ligger i listan ticks.

def prod(ticks,antal): return reduce(lambda a,b: a+b, [t*a for t,a in zip(ticks,antal)])

def bestSwap(ticks,sum,antal):
	best = [999999,0,0]
	s = prod(ticks,antal)
	n = len(ticks)
	for i in range(n):
		if antal[i] == 0: continue
		for j in range(n):
			if i == j: continue
			newsum = s-ticks[i]+ticks[j]
			diff = abs(newsum - sum)
			if diff < best[0]: best = [diff,i,j,newsum]
	return best

# Swappar så länge förbättringar sker.
def solve(ticks, sum, steps):
	antal = [0] * len(ticks) # sprid ut jämnt
	for i in range(steps): antal[i % len(antal)] += 1
	diff = 999999
	while diff != 0:
		diff,i,j,newsum = bestSwap(ticks,sum,antal)
		#print newsum,i,j,antal
		antal[i] -= 1
		antal[j] += 1
	return antal

#assert [1,2,4] == solve([3,7,13], 69, 7)
#assert [4,4,4,3,2,3] == solve([2,3,5,13,17,19], 170, 20)
ticks = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73]
# assert [0,0,0,0,0,1,2,1,1,1,0,0,0,0,0,0,0,0,0,0,4] == solve(ticks,410,10)
# assert [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10] == solve(ticks,730,10)
# assert [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15] == solve(ticks,73*15,15)
# assert [7,5,5,6,5,5,5,5,5,5,5,5,5,5,5,5,4,4,3,4,2] == solve(ticks,3027,100)

primes = [2,3,5,7,11,13] #,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173]
ticks = primes
#ticks = random.sample(primes, 20)
#ticks.sort()
print ticks
n=10
for i in range(ticks[0]*n,ticks[-1]*n+1):
	print i,solve(ticks,i,n)




