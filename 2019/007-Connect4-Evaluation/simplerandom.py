from const import *
import random

class SimpleRandom:
	def __init__(self): self.reset(0)

	def reset(self,player):
		self.player = player
		self.board = [[] for i in range(COLUMN_COUNT)] # innehåller 0,1,2...
		self.moves = [] # innehåller 0..6, dvs kolumnindex

	def print(self):
		print()
		for row in range(N-1,-1,-1):
			s = ''
			for col in range(M):
				if row < len(self.board[col]):
					s += str(self.board[col][row] % 2) + ' '
				else:
					s += '. '
			print(s)
		print('-'.join([str(move) for move in self.moves]),len(self.moves))

	def get_valid_locations(self):
		return [c for c in range(COLUMN_COUNT) if len(self.board[c]) < ROW_COUNT]

	def findMove(self):
		lst = self.get_valid_locations()
		return random.choice(lst)

	def move(self,col,piece):
		self.board[col].append(piece)
		self.moves.append(col)

	def winning_move(self,piece): # piece in [0,1]
		if len(self.moves) < 7: return False
		for dr,dc in [[0,1],[1,0],[1,1],[1,-1]]:
			if self.calc(dr,dc,piece): return True
		return False

######

	def load(self,moves):
		self.reset()
		for move in moves:
			self.move(move)

	def calc(self,dr,dc,piece):
		def helper(dr,dc):
			r = row + dr
			c = col + dc
			res = 0
			while 0 <= r and r < N and 0 <= c and c < M and r < len(self.board[c]) and self.board[c][r] % 2 == piece:
				res += 1
				r += dr
				c += dc
			return res
		col = self.moves[-1]
		row = len(self.board[col]) - 1
		return 1 + helper(dr,dc) + helper(-dr,-dc) >= WINSIZE

