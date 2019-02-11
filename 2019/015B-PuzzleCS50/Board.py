from heapq import heappush,heappop
from random import randint

#                             max solve millis
PROBLEMA = 'ABCDEFGHIJKLMN•O' #  1   1  1.3 ms
PROBLEMB = 'ABCDEFGHIJKL•MNO' #  3   3  2.2 ms
PROBLEMC = 'ABCDIEKGMFJHN•OL' # 10  10  1.6 ms OK
PROBLEMD = 'CGHDABL•EFKOIMJN' # 20  20  3.7 ms OK
PROBLEME = 'ABDGNMECOIFHJ•KL' # 30  26  34 ms
PROBLEMF = 'GEDHBCKFAJ•ONIML' #     38  27.013 s OK
PROBLEMG = 'IEADMCF•GKLBNOJH' # 40  36  5191 ms

N = 4
NN = N*N
SHUFFLE_MAGNITUDE = 40
ALFA = 'ABCDEFGHIJKLMNO•'
MOVES = [-N,1,N,-1] # Up Right Down Left

class Board:
	def __init__(self, key=PROBLEMG, path=''):
		self.setKey(key)
		self.path = path + ''
		self.cachedValue = self.value()
		self.cachedKey = self.key()

	def setKey(self,key): self.board = [ALFA.index(ch) for ch in key]
	def copy(self): return Board(self.key(),self.path)
	def key(self):	return ''.join([ALFA[i] for i in self.board])
	def __gt__(self, other): return self.cachedValue > other.cachedValue

	def display(self):
		result = ''
		for i in range(NN):
			if i%N == 0: result += "\n"
			result += ' ' + ALFA[self.board[i]]
		result += '  ' + self.key() + ' ' + str(len(self.path)) + ' ' + self.path + ' value=' + str(self.cachedValue)
		if self.cachedKey == ALFA: result += "  Solved!"
		return result

	def value(self):
		def manhattan(i, j): return abs(i // N - j // N) + abs(i % N - j % N)
		return len(self.path) + sum([manhattan(i, self.board[i]) for i in range(NN) if self.board[i] != 15])

	def move(self, m):
		if not self.inside(m): return False
		loc1 = self.board.index(15)
		loc2 = loc1 + MOVES[m]
		sb = self.board
		sb[loc1], sb[loc2] = sb[loc2], sb[loc1]
		self.path += "URDL"[m]
		self.cachedValue = self.value()
		self.cachedKey = self.key()
		return True

	def inside(self,m):
		i = MOVES[m]
		loc = self.board.index(15)
		if i == -N and loc // N == 0:   return False
		if i == +N and loc // N == N-1: return False
		if i == -1 and loc %  N == 0:   return False
		if i == +1 and loc %  N == N-1: return False
		return True

	def shuffle(self):
		last = 99
		self.setKey(ALFA)
		self.path = ''
		for i in range(SHUFFLE_MAGNITUDE):
			cands = [m for m in range(N) if self.inside(m) and abs(m-last) != 2]
			i = randint(0, len(cands)-1)
			last = cands[i]
			self.move(last)

	def solve(self):

		queue = [] # Priority Queue
		def push(obj): heappush(queue, obj)
		def pop(): return heappop(queue)
		def empty(): return len(queue)==0

		# queue = Queue() # FIFO
		# def push(obj): queue.put(obj)
		# def pop(): return queue.get()
		# def empty(): return queue.empty()

		def successors(node):
			result = []
			for m in range(N):
				if node.inside(m):
					child = node.copy()
					if child.move(m):	result.append(child)
			return result

		self.path = ''
		self.cachedValue = self.value()
		self.cachedKey = self.key()
		searched = {} # {} set() []

		push(self)

		while not empty():
			node = pop()
			if node.cachedKey == ALFA:
				print(len(searched))
				return node.path
			for child in successors(node):
				if child.cachedKey not in searched: push(child)

			searched[node.cachedKey] = True
			#searched.add(node.cachedKey)
			#searched.append(node.cachedKey)

		return []
