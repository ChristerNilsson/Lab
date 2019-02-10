from heapq import heappush,heappop
from random import randint

MAX_COL = 4
MAX_ROW = 4
SHUFFLE_MAGNITUDE = 30
ALFA = '•ABCDEFGHIJKLMNO'
MOVES = [-4,1,4,-1] # up, right, down, left   INDEX
GOAL = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0]

def manhattan(i, j): return abs(i//4-j//4) + abs(i%4-j%4)
def pretty(path): return "".join(["URDL"[p] for p in path])

class Board:
	def __init__(self, board=GOAL, loc=MAX_ROW * MAX_COL - 1, path=[]):
		self.board = list(board)
		self.loc = loc
		self.path = list(path)

	def copy(self): return Board(self.board,self.loc,self.path)
	def key(self): return ''.join([ALFA[i] for i in self.board])
	def __gt__(self, other): return self.value() > other.value()

	def __repr__(self):
		s = ''
		for i in range(16):
			s += ' ' + ALFA[self.board[i]]
			if i%4==3: s += "\n"
		return s

	def value(self):
		res = 0
		for i in range(16):
			if self.board[i] != 0 :
				res += manhattan(i,[15,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14][self.board[i]])
		return res + len(self.path)

	def move(self, m):
		i = MOVES[m]
		index = self.loc
		indexi = index+i
		if i==-1 and index%4==0: return False
		if i== 1 and (index+1)%4==0: return False
		if not (0 <= indexi and indexi <= 15): return False
		sb = self.board
		sb[index], sb[indexi] = sb[indexi], sb[index]
		self.loc = indexi
		self.path.append(m)
		return True

	def refresh(self):
		print(self)
		if GOAL == self.board: print("You solved it!")

	def inside(self,m):
		i = MOVES[m]
		index = self.loc
		indexi = index+i
		if i==-1 and index%4==0: return False
		if i== 1 and (index+1)%4==0: return False
		return 0 <= indexi and indexi <= 15

	def shuffle(self):
		last = 99
		for i in range(SHUFFLE_MAGNITUDE):
			cands = [m for m in range(4) if self.inside(m) and abs(m-last) != 2]
			i = randint(0, len(cands)-1)
			last = cands[i]
			self.move(last)

	def push(self,obj): heappush(self.frontier, obj)
	def pop(self): return heappop(self.frontier)

	def solve(self):

		def successors(node):
			res = []
			for m in range(4):
				if node.inside(m):
					child = node.copy()
					if child.move(m):	res.append(child)
			return res

		searched = {}
		self.frontier = []
		self.path = []
		self.push(self)

		while len(self.frontier) > 0:
			node = self.pop()
			if node.key() == 'ABCDEFGHIJKLMNO•': return node.path
			for child in successors(node):
				if child.key() not in searched: self.push(child)
			searched[node.key()] = True
		return []
