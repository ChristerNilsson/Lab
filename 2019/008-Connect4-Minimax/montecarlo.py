# from const import *
# import copy
# import time
# import random
#
# class MonteCarlo:
#
# 	def __init__(self,seconds):
# 		self.seconds = seconds
# 		self.reset(0)
#
# 	def reset(self,player):
# 		self.player = player # used only for tweaking
# 		self.board = [[] for i in range(COLUMN_COUNT)]
# 		self.moves = []
#
# 	def print(self):
# 		print()
# 		for row in range(N-1,-1,-1):
# 			s = ''
# 			for col in range(M):
# 				if row < len(self.board[col]):
# 					s += str(self.board[col][row] % 2) + ' '
# 				else:
# 					s += '. '
# 			print(s)
# 		print('-'.join([str(move) for move in self.moves]))
#
# 	def copy(self):
# 		b = MonteCarlo(self.seconds)
# 		b.player = self.player
# 		b.board = copy.deepcopy(self.board)
# 		b.moves = self.moves.copy()
# 		return b
#
# 	def move(self,col,piece):
# 		self.board[col].append(piece)
# 		self.moves.append(col)
#
# 	def get_valid_locations(self):
# 		return [c for c in range(COLUMN_COUNT) if len(self.board[c]) < ROW_COUNT]
#
# 	def simulate(self):
# 		while True:
# 			lst = self.get_valid_locations()
# 			if len(lst)==0: return None # draw
# 			col = random.choice(lst)
# 			self.move(col,len(self.moves)%2)
# 			if self.winning_move(len(self.moves)%2): return len(self.moves)%2
#
# 	def findMove(self):
# 		lst = self.get_valid_locations()
# 		assert len(lst) > 0 #: return None # draw
#
# 		cands = [[0, m] for m in lst]
# 		if len(cands) == 1: return cands[0][1]
#
# 		end = time.process_time() + self.seconds
# 		while time.process_time() < end:
# 			for cand in cands:
# 				col = cand[1]
# 				b = self.copy()
# 				piece = len(self.moves)%2
# 				b.move(col,piece)
# 				if b.winning_move(piece):
# 					if piece == 0 : cand[0] += 1
# 					if piece == 1 : cand[0] -= 1
# 				else:
# 					player = b.simulate()
# 					if player == 0: cand[0] += 1
# 					if player == 1: cand[0] -= 1
#
# 		cand = max(cands)
# 		print(cands,cand)
#
# 		return cand[1]
#
# 	def calc(self,dr,dc,piece):
# 		def helper(dr,dc):
# 			r = row + dr
# 			c = col + dc
# 			res = 0
# 			while 0 <= r and r < N and 0 <= c and c < M and r < len(self.board[c]) and self.board[c][r]%2 == piece:
# 				res += 1
# 				r += dr
# 				c += dc
# 			return res
# 		col = self.moves[-1]
# 		row = len(self.board[col]) - 1
# 		return 1 + helper(dr,dc) + helper(-dr,-dc) >= WINSIZE
#
# 	def winning_move(self,piece):
# 		for dr,dc in [[0,1],[1,0],[1,1],[1,-1]]:
# 			if self.calc(dr,dc,piece): return True
# 		return False
