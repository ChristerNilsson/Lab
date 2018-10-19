# Undersokning av fel vid användande av Babbage Difference Engine
# Antal differenser är viktigt.
# Antal siffror är också viktigt.
# Pga felfortplantning måste omstarter ske ofta.
# T ex vid beräkning av log(1.000) t o m log(9.999) med 7 differenser samt 31 siffror
# måste omstart ske vid 1.200, 1.400 osv om sex decimaler ska vara korrekta.
# Med 13 differenser räcker det med omstart vid 1.500, 2.000 osv

import math
from decimal import *
getcontext().prec = 31
lst = []
n = 8

for i in range(n):
	lst.append((Decimal(1)+Decimal(i)/Decimal(1000)).log10())

for k in range(n-1):
	for i in range(n-1-k):
		lst[n-1-i] -= lst[n-2-i]
print(lst)

for i in range(301):
	print("%.3f " % (1+i/1000),format("%.6f " % (lst[0])), "%.6f " % math.log10(1+i/1000))
	for k in range(n-1):
		lst[k] += lst[k+1]
