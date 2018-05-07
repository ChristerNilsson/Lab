# -*- coding: utf-8 -*-

import random

def solve(ticks,sum,n):
	tabell = [None] * (sum+1)
	tabell[n * ticks[0]] = [0] * len(ticks)
	tabell[n * ticks[0]][0] = n
	for i in range(n,sum):
		rad = tabell[i]
		if rad == None: continue
		for j in range(len(ticks)):
			if rad[j] == 0: continue
			tj = ticks[j]
			for k in range(len(ticks)):
				if k <= j: continue
				tk = ticks[k]
				index = i - tj + tk
				if index > sum: continue
				if tabell[index] == None: # or random.random() < 0.5:
					tabell[index] = rad[:]
					tabell[index][j] -= 1
					tabell[index][k] += 1
	return tabell[sum]

ticks = [2,3,5,7,11,13] #,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127] #,131,137,139,149,151,157,163,167,173]
n = 125
for j in range(100):
	count = []
	for i in range(125*2,125*13+1):
		if solve(ticks,i,n)==None:
			count.append(i)
	print count
