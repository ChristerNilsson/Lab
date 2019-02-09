from copy import deepcopy
from queue import Queue
from random import randint

MAX_COL = 4
MAX_ROW = 4
SHUFFLE_MAGNITUDE = 5
ALFA = '•123456789ABCDEF'
MOVES = [[-1,0],[0,1],[1,0],[0,-1]] # up, right, down, left   ROW,COL
GOAL = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 0]]

class Board:
	def __init__(self, board=GOAL, loc=[MAX_ROW - 1, MAX_COL - 1], path=[]):
		self.board = deepcopy(board)
		self.loc = loc.copy()
		self.path = path.copy()

	def copy(self): return Board(self.board,self.loc,self.path)

	def __repr__(self): return self.key()
	def key(self, space=' ', end='\n'):
		s = ''
		for row in range(MAX_ROW):
			for col in range(MAX_COL):
				s += space + ALFA[self.board[row][col]]
			s += end
		return s

	def move(self, m):
		r,c = MOVES[m]
		row,col = self.loc
		rowr,colc = row+r,col+c
		if not (rowr in [0,1,2,3] and colc in [0,1,2,3]): return False
		sb = self.board
		sb[row][col], sb[rowr][colc] = sb[rowr][colc], sb[row][col]
		self.loc = [rowr,colc]
		self.path.append(m)
		return True

	def refresh(self):
		print(self)
		if GOAL == self.board:
			print("Congrats! You won! ")
			return False
		return True

	def inside(self,m):
		r,c = MOVES[m]
		row,col = self.loc
		rowr,colc = row+r,col+c
		return rowr in [0,1,2,3] and colc in [0,1,2,3]

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
				if child.key('','') not in searched: frontier.put(child)
			searched[node.key('','')] = True
		return []
