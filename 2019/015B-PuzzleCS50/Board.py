from heapq import heappush,heappop
from random import randint

#                             max solve millis
PROBLEMA = 'ABCGDIEFHJNKL•MO' # 10   10     4 ms
PROBLEMB = 'DABFHJC•LENGMIOK' # 20   20    21 ms
PROBLEMC = 'DABCJKGOHEMNL•IF' # 30   28   473 ms
PROBLEMD = 'DAMBG•HCEFLKINJO' # 40   34  5286 ms
PROBLEME = '' #
PROBLEMF = '' #
PROBLEMG = '' #
PROBLEMH = '' #
PROBLEMI = '' #
PROBLEMJ = '' #
PROBLEMK = '' #
PROBLEML = '' #
PROBLEMM = 'ONHLJKIMBFEACGD•' # 80 moves needed [Gasser]

N = 4
NN = N*N
SHUFFLE_MAGNITUDE = 40
ALFA = '•ABCDEFGHIJKLMNO'
MOVES = [-N,1,N,-1] # Up Right Down Left


class Board:
	def __init__(self, key=ALFA, path=''):
		self.key = key
		self.path = path
		self.cachedValue = self.value()

	def copy(self): return Board(self.key,self.path)
	def __gt__(self, other): return self.cachedValue > other.cachedValue

	def display(self):
		result = ''
		for i in range(NN):
			if i%N == 0: result += "\n"
			result += ' ' + self.key[i]
		result += '  ' + self.key + ' ' + str(len(self.path)) + ' ' + self.path + ' value=' + str(self.cachedValue)
		if self.key == ALFA: result += "  Solved!"
		return result

	def value(self):
		def manhattan(i, j): return abs(i // N - j // N) + abs(i % N - j % N)
		return len(self.path) + sum([manhattan(i, ALFA.index(self.key[i])) for i in range(NN) if self.key[i] != '•'])

	def move(self, m):
		if not self.inside(m): return False
		loc1 = self.key.index('•')
		loc2 = loc1 + MOVES[m]

		sk = list(self.key)
		sk[loc1], sk[loc2] = sk[loc2], sk[loc1]
		self.key = ''.join(sk)

		self.path += "URDL"[m]
		self.cachedValue = self.value()
		return True

	def inside(self,m):
		i = MOVES[m]
		loc = self.key.index('•')
		if i == -N and loc // N == 0:   return False
		if i == +1 and loc %  N == N-1: return False
		if i == +N and loc // N == N-1: return False
		if i == -1 and loc %  N == 0:   return False
		return True

	def shuffle(self):
		last = 99
		self.key = ALFA
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

		def successors(node):
			result = []
			for m in range(N):
				if node.inside(m):
					child = node.copy()
					if child.move(m):	result.append(child)
			return result

		self.path = ''
		self.cachedValue = self.value()
		searched = {}

		push(self)

		while not empty():
			node = pop()
			if node.key == ALFA:
				print(len(searched))
				return node.path
			for child in successors(node):
				if child.key not in searched: push(child)
			searched[node.key] = True
		return []
