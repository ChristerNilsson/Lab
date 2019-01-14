from collections import defaultdict, Counter
import random
import time

N = 4
CHARS = 200000
start = time.perf_counter()

file = open('koranen.txt', mode='r', encoding="utf-8")
data = file.read()
file.close()

model = defaultdict(Counter)

for i in range(len(data) - N):
	state = data[i:i + N]
	next = data[i + N]
	model[state][next] += 1

state = random.choice(list(model))
out = list(state)
for i in range(CHARS):
	out.extend(random.choices(list(model[state]), model[state].values()))
	state = state[1:] + out[-1]
print(''.join(out))
print(time.perf_counter()-start)
