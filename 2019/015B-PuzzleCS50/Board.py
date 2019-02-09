from copy import deepcopy
from queue import Queue
from random import randint
import time

MAX_COL = 4
MAX_ROW = 4
SHUFFLE_MAGNITUDE = 5
ALFA = '•123456789ABCDEF'

class Board:

		def __init__(self):

				self.goal = [[1, 2, 3, 4],[5, 6, 7, 8],[9, 10, 11, 12],[13, 14, 15, 0]]

				self.board = deepcopy(self.goal)
				self.loc = [MAX_ROW - 1, MAX_COL - 1]
				self.moves = {0: self.move_up, 1: self.move_right, 2: self.move_down, 3: self.move_left}

		def __repr__(self):
				for row in range(MAX_ROW):
						for col in range(MAX_COL):
								print(ALFA[self.board[row][col]], end=" ")
						print()

				return ""

		def move(self, board, loc, r, c):

				# Prevent user from moving beyond edge of the board
				row,col = loc
				if row + r < 0 or row + r > 3 or col + c < 0 or col + c > 3:
						return board, loc

				# For a legal move, swap the location of the empty space with that of the adjacent number
				board[row][col], board[row + r][col + c] = board[row + r][col + c], board[row][col]

				# Update the location of the empty space
				loc[0] += r
				loc[1] += c

				return board, loc

		def move_up(self, board, loc):
				return self.move(board, loc, -1, 0)

		def move_right(self, board, loc):
				return self.move(board, loc, 0, 1)

		def move_down(self, board, loc):
				return self.move(board, loc, 1, 0)

		def move_left(self, board, loc):
				return self.move(board, loc, 0, -1)

		def refresh(self):
				print(self)
				if self.goal == self.board:
						print("Congrats! You won! ")
						return False

				return True

		def inside(self,m):
				r,c = [[-1,0],[0,1],[1,0],[0,-1]][m]
				row,col = self.loc
				return 0 <= row+r and row+r <= 3 and 0 <= col+c and col+c <= 3

		def shuffle(self):
				lst = [-99]
				for i in range(SHUFFLE_MAGNITUDE):
						cands = [m for m in range(4) if self.inside(m) and abs(m-lst[-1]) != 2]
						i = randint(0, len(cands)-1)
						m = cands[i]
						lst.append(m)
						self.moves[m](self.board, self.loc)
				print(lst)

		def solve(self):
				"""Solves the game using breadth-first search"""
				#self.board = deepcopy(self.goal)

				def successors(board, loc):
						b_lst = [deepcopy(board), deepcopy(board), deepcopy(board), deepcopy(board)]
						loc_lst = [list(loc), list(loc), list(loc), list(loc)]
						b_lst[0], loc_lst[0] = self.move_up(b_lst[0], loc_lst[0])
						b_lst[1], loc_lst[1] = self.move_right(b_lst[1], loc_lst[1])
						b_lst[2], loc_lst[2] = self.move_down(b_lst[2], loc_lst[2])
						b_lst[3], loc_lst[3] = self.move_left(b_lst[3], loc_lst[3])

						return [[b_lst[0], loc_lst[0], 0], [b_lst[1], loc_lst[1], 1], [b_lst[2], loc_lst[2], 2], [b_lst[3], loc_lst[3], 3]]

				start = time.clock()
				# initialize searched set, fringe, and tree root
				searched = []
				fringe = Queue()
				root = self.board

				# add tree root to fringe
				fringe.put({"board": root, "loc": self.loc, "path": []})

				# search tree
				while True:

						# quit if no solution found
						if fringe.empty():
								return []

						# inspect current node
						node = fringe.get()

						# quit if node contains the goal
						if node["board"] == self.goal:
								print(node["path"])
								print(time.clock()-start)
								return node["path"]

						# add current node to searched set, put children in fringe
						if node["board"] not in searched:
								searched.append(node["board"])
								for child in successors(node["board"], node["loc"]):
										if child[0] not in searched:
												fringe.put({"board": child[0], "loc": child[1], "path": node["path"] + [child[2]]})
