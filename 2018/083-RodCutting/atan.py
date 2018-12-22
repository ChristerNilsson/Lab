import math,time

# sinus : cirka 0.17 mikrosekunder

summa = 0.0

start = time.clock()
for i in range(6000000):
	summa += math.sin(i/1000)
print(time.clock()-start,summa)