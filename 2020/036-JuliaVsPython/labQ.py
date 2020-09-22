import time
import math

def execute():
	primes = []
	a = 100000000
	limit = 10001
	for j in range(a+1,a+10000,2):
		prime = True
		for k in range(3,limit,2):
			if j % k == 0:
				prime = False
				break
		if prime: primes.append(j)
	print(len(primes))

start = time.time()
execute()
print(time.time()-start)
