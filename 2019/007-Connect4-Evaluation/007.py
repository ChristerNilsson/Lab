import numpy as np
import random
import pygame
import sys
import math

BLUE  = (0, 0, 255)
BLACK = (0, 0, 0)
RED   = (255, 0, 0)
YELLOW = (255, 255, 0)

ROW_COUNT = 6
COL_COUNT = 7
DEPTH = 5

PLAYER = 0
AI = 1

EMPTY = 0
PLAYER_PIECE = 1
AI_PIECE = 2

WINDOW_LENGTH = 4

class Board:
	def __init__(self): self.board = np.zeros((ROW_COUNT, COL_COUNT), dtype= np.int)

	def copy(self):
		b = Board()
		b.board = self.board.copy()
		return b

	def drop_piece(self, row, col, piece): self.board[row][col] = piece
	def is_valid_location(self, col): return self.board[ROW_COUNT - 1][col] == 0

	def get_next_open_row(self, col):
		for r in range(ROW_COUNT):
			if self.board[r][col] == 0:
				return r

	def winning_move(self, piece):
		b = self.board
		for c in range(COL_COUNT - 3): # Check horizontal locations for win
			for r in range(ROW_COUNT):
				if b[r][c] == piece and b[r][c+1] == piece and b[r][c+2] == piece and b[r][c+3] == piece:
					return True

		for c in range(COL_COUNT):		# Check vertical locations for win
			for r in range(ROW_COUNT - 3):
				if b[r][c] == piece and b[r+1][c] == piece and b[r+2][c] == piece and b[r+3][c] == piece:
					return True

		for c in range(COL_COUNT - 3):	# Check positively sloped diagonals
			for r in range(ROW_COUNT - 3):
				if b[r][c] == piece and b[r+1][c+1] == piece and b[r+2][c+2] == piece and b[r+3][c+3] == piece:
					return True

		for c in range(COL_COUNT - 3):	# Check negatively sloped diagonals
			for r in range(3, ROW_COUNT):
				if b[r][c] == piece and b[r-1][c+1] == piece and b[r-2][c+2] == piece and b[r-3][c+3] == piece:
					return True

	def print(self):
		for r in range(ROW_COUNT-1,-1,-1):
			print(' '.join([str(self.board[r][c]) for c in range(COL_COUNT)]))
		print()

	def draw(self):
		b = self.board
		SS = SQUARESIZE
		pygame.draw.rect(screen, BLUE, (0, SS, COL_COUNT*SS, ROW_COUNT*SS))
		for c in range(COL_COUNT):
			for r in range(ROW_COUNT):
				color = [BLACK,RED,YELLOW][int(b[r][c])]
				pygame.draw.circle(screen, color, ((c * SS + SS//2), height-(r * SS + SS//2)),RADIUS)
		pygame.display.update()

	def get_valid_locations(self):
		return [col for col in range(COL_COUNT) if self.is_valid_location(col)]

	def pick_best_move(self,piece):
		valid_locations = self.get_valid_locations()
		best_score = -999
		best_col = random.choice(valid_locations)
		for col in valid_locations:
			row = board.get_next_open_row(col)
			temp_board = self.board.copy()
			temp_board.drop_piece(row, col, piece)
			score = temp_board.score_position(piece)
			if score > best_score:
				best_score = score
				best_col = col
		return best_col

	def is_terminal_node(self):
		return self.winning_move(PLAYER_PIECE) or self.winning_move(AI_PIECE) or len(self.get_valid_locations()) == 0

	def minimax(self, depth, alpha, beta, maximizingPlayer):
		valid_locations = self.get_valid_locations()
		is_terminal = self.is_terminal_node()
		if depth == 0 or is_terminal:
			if is_terminal:
				if self.winning_move(AI_PIECE): return (None, 1000)
				elif self.winning_move(PLAYER_PIECE): return (None, -1000)
				else: return (None, 0)
			else: return (None, self.score_position(AI_PIECE))
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
				if alpha >= beta: break
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
				if alpha >= beta: break
			return column, value

	def evaluate(self, window, piece):
		score = 0
		opp_piece = PLAYER_PIECE
		if piece == PLAYER_PIECE: opp_piece = AI_PIECE
		if window.count(piece) == 4: score += 100
		elif window.count(piece) == 3 and window.count(EMPTY) == 1: score += 5
		elif window.count(piece) == 2 and window.count(EMPTY) == 2: score += 2
		if window.count(opp_piece) == 3 and window.count(EMPTY) == 1: score -= 4
		return score

	def score_position(self, piece):
		score = 0
		b = self.board
		## Score center column
		center_array = [int(i) for i in list(b[:, COL_COUNT // 2])]
		center_count = center_array.count(piece)
		score += center_count * 3

		## Score Horizontal
		for r in range(ROW_COUNT):
			row_array = [int(i) for i in list(b[r, :])]
			for c in range(COL_COUNT - 3):
				window = row_array[c:c + WINDOW_LENGTH]
				score += self.evaluate(window, piece)

		## Score Vertical
		for c in range(COL_COUNT):
			col_array = [int(i) for i in list(b[:, c])]
			for r in range(ROW_COUNT - 3):
				window = col_array[r:r + WINDOW_LENGTH]
				score += self.evaluate(window, piece)

		## Score posiive sloped diagonal
		for r in range(ROW_COUNT - 3):
			for c in range(COL_COUNT - 3):
				window = [b[r + i][c + i] for i in range(WINDOW_LENGTH)]
				score += self.evaluate(window, piece)

		for r in range(ROW_COUNT - 3):
			for c in range(COL_COUNT - 3):
				window = [b[r + 3 - i][c + i] for i in range(WINDOW_LENGTH)]
				score += self.evaluate(window, piece)

		return score

board = Board()
board.print()
game_over = False

pygame.init()

SQUARESIZE = 100

width = COL_COUNT * SQUARESIZE
height = (ROW_COUNT + 1) * SQUARESIZE

size = (width, height)

RADIUS = int(SQUARESIZE / 2 - 5)

screen = pygame.display.set_mode(size)
board.draw()
pygame.display.update()

myfont = pygame.font.SysFont("monospace", 75)

turn = random.randint(PLAYER, AI)

while not game_over:

	for event in pygame.event.get():
		if event.type == pygame.QUIT: sys.exit()

		if event.type == pygame.MOUSEMOTION:
			pygame.draw.rect(screen, BLACK, (0, 0, width, SQUARESIZE))
			posx = event.pos[0]
			if turn == PLAYER: pygame.draw.circle(screen, RED, (posx, int(SQUARESIZE / 2)), RADIUS)

		pygame.display.update()

		if event.type == pygame.MOUSEBUTTONDOWN:
			pygame.draw.rect(screen, BLACK, (0, 0, width, SQUARESIZE))
			# print(event.pos)
			# Ask for Player 1 Input
			if turn == PLAYER:
				posx = event.pos[0]
				col = int(math.floor(posx / SQUARESIZE))

				if board.is_valid_location(col):
					row = board.get_next_open_row(col)
					board.drop_piece(row, col, PLAYER_PIECE)

					if board.winning_move(PLAYER_PIECE):
						label = myfont.render("Player 1 wins!!", 1, RED)
						screen.blit(label, (40, 10))
						game_over = True

					turn = 1 - turn

					board.print()
					board.draw()

	# Ask for Player 2 Input
	if turn == AI and not game_over:

		# col = random.randint(0, COL_COUNT-1)
		# col = pick_best_move(board, AI_PIECE)
		col, minimax_score = board.minimax(DEPTH, -math.inf, math.inf, True)

		if board.is_valid_location(col):
			# pygame.time.wait(500)
			row = board.get_next_open_row(col)
			board.drop_piece(row, col, AI_PIECE)

			if board.winning_move(AI_PIECE):
				label = myfont.render("Player 2 wins!!", 1, YELLOW)
				screen.blit(label, (40, 10))
				game_over = True

			board.print()
			board.draw()

			turn = 1 - turn

	if game_over: pygame.time.wait(3000)
