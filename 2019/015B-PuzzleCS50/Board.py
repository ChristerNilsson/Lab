from heapq import heappush,heappop
from random import randint

N = 4
NN = N*N
SHUFFLE_MAGNITUDE = 80
ALFA = 'ABCDEFGHIJKLMNO•'
MOVES = [-N,1,N,-1] # Up Right Down Left

class Board:
	def __init__(self, board=range(NN), loc=NN-1, path=''):
		self.board = list(board)
		self.loc = loc
		self.path = path + ''
		self.cachedValue = 0
		self.cachedKey = ''

	def copy(self): return Board(self.board,self.loc,self.path)
	def key(self):	return ''.join([ALFA[i] for i in self.board])
	def __gt__(self, other): return self.cachedValue > other.cachedValue

	def display(self):
		result = ''
		for i in range(NN):
			if i%N == 0: result += "\n"
			result += ' ' + ALFA[self.board[i]]
		result += '  ' + str(len(self.path)) + ' ' + self.path + ' value=' + str(self.cachedValue)
		if self.cachedKey == ALFA: result += "  Solved!"
		return result

	def value(self):
		def manhattan(i, j): return abs(i // N - j // N) + abs(i % N - j % N)
		return len(self.path) + sum([manhattan(i, self.board[i]) for i in range(NN) if self.board[i] != 15])

	def move(self, m):
		if not self.inside(m): return False
		newloc = self.loc + MOVES[m]
		sb = self.board
		sb[self.loc], sb[newloc] = sb[newloc], sb[self.loc]
		self.loc = newloc
		self.path += "URDL"[m]
		self.cachedValue = self.value()
		self.cachedKey = self.key()
		return True

	def inside(self,m):
		i = MOVES[m]
		if i == -N and self.loc // N == 0:   return False
		if i == +N and self.loc // N == N-1: return False
		if i == -1 and self.loc %  N == 0:   return False
		if i == +1 and self.loc %  N == N-1: return False
		return True

	def shuffle(self):
		last = 99
		self.path = ''
		for i in range(SHUFFLE_MAGNITUDE):
			cands = [m for m in range(N) if self.inside(m) and abs(m-last) != 2]
			i = randint(0, len(cands)-1)
			last = cands[i]
			self.move(last)

	def solve(self):

		def push(obj): heappush(heap, obj)
		def pop(): return heappop(heap)

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
		searched = {}
		heap = []
		push(self)

		while len(heap) > 0:
			node = pop()
			if node.cachedKey == ALFA:
				print('searched',len(searched))
				print('heap',len(heap))
				return node.path
			for child in successors(node):
				if child.cachedKey not in searched: push(child)
			searched[node.cachedKey] = True
		return []
