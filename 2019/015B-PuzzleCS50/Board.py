from heapq import heappush,heappop
from random import randint

N = 4
NN = N*N
SHUFFLE_MAGNITUDE = 40
ALFA = '_ABCDEFGHIJKLMNO'
MOVES = [-N,1,N,-1] # Up Right Down Left

class Fifteen:
	def __init__(self,key0,key1,searched,nr):
		self.target = key1
		self.searched = searched
		self.nr = nr
		node = Board(key0,key1)
		node.cachedValue = node.value()
		self.queue = [node] # Priority Queue

	def step(self):
		def push(obj): heappush(self.queue, obj)
		def pop():     return heappop(self.queue)
		def empty():   return len(self.queue) == 0
		def successors(node):
			result = []
			for m in range(N):
				if node.inside(m):
					child = node.copy()
					if child.move(m):  result.append(child)
			return result
		node = pop()
		if node.key0 == self.target: return node.key0
		self.searched[node.key0] = self.nr
		for child in successors(node):
			if child.key0 not in self.searched: push(child)
			elif self.searched[child.key0] != self.nr: return child.key0
		return ""

	def shuffle(self):
		last = 99
		self.key0 = ALFA
		self.path = ''
		for i in range(SHUFFLE_MAGNITUDE):
			cands = [m for m in range(N) if self.inside(m) and abs(m - last) != 2]
			i = randint(0, len(cands) - 1)
			last = cands[i]
			self.move(last)

class Board:
	def __init__(self, key0, key1, path=''):
		self.key0 = key0
		self.key1 = key1
		self.path = path
		self.cachedValue = self.value()

	def copy(self): return Board(self.key0, self.key1, self.path)
	def __gt__(self, other): return self.cachedValue > other.cachedValue

	def display(self):
		result = ''
		for i in range(NN):
			if i%N == 0: result += "\n"
			result += ' ' + self.key0[i]
		result += '  ' + self.key0 + ' ' + str(len(self.path)) + ' ' + self.path + ' value=' + str(self.cachedValue)
		if self.key0 == self.key1: result += "  Solved!"
		return result

	def value(self):
		def manhattan(i, j): return abs(i // N - j // N) + abs(i % N - j % N)
		return len(self.path) + sum([manhattan(i, self.key1.index(self.key0[i])) for i in range(NN) if self.key0[i] != '_'])

	def move(self, m):
		if not self.inside(m): return False
		loc1 = self.key0.index('_')
		loc2 = loc1 + MOVES[m]

		sk = list(self.key0)
		sk[loc1], sk[loc2] = sk[loc2], sk[loc1]
		self.key0 = ''.join(sk)

		self.path += "URDL"[m]
		self.cachedValue = self.value()
		return True

	def inside(self,m):
		i = MOVES[m]
		loc = self.key0.index('_')
		if i == -N and loc // N == 0:   return False
		if i == +1 and loc %  N == N-1: return False
		if i == +N and loc // N == N-1: return False
		if i == -1 and loc %  N == 0:   return False
		return True

