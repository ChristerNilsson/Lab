# Ada Lovelace, Bernoulli and the Gauss Schoolboy Problem
# https://sandbox.open.wolframcloud.com/objects/user-e57fdc7a-843a-48ba-8e5d-7bf5f8581c8b/adathemedmathexploration/bernoullinumbers.nb

# General Method for Integer Power Sum Formula
# https://www.youtube.com/watch?v=8nUZaVCLgqA

# http://blog.stephenwolfram.com/2015/12/untangling-the-tale-of-ada-lovelace/

# http://www.pages.drexel.edu/~am4234/difference_engine.html
# https://www.youtube.com/watch?v=5rtKoKFGFSM Analytical Engine

# Genom att beräkna slutna former for summor av potenser, kan man finna Bernoulli tal.
# Det tar cirka tio minuter att beräkna B[20]
# Med bättre metoder tar det några mikrosekunder.

from sympy import symbols, simplify, fraction,bernoulli
import time

start = time.time()

# N,x = symbols('N x')
# e = (x**(N+1)-1)/(x-1)
#
# for i in range(2): ### ändra här!
# 	e = simplify(x * e.diff(x))
# n,d = fraction(simplify(e))
# while d.subs({x:1}) == 0:
# 	print('nom',n)
# 	print('den',d)
# 	print()
# 	d = d.diff(x)
# 	n = n.diff(x)
# print('nom',simplify(n.subs({x:1})))
# print('den',simplify(d.subs({x:1})))

#print(bernoulli(50)) # 15 ms
#print(bernoulli(100)) # 22 ms
#print(bernoulli(200)) # 53 ms
#print(bernoulli(1000)) # 15 ms
#print(bernoulli(10000)) # 548 ms
#print(bernoulli(100000)) #  224 sek
print(bernoulli(1000000)) #   sek


print(time.time()-start)

# 0: 1
# 1: 1/2 0.2 sek
# 2: 1/6 0.5 sek
# 4: -1/30 2.2 sek
# 6: 1/42 8.2 sek
# 8: 1/30 20.1 sek
# 10: 5/66 43.8 sek
# 12: 691/2730 84.5 sek
# 14: 7/6 152.4 sek
# 16: 3617/510 238.1 sek
# 18: 43867/798 391.6 sek
# 20: 174611/330 592.9 sek

# Summa i:
# N*(N + 1)
# 2

# Summa i^2:
# N*(2*N**2 + 3*N + 1)
# 6

# Summa i^20:
# 2432902008176640000*N**21 + 25545471085854720000*N**20 + 85151570286182400000*N**19 - 485363950631239680000*N**17 + 3143309394564218880000*N**15 - 16502374321462149120000*N**13 + 65009353387578163200000*N**11 - 181002232636989603840000*N**9 + 330047486429242982400000*N**7 - 351112281886638784512000*N**5 + 177873520654474444800000*N**3 - 27033456071346536448000*N
# 51090942171709440000
# 27033456071346536448000/51090942171709440000 == 174611/330