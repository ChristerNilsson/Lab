# from const import *
# import random
# import math
# import copy
#
# class Minimax:
#
# 	def __init__(self,depth):
# 		self.depth = depth
# 		self.reset(0)
#
# 	def reset(self,player):
# 		self.player = player
# 		self.bd = [[EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY] for i in range(ROW_COUNT)]
# 		self.moves = []
#
# 	def move(self,col,piece):
# 		row = self.get_next_open_row(col)
# 		self.drop_piece(row, col, piece)
#
# 	def drop_piece(self, row, col, piece):
# 		self.bd[row][col] = piece
# 		self.moves.append(col)
#
# 	def findMove(self): return self.minimax(self.depth, -math.inf, math.inf, True)[0]
#
# 	def winning_move(self, piece):  # piece in [0,1]
# 		def check(r, c):
# 			cell = self.bd[r][c]
# 			if cell == EMPTY: return cell
# 			return cell % 2
#
# 		for c in range(COLUMN_COUNT - 3): # Check horizontal locations for win
# 			for r in range(ROW_COUNT):
# 				if check(r,c)==piece and check(r,c+1)==piece and check(r,c+2)==piece and check(r,c+3)==piece:
# 					return True
#
# 		for c in range(COLUMN_COUNT):			# Check vertical locations for win
# 			for r in range(ROW_COUNT - 3):
# 				if check(r, c)==piece and check(r+1, c)==piece and check(r+2,c)==piece and check(r+3,c)==piece:
# 					return True
#
# 		for c in range(COLUMN_COUNT - 3):			# Check positively sloped diaganols
# 			for r in range(ROW_COUNT - 3):
# 				if check(r,c)==piece and check(r+1, c+1)==piece and check(r+2, c+2)==piece and check(r+3,c+3)==piece:
# 					return True
#
# 		for c in range(COLUMN_COUNT - 3):			# Check negatively sloped diaganols
# 			for r in range(3, ROW_COUNT):
# 				if check(r,c)==piece and check(r-1, c+1)==piece and check(r-2, c+2)==piece and check(r-3,c+3)==piece:
# 					return True
#
# 	def print(self):
# 		print()
# 		for r in range(ROW_COUNT-1,-1,-1):
# 			s = ''
# 			for c in range(COLUMN_COUNT):
# 				cell = int(self.bd[r][c])
# 				s += '. ' if cell==EMPTY else ['0 ','1 '][cell%2]
# 				#s += '  .' if cell==EMPTY else str(cell).rjust(3)
# 			print(s)
# 		print('-'.join([str(move) for move in self.moves]),len(self.moves))
#
# 	######
#
# 	def copy(self):
# 		b = Minimax(self.depth)
# 		b.player = self.player
# 		b.bd = copy.deepcopy(self.bd)
# 		b.moves = self.moves.copy()
# 		return b
#
# 	def is_valid_location(self, col): return self.bd[ROW_COUNT - 1][col] == EMPTY
#
# 	def get_next_open_row(self, col):
# 		for r in range(ROW_COUNT):
# 			if self.bd[r][col] == EMPTY:
# 				return r
#
# 	def evaluate_window(self, window, piece):
# 		score = 0
# 		opp_piece = PLAYER_PIECE
# 		if piece == PLAYER_PIECE:opp_piece = AI_PIECE
# 		if window.count(piece) == 4: score += 100
# 		elif window.count(piece) == 3 and window.count(EMPTY) == 1: score += 5
# 		elif window.count(piece) == 2 and window.count(EMPTY) == 2: score += 2
# 		if window.count(opp_piece) == 3 and window.count(EMPTY) == 1: score -= 4
# 		return score
#
# 	def score_position(self, piece):
# 		score = 0
# 		center_array = [self.bd[row][COLUMN_COUNT // 2] for row in range(ROW_COUNT)]
# 		center_count = center_array.count(piece)
# 		score += center_count * 3
#
# 		for r in range(ROW_COUNT):			## Score Horizontal
# 			row_array = self.bd[r]
# 			for c in range(COLUMN_COUNT - 3):
# 				window = row_array[c:c + WINDOW_LENGTH]
# 				score += self.evaluate_window(window, piece)
#
# 		for c in range(COLUMN_COUNT):			## Score Vertical
# 			col_array = [self.bd[row][c] for row in range(ROW_COUNT)]
# 			for r in range(ROW_COUNT - 3):
# 				window = col_array[r:r + WINDOW_LENGTH]
# 				score += self.evaluate_window(window, piece)
#
# 		for r in range(ROW_COUNT - 3):			## Score positive sloped diagonal
# 			for c in range(COLUMN_COUNT - 3):
# 				window = [self.bd[r+i][c+i] for i in range(WINDOW_LENGTH)]
# 				score += self.evaluate_window(window, piece)
#
# 		for r in range(ROW_COUNT - 3):   ## Score negative sloped diagonal
# 			for c in range(COLUMN_COUNT - 3):
# 				window = [self.bd[r+3-i][c+i] for i in range(WINDOW_LENGTH)]
# 				score += self.evaluate_window(window, piece)
#
# 		return score
#
# 	def is_terminal_node(self):
# 		return self.winning_move(PLAYER_PIECE) or self.winning_move(AI_PIECE) or len(self.get_valid_locations()) == 0
#
# 	def minimax(self, depth, alpha, beta, maximizingPlayer):
#
# 		valid_locations = self.get_valid_locations()
# 		is_terminal = self.is_terminal_node()
# 		if depth == 0 or is_terminal:
# 			if is_terminal:
# 				if self.winning_move(AI_PIECE):return (None, 1000000)
# 				elif self.winning_move(PLAYER_PIECE):return (None, -1000000)
# 				else: return (None, 0)
# 			else: return (None, self.score_position(AI_PIECE))
#
# 		if maximizingPlayer:
# 			value = -math.inf
# 			column = random.choice(valid_locations)
# 			for col in valid_locations:
# 				row = self.get_next_open_row(col)
# 				b_copy = self.copy()
# 				b_copy.drop_piece(row, col, AI_PIECE)
# 				new_score = b_copy.minimax(depth - 1, alpha, beta, False)[1]
# 				if new_score > value:
# 					value = new_score
# 					column = col
# 				alpha = max(alpha, value)
# 				if alpha >= beta: break
# 			return column, value
#
# 		else:  # Minimizing player
# 			value = math.inf
# 			column = random.choice(valid_locations)
# 			for col in valid_locations:
# 				row = self.get_next_open_row(col)
# 				b_copy = self.copy()
# 				b_copy.drop_piece(row, col, PLAYER_PIECE)
# 				new_score = b_copy.minimax(depth - 1, alpha, beta, True)[1]
# 				if new_score < value:
# 					value = new_score
# 					column = col
# 				beta = min(beta, value)
# 				if alpha >= beta: break
# 			return column, value
#
# 	def get_valid_locations(self):
# 		return [c for c in range(COLUMN_COUNT) if self.is_valid_location(c)]
