import random
import numpy as np
import math
import time
import copy

ROW_COUNT = 6
COLUMN_COUNT = 7
N = ROW_COUNT
M = COLUMN_COUNT

PLAYER = 0
AI = 1

EMPTY = 0
PLAYER_PIECE = 1
AI_PIECE = 2

WINDOW_LENGTH = 4
WINSIZE = 4

class Random:
	def __init__(self): self.reset(0)

	def reset(self,player):
		self.player = player
		self.board = [[] for i in range(COLUMN_COUNT)]
		self.moves = []

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
		print('-'.join([str(move) for move in self.moves]))

	def get_valid_locations(self):
		return [c for c in range(COLUMN_COUNT) if len(self.board[c]) < ROW_COUNT]

	def findMove(self):
		lst = self.get_valid_locations()
		if len(lst)==0: return None
		return random.choice(lst)

	def move(self,col):
		self.board[col].append(len(self.moves))
		self.moves.append(col)

	def load(self,moves):
		self.reset(self.player)
		for move in moves:
			self.move(move)

	def calc(self,dr,dc):
		def helper():
			r = row + dr
			c = col + dc
			res = 0
			while 0 <= r and r < N and 0 <= c and c < M and r < len(self.board[c]) and self.board[c][r]%2 == marker:
				res += 1
				r += dr
				c += dc
			return res
		col = self.moves[-1]
		marker = 1 - len(self.moves) % 2
		row = len(self.board[col]) - 1
		return 1 + helper() >= WINSIZE

	def winning_move(self):
		if len(self.moves) <= 2 * (WINSIZE-1) : return False
		if len(self.moves) % 2 == self.player : return False
		for dr in [-1,0,1]:
			for dc in [-1,0,1]:
				if dr!=0 or dc!=0:
					if self.calc(dr,dc) : return True
		return False

class MonteCarlo:

	def __init__(self,seconds):
		self.seconds = seconds
		self.reset(0)

	def reset(self,player):
		self.player = player
		self.board = [[] for i in range(COLUMN_COUNT)]
		self.moves = []

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
		print('-'.join([str(move) for move in self.moves]))

	def copy(self):
		b = MonteCarlo(self.seconds)
		b.player = self.player
		b.board = copy.deepcopy(self.board)
		b.moves = copy.deepcopy(self.moves)
		return b

	def move(self,col):
		self.board[col].append(len(self.moves))
		self.moves.append(col)

	def get_valid_locations(self):
		return [c for c in range(COLUMN_COUNT) if len(self.board[c]) < ROW_COUNT]

	def simulate(self):
		while True:
			lst = self.get_valid_locations()
			if len(lst)==0:
				return None
			col = random.choice(lst)
			self.move(col)
			if self.winning_move():
				return 1-len(self.moves) % 2

	def findMove(self):
		lst = self.get_valid_locations()
		if len(lst) == 0: return None

		cands = [[0, m] for m in lst]
		if len(cands) == 1: return cands[0][1]

		end = time.process_time() + self.seconds
		while time.process_time() < end:
			for cand in cands:
				col = cand[1]
				b = self.copy()
				b.move(col)
				if b.winning_move(): return cand[1]
				player = b.simulate()
				if player == b.player:
					cand[0] += 1
				else:
					if player != None: cand[0] -=1

		cand = max(cands)
		return cand[1]

	def calc(self,dr,dc):
		def helper(dr,dc):
			r = row + dr
			c = col + dc
			res = 0
			while 0 <= r and r < N and 0 <= c and c < M and r < len(self.board[c]) and self.board[c][r]%2 == marker:
				res += 1
				r += dr
				c += dc
			return res
		col = self.moves[-1]
		marker = 1 - len(self.moves) % 2
		row = len(self.board[col]) - 1
		return 1 + helper(dr,dc) + helper(-dr,-dc) >= WINSIZE

	def winning_move(self):
		if len(self.moves) <= 2 * (WINSIZE-1):	return False
		for dr,dc in [[0,1],[1,0],[1,1],[1,-1]]:
			if self.calc(dr,dc):	return True
		return False

