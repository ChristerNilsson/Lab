from collections import OrderedDict

route = None

def read(letter):
	net = {}
	with open(letter + '.out') as f:
		for id in range(80000):
			arr = f.readline().strip().split(' ')
			net[id] = [int(item) for item in arr]
	return net

def score(a,b):
	if route[b] in net[route[a]]: return 1
	return 0

def swapscore(a1,b1):
	a0 = a1-1
	b0 = b1-1
	old = score(a0,a1) + score(b0,b1)
	new = score(a0,b0) + score(a1,b1)
	return new-old

def swap(i,j): # reverses the nodes between the indices.
	new = route[i:j]
	new.reverse()
	route[i:j] = new
# route = [0,1,2,3,4,5,6,7,8,9]
# swap(2,4)
# assert [0,1,3,2,4,5,6,7,8,9] == route
# swap(0,10)
# assert [9,8,7,6,5,4,2,3,1,0] == route

def two_opt():
	swaps = 1
	while swaps > 0:
		swaps = 0
		for i in range(1, len(route)-2):
			print(i)
			for j in range(i+2, len(route)):
				score = swapscore(i,j)
				if score > 0:
					swaps += 1
					print(swaps, score, i, j)
					swap(i,j)
		save('bbb',route)

# This function arranges the route in a good starting position.
# It tries to go to one of the neighbours first.
# If that is not possible, it uses the first photo in net.
# Executes in seconds.
def init():
	result = OrderedDict() # Quicker than List.
	curr = 0
	while True:
		result[curr] = True
		if len(result)==80000: break
		found = False
		for i in net[curr]:
			if i not in result:
				found = True
				net.pop(curr)
				curr = i
				break
		if not found:
			net.pop(curr)
			key = next(iter(net))
			curr = key
	return list(result)

def save(letter,result):
	with open(letter + '.out', 'w') as f:
		print(f"{len(result)}", file=f)
		for line in result: print(f"{line}", file=f)
	print(f"{letter}.out saved")

def calc():
	return sum([score(i, i + 1) for i in range(80000-1)])

net = read('bb')
route = init()
print(route)

net = read('bb')
print(3*calc())
two_opt()
print(3*calc())
