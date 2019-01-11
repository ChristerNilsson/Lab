# import random
# import sys
# import pygame
# import time
#
# # board innehåller sekvensnummer som borjar med 0
# # moves innehåller kolumnnummer som borjar med 0
#
# INF = 999999
#
# BLUE  = (0, 0, 255)
# BLACK = (0, 0, 0)
# RED   = (255, 0, 0)
# YELLOW = (255, 255, 0)
#
# ROW_COUNT = 6
# COL_COUNT = 7
# M = ROW_COUNT
# N = COL_COUNT
#
# DEPTH = 5 #5
#
# EMPTY = -1
# PLAYER = 0
# AI = 1
#
# STARTER = 0
#
# WINDOW_LENGTH = 4
# WINSIZE = 4
#
# class Board:
# 	def __init__(self,moves=[]):
# 		self.board = [[] for c in range(COL_COUNT)]
# 		self.moves = []
# 		for move in moves:
# 			self.drop_piece(move)
#
# 	def copy(self):
# 		b = Board()
# 		b.board = [col.copy() for col in self.board]
# 		b.moves = self.moves.copy()
# 		return b
#
# 	def drop_piece(self, col):
# 		piece = len(self.moves)
# 		self.board[col].append(piece)
# 		self.moves.append(col)
#
# 	def calc(self,dr,dc):
# 		def helper():
# 			r = row + dr
# 			c = col + dc
# 			res = 0
# 			while 0 <= r and r < M and 0 <= c and c < N and r < len(self.board[c]) and self.board[c][r] % 2 == marker:
# 				res += 1
# 				r += dr
# 				c += dc
# 			return res
# 		col = self.moves[-1]
# 		marker = 1 - len(self.moves) % 2
# 		row = len(self.board[col])-1
# 		return 1 + helper() >= WINSIZE
#
# 	def winning_move(self,piece): # done
# 		if len(self.moves) <= 2 * (WINSIZE-1) : return False
# 		if len(self.moves) % 2 == piece : return False
# 		for dr in [-1,0,1]:
# 			for dc in [-1,0,1]:
# 				if dr!=0 or dc!=0:
# 					if self.calc(dr,dc) : return True
# 		return False
#
# 	def print(self):
# 		for c in range(COL_COUNT):
# 			print(' '.join([str(self.board[c])]))
# 		print(self.moves)
# 		print()
#
# 	def draw(self):
# 		b = self.board
# 		SS = SQUARESIZE
# 		pygame.draw.rect(screen, BLUE, (0, SS, COL_COUNT*SS, ROW_COUNT*SS))
# 		for c in range(COL_COUNT):
# 			for r in range(ROW_COUNT):
# 				pygame.draw.circle(screen, BLACK, ((c * SS + SS//2), height-(r * SS + SS//2)),RADIUS)
#
# 		for c in range(COL_COUNT):
# 			for r in range(len(b[c])):
# 				color = [RED,YELLOW][b[c][r]%2]
# 				x = (c * SS + SS//2)
# 				y = height-(r * SS + SS//2)
# 				pygame.draw.circle(screen, color, (x, y),RADIUS)
# 				s = str(b[c][r])
# 				label = myfont.render(s, 1, BLACK)
# 				if len(s)==1:
# 					screen.blit(label, (x-0.15*SQUARESIZE, y-0.25*SQUARESIZE))
# 				else:
# 					screen.blit(label, (x-0.30*SQUARESIZE, y-0.25*SQUARESIZE))
#
# 		pygame.display.update()
#
# 	def is_valid_location(self, col): return len(self.board[col]) != ROW_COUNT
# 	def get_valid_locations(self): return [col for col in range(COL_COUNT) if self.is_valid_location(col)]
#
# 	def pick_best_move(self,piece):
# 		valid_locations = self.get_valid_locations()
# 		best_score = -9999
# 		best_col = random.choice(valid_locations)
# 		for col in valid_locations:
# 			#row = board.get_next_open_row(col)
# 			temp_board = self.board.copy()
# 			temp_board.drop_piece(col, piece)
# 			score = temp_board.score_position(piece)
# 			if score > best_score:
# 				best_score = score
# 				best_col = col
# 		return best_col
#
# 	def is_terminal_node(self):
# 		return self.winning_move(PLAYER) or self.winning_move(AI) or len(self.get_valid_locations()) == 0
#
# 	def minimax(self, depth, alpha, beta, maximizingPlayer):
# 		valid_locations = self.get_valid_locations()
# 		is_terminal = self.is_terminal_node()
# 		if depth == 0 or is_terminal:
# 			if is_terminal:
# 				if self.winning_move(AI): return (None, 1000)
# 				elif self.winning_move(PLAYER): return (None, -1000)
# 				else: return (None, 0)
# 			else: return (None, self.score_position(AI))
# 		if maximizingPlayer:
# 			value = -INF
# 			column = random.choice(valid_locations)
# 			for col in valid_locations:
# 				b_copy = self.copy()
# 				b_copy.drop_piece(col) # , AI
# 				new_score = b_copy.minimax(depth - 1, alpha, beta, False)[1]
# 				if new_score > value:
# 					value = new_score
# 					column = col
# 				alpha = max(alpha, value)
# 				if alpha >= beta: break
# 			return column, value
#
# 		else:  # Minimizing player
# 			value = INF
# 			column = random.choice(valid_locations)
# 			for col in valid_locations:
# 				b_copy = self.copy()
# 				b_copy.drop_piece(col) # , PLAYER
# 				new_score = b_copy.minimax(depth - 1, alpha, beta, True)[1]
# 				if new_score < value:
# 					value = new_score
# 					column = col
# 				beta = min(beta, value)
# 				if alpha >= beta: break
# 			return column, value
#
# 	def count(self,window,piece): return window.count(piece)
#
# 	def evaluate(self, window, piece): # window innehåller -1 0 eller 1
# 		score = 0
# 		opp_piece = PLAYER
# 		if piece == PLAYER: opp_piece = AI
# 		if self.count(window,piece) == 4: score += 100
# 		elif self.count(window,piece) == 3 and self.count(window,EMPTY) == 1: score += 5
# 		elif self.count(window,piece) == 2 and self.count(window,EMPTY) == 2: score += 2
# 		if self.count(window,opp_piece) == 3 and self.count(window,EMPTY) == 1: score -= 4
# 		#print('evaluate',piece,score,window)
# 		return score
#
# 	def score_position(self, piece):
# 		score = 0
# 		b = self.board
#
# 		# Score center column
# 		for cell in b[COL_COUNT // 2]:
# 			if cell % 2 == piece : score += 3
#
# 		for r in range(ROW_COUNT):		# Score Horizontal
# 			row_array = [] # innehåller -1,0,1
# 			for col in b:
# 				if r < len(col):
# 					row_array.append(col[r]%2)
# 				else:
# 					row_array.append(EMPTY)
# 			for c in range(COL_COUNT - 3):
# 				window = row_array[c:c + WINDOW_LENGTH]
# 				score += self.evaluate(window, piece)
#
# 		for col in b: 		# Score Vertical
# 			row_array = [] # innehåller -1,0,1
# 			for r in range(ROW_COUNT):
# 				if r < len(col):
# 					row_array.append(col[r] % 2)
# 				else:
# 					row_array.append(EMPTY)
# 			for r in range(ROW_COUNT - 3):
# 				window = row_array[r:r + WINDOW_LENGTH]
# 				score += self.evaluate(window, piece)
#
# 		for r in range(ROW_COUNT - 3): # Score positive sloped diagonal
# 			for c in range(COL_COUNT - 3):
# 				window = []
# 				for i in range(WINDOW_LENGTH):
# 					if c+i < COL_COUNT and r+i < len(b[c+i]):
# 						window.append(b[c+i][r+i]%2) # = [b[c + i][r + i] for i in range(WINDOW_LENGTH)]
# 					else:
# 						window.append(EMPTY)
# 				score += self.evaluate(window, piece)
#
# 		for r in range(ROW_COUNT - 3): # Score negative sloped diagonal
# 			for c in range(COL_COUNT - 3):
# 				window = []
# 				for i in range(WINDOW_LENGTH):
# 					if c+i < COL_COUNT and r+3-i < len(b[c+i]):
# 						window.append(b[c+i][r+3-i]%2) # = [b[c + i][r + i] for i in range(WINDOW_LENGTH)]
# 					else:
# 						window.append(EMPTY)
# 				score += self.evaluate(window, piece)
#
# 		return score
#
#
# # board = Board([2,3])
# # assert board.count([0,0,0,0],1) == 0
# # assert board.count([0,1,0,1],1) == 2
# # assert board.count([1,1,1,1],1) == 4
# #
# # assert board.evaluate([0,0,0,0],1) == 0
# # assert board.evaluate([0,1,0,0],1) == 0
# # assert board.evaluate([-1,1,-1,1],1) == 2
# # assert board.evaluate([1,-1,1,1],1) == 5
# # assert board.evaluate([1,1,1,1],1) == 100
# # assert board.evaluate([0,-1,0,0],1) == -4
# #
# # assert board.score_position(1) == 3
# #
# # board = Board([3,3,3,3]); assert board.score_position(1) == 6
# # board = Board([0,1,0,1,0,1]); assert board.score_position(1) == 3
# # board = Board([0,1,0,1,0,1]); assert board.score_position(0) == 3
# #
# # board = Board([0,1,1,0,2,2,2]); assert board.score_position(0) == 7
# # board = Board([6,5,5,6,4,4,4]); assert board.score_position(0) == 7
# #
# #board = Board([0,1,1,0,2,2,2]); assert board.score_position(1) == -2
# #board = Board([6,5,5,6,4,4,4]); assert board.score_position(1) == -2
#
# STARTER = 0
#
# board = Board([0,6,1,5,2,4,3]); assert board.winning_move(0) == True # hor
# board = Board([0,6,1,5,2,4,3]); assert board.winning_move(1) == False # hor
#
# board = Board([0,6,0,6,0,6,0]); assert board.winning_move(0) == True # ver
# board = Board([0,6,0,6,0,6,0]); assert board.winning_move(1) == False # ver
#
# board = Board([0,1,1,0,2,2,2]); assert board.winning_move(1) == False # diagonal
# board = Board([6,5,5,6,4,4,4]); assert board.winning_move(1) == False
# board = Board([0,1,1,0,2,2,2]); assert board.winning_move(0) == False
# board = Board([6,5,5,6,4,4,4]); assert board.winning_move(0) == False
#
# board = Board([0,1,1,0,2,2,2,3,3,3,3]); assert board.winning_move(0) == True # diagonal
# board = Board([0,1,1,0,2,2,2,3,3,3,3]); assert board.winning_move(1) == False
# board = Board([6,5,5,6,4,4,4,3,3,3,3]); assert board.winning_move(0) == True
# board = Board([6,5,5,6,4,4,4,3,3,3,3]); assert board.winning_move(1) == False
#
# #sys.exit()
#
# board = Board()
# board.print()
# game_over = False
#
# pygame.init()
#
# SQUARESIZE = 100
#
# width = COL_COUNT * SQUARESIZE
# height = (ROW_COUNT + 1) * SQUARESIZE
#
# size = (width, height)
#
# RADIUS = SQUARESIZE // 2 - 5
#
# screen = pygame.display.set_mode(size)
# board.draw()
# pygame.display.update()
#
# myfont = pygame.font.SysFont("monospace", 50)
#
# turn = 0 #random.randint(PLAYER, AI)
# STARTER = turn
#
# while not game_over:
#
# 	for event in pygame.event.get():
# 		if event.type == pygame.QUIT: sys.exit()
#
# 		if event.type == pygame.MOUSEMOTION:
# 			pygame.draw.rect(screen, BLACK, (0, 0, width, SQUARESIZE))
# 			posx = event.pos[0]
# 			if turn == PLAYER: pygame.draw.circle(screen, RED, (posx, SQUARESIZE // 2), RADIUS)
#
# 		pygame.display.update()
#
# 		if event.type == pygame.MOUSEBUTTONDOWN:
# 			pygame.draw.rect(screen, BLACK, (0, 0, width, SQUARESIZE))
# 			if turn == PLAYER:
# 				posx = event.pos[0]
# 				col = posx // SQUARESIZE
#
# 				if board.is_valid_location(col):
# 					board.drop_piece(col)
#
# 					if board.winning_move(PLAYER):
# 						label = myfont.render("Human wins!!", 1, RED)
# 						screen.blit(label, (40, 10))
# 						game_over = True
#
# 					turn = 1 - turn
# 					board.print()
# 					board.draw()
#
# 	# Ask for Player 2 Input
# 	if turn == AI and not game_over:
#
# 		start = time.process_time()
# 		col, minimax_score = board.minimax(DEPTH, -INF, INF, True)
# 		print(time.process_time()-start)
#
# 		if board.is_valid_location(col):
# 			board.drop_piece(col) # , AI
#
# 			if board.winning_move(AI): # AI
# 				label = myfont.render("Computer wins!!", 1, YELLOW)
# 				screen.blit(label, (40, 10))
# 				game_over = True
#
# 			turn = 1 - turn
# 			board.print()
# 			board.draw()
#
# 	if game_over: pygame.time.wait(30000)