class Minimax:

	def __init__(self,depth):
		self.depth = depth
		self.reset(0)

	def reset(self,player):
		self.player = player+1  # 1 or 2
		self.board = np.zeros((ROW_COUNT,COLUMN_COUNT))
		self.moves = []

	def copy(self):
		b = Minimax(self.depth)
		b.player = self.player
		b.board = copy.deepcopy(self.board)
		b.moves = copy.deepcopy(self.moves)
		return b

	def findMove(self):
		return self.minimax(self.depth, -math.inf, math.inf, True)[0]

	def minimax(self, depth, alpha, beta, maximizingPlayer):
		valid_locations = self.get_valid_locations()
		is_terminal = self.is_terminal_node()
		if depth == 0 or is_terminal:
			if is_terminal:
				if self.winning_move():
					if 1 + len(self.moves) % 2 == self.player:
						return (None, 1000000)
					else:
						return (None, -1000000)
				else:  # Game is over, no more valid moves
					return (None, 0)
			else:  # Depth is zero
				return (None, self.score_position(AI_PIECE))
		if maximizingPlayer:
			value = -math.inf
			column = random.choice(valid_locations)
			for col in valid_locations:
				row = self.get_next_open_row(col)
				b_copy = self.copy()
				b_copy.drop_piece(row, col, AI_PIECE)
				new_score = b_copy.minimax(depth - 1, alpha, beta, False)[1]
				if new_score > value:
					value = new_score
					column = col
				alpha = max(alpha, value)
				if alpha >= beta:
					break
			return column, value

		else:  # Minimizing player
			value = math.inf
			column = random.choice(valid_locations)
			for col in valid_locations:
				row = self.get_next_open_row(col)
				b_copy = self.copy()
				b_copy.drop_piece(row, col, PLAYER_PIECE)
				new_score = b_copy.minimax(depth - 1, alpha, beta, True)[1]
				if new_score < value:
					value = new_score
					column = col
				beta = min(beta, value)
				if alpha >= beta:
					break
			return column, value

	def evaluate_window(self, window, piece):
		score = 0
		opp_piece = PLAYER_PIECE
		if piece == PLAYER_PIECE:
			opp_piece = AI_PIECE

		if window.count(piece) == 4:
			score += 100
		elif window.count(piece) == 3 and window.count(EMPTY) == 1:
			score += 5
		elif window.count(piece) == 2 and window.count(EMPTY) == 2:
			score += 2
		if window.count(opp_piece) == 3 and window.count(EMPTY) == 1:
			score -= 4

		return score

	def score_position(self, piece):
		board = self.board
		score = 0

		## Score center column
		center_array = [int(i) for i in list(board[:, COLUMN_COUNT // 2])]
		center_count = center_array.count(piece)
		score += center_count * 3

		## Score Horizontal
		for r in range(ROW_COUNT):
			row_array = [int(i) for i in list(board[r, :])]
			for c in range(COLUMN_COUNT - 3):
				window = row_array[c:c + WINDOW_LENGTH]
				score += self.evaluate_window(window, piece)

		## Score Vertical
		for c in range(COLUMN_COUNT):
			col_array = [int(i) for i in list(board[:, c])]
			for r in range(ROW_COUNT - 3):
				window = col_array[r:r + WINDOW_LENGTH]
				score += self.evaluate_window(window, piece)

		## Score posiive sloped diagonal
		for r in range(ROW_COUNT - 3):
			for c in range(COLUMN_COUNT - 3):
				window = [board[r + i][c + i] for i in range(WINDOW_LENGTH)]
				score += self.evaluate_window(window, piece)

		for r in range(ROW_COUNT - 3):
			for c in range(COLUMN_COUNT - 3):
				window = [board[r + 3 - i][c + i] for i in range(WINDOW_LENGTH)]
				score += self.evaluate_window(window, piece)

		return score

	def drop_piece(self, row, col, piece):
		self.board[row][col] = piece
		self.moves.append(col)

	def move(self, col):
		row = self.get_next_open_row(col)
		self.board[row][col] = 1 + len(self.moves) % 2
		self.moves.append(col)

	def is_valid_location(self, col): return self.board[ROW_COUNT - 1][col] == 0

	def get_next_open_row(self, col):
		for r in range(ROW_COUNT):
			#print(self.board[r][col])
			if self.board[r][col] == 0: return r

	def print(self):
		print()
		for r in range(ROW_COUNT):
			row = self.board[ROW_COUNT-1-r]
			print(' '.join([['.','0','1'][int(cell)] for cell in row]))
			#print(row)
		print('-'.join([str(move) for move in self.moves]))

	def winning_move(self):
		piece = 1 + len(self.moves) % 2
		board = self.board
		# Check horizontal locations for win
		for c in range(COLUMN_COUNT - 3):
			for r in range(ROW_COUNT):
				if board[r][c] == piece and board[r][c + 1] == piece and board[r][c + 2] == piece and board[r][c + 3] == piece:
					return True

		# Check vertical locations for win
		for c in range(COLUMN_COUNT):
			for r in range(ROW_COUNT - 3):
				if board[r][c] == piece and board[r + 1][c] == piece and board[r + 2][c] == piece and board[r + 3][c] == piece:
					return True

		# Check positively sloped diaganols
		for c in range(COLUMN_COUNT - 3):
			for r in range(ROW_COUNT - 3):
				if board[r][c] == piece and board[r + 1][c + 1] == piece and board[r + 2][c + 2] == piece and board[r + 3][
							c + 3] == piece:
					return True

		# Check negatively sloped diaganols
		for c in range(COLUMN_COUNT - 3):
			for r in range(3, ROW_COUNT):
				if board[r][c] == piece and board[r - 1][c + 1] == piece and board[r - 2][c + 2] == piece and board[r - 3][
							c + 3] == piece:
					return True

	def is_terminal_node(self):
		return self.winning_move() or self.winning_move() or len(self.get_valid_locations()) == 0

	def get_valid_locations(self):
		valid_locations = []
		for col in range(COLUMN_COUNT):
			if self.is_valid_location(col):
				valid_locations.append(col)
		return valid_locations

	def pick_best_move(self, piece):
		valid_locations = self.get_valid_locations()
		best_score = -10000
		best_col = random.choice(valid_locations)
		for col in valid_locations:
			row = self.get_next_open_row(col)
			temp_board = self.copy()
			temp_board.drop_piece(row, col, piece)
			score = temp_board.score_position(piece)
			if score > best_score:
				best_score = score
				best_col = col
		return best_col

def fight(n,strategy1,strategy2):

	stats = [0,0,0,0]

	for i in range(n):
		turn = 0 #random.randint(0,1)
		strategy1.reset(turn)
		strategy2.reset(1-turn)

		while True:

			start = time.perf_counter()

			if turn == 0:
				col = strategy1.findMove()
				if col == None: break
				strategy1.move(col)
				strategy2.move(col)
				if strategy1.winning_move():
					stats[turn] += 1
					break

			else: # turn == 1
				col = strategy2.findMove()
				if col == None: break
				strategy1.move(col)
				strategy2.move(col)
				if strategy2.winning_move():
					stats[turn] += 1
					break

			stats[2 + turn] += time.perf_counter() - start
			strategy1.print()

			turn = 1-turn

		#print('bb')
		strategy1.print()
		print(stats[0],stats[1],"{:.6f}".format(stats[2]),"{:.6f}".format(stats[3]))

fight(1, MonteCarlo(1), Minimax(5)) # 1000 0 2.458464 0.004864
#fight(1, MonteCarlo(1), Random())

# r = Random()
# r.load([0,6,1,5,2,4,3])
# assert r.winning_move() == True
# r.reset(1)
# r.load([0,6,1,5,2,4,3])
# assert r.winning_move() == False

#fight(1000, Random(), Random())
#fight(100, MonteCarlo(0.00001), Random()) # Vinner 99-100 av 100, oberoende av tid?
#fight(1, MonteCarlo(0.1),MonteCarlo(0.1)) # Vinner 99-100 av 100, oberoende av tid?
