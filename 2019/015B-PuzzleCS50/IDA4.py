from time import perf_counter

N = 4
nodeCount = 0
nodes = {}

class Node:

	def __init__(self,state,target,move=0):
		global nodeCount
		self.state = state
		self.target = target
		self.move = move
		nodeCount += 1

	def is_goal(self): return self.state == self.target

	def successors(self):
		def swap(m):
			if self.move == -m: return
			sk = list(self.state)
			sk[loc], sk[loc+m] = sk[loc+m], sk[loc]
			ret.append(Node(''.join(sk),self.target,m))
		ret = []
		loc = self.state.index('_')
		if loc % N != 0:   swap(-1) # Left
		if loc % N != N-1: swap(+1) # Right
		if loc//N != 0:    swap(-N) # Up
		if loc//N != N-1:  swap(+N) # Down
		return ret

	def display(self):
		result = ''
		for i in range(N*N):
			if i % N == 0: result += "\n"
			result += ' ' + self.state[i]
		result += '  ' + self.state + ' value=' + str(self.h()) #cachedValue)
		if self.state == self.target: result += "  Solved!"
		return result

	def h(self):
		def manhattan(i, j): return abs(i // N - j // N) + abs(i % N - j % N)
		return sum([manhattan(i, self.target.index(self.state[i])) for i in range(N*N) if self.state[i] != '_'])

def dfs(node, limit, path=[]):
	if node.state in nodes and len(path) >= nodes[node.state]: return []
	nodes[node.state] = len(path)
	if node.is_goal(): return path
	if len(path) == limit: return []
	for child in node.successors():
		if len(path) + 1 + child.h() <= limit:
			p = dfs(child, limit, path + [child])
			if len(p) > 0: return p
	return []

start = perf_counter()

for limit in range(99):
	nodes = {}
	print(f"Limit Search at level {limit}",nodeCount,perf_counter() - start)
	path = dfs(Node('ONHLJKIMBFEACGD_','_ABCDEFGHIJKLMNO'), limit)
	if len(path) > 0:
		for p in path: print(p.display())
		print(len(path))
		break

# ABCGDIEFHJNKL_MO 10
# DABFHJC_LENGMIOK 20
# DABCJKGOHEMNL_IF 28
# DAMBG_HCEFLKINJO 34 (5286 ms)
# ...
# ONHLJKIMBFEACGD_ 80

