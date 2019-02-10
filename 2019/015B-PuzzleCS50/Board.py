from queue import Queue
from random import randint

MAX_COL = 4
MAX_ROW = 4
SHUFFLE_MAGNITUDE = 19
ALFA = '•123456789ABCDEF'
MOVES = [-4,1,4,-1] # up, right, down, left   INDEX
GOAL = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0]

class Board:
	def __init__(self, board=GOAL, loc=MAX_ROW * MAX_COL - 1, path=[]):
		self.board = list(board)
		self.loc = loc
		self.path = list(path)

	def copy(self): return Board(self.board,self.loc,self.path)

	def __repr__(self):
		s = ''
		for i in range(16):
			s += ' ' + ALFA[self.board[i]]
			if i%4==3: s += "\n"
		return s

	def key(self): return ''.join([ALFA[i] for i in self.board])

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
		if GOAL == self.board:
			print("Congrats! You won! ")
			#return False
		#return True

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

	def solve(self): # breadth first

		def successors(node):
			res = []
			for m in range(4):
				if node.inside(m):
					child = node.copy()
					if child.move(m):	res.append(child)
			return res

		searched = {}
		frontier = Queue() # contains nodes
		self.path = []
		frontier.put(self)

		while not frontier.empty():
			node = frontier.get()
			if node.board == GOAL: return node.path
			for child in successors(node):
				if child.key() not in searched: frontier.put(child)
			searched[node.key()] = True
		return []
