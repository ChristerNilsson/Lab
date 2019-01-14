from collections import defaultdict, Counter
import random
import time

N = 4
CHARS = 200000

file = open('koranen.txt', mode='r', encoding="utf-8")
data = file.read()
file.close()

start = time.perf_counter()
if 0:
	model = defaultdict(Counter)
	for i in range(len(data) - N):
		state = data[i:i + N]
		next = data[i + N]
		model[state][next] += 1

	state = random.choice(list(model))
	out = [state]
	for i in range(CHARS):
		out.extend(random.choices(list(model[state]), model[state].values()))
		state = state[1:] + out[-1]
	print(''.join(out))

else:
	model = {}
	for i in range(len(data) - N):
		state = data[i:i + N]
		next = data[i + N]
		if state in model:
			model[state].append(next)
		else:
			model[state] = [next]

	for state in model:
		if len(model[state])==1: continue
		a = set(model[state])
		if len(a)==1: model[state]=list(a)

	freq = {}
	for state in model:
		print(state,model[state])
		index = len(set(model[state]))
		if index in freq:
			freq[index] += 1
		else:
			freq[index] = 1
	for i in range(100):
		if i in freq:
			print(i,freq[i])

	state = random.choice(list(model))
	out = [state]
	for i in range(CHARS):
		if state in model:
			char = random.choice(model[state])
			out.append(char)
			state = state[1:N] + char
	print(''.join(out))

print(time.perf_counter()-start)
