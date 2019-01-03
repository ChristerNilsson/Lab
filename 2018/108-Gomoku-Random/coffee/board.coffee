N = 10
WINSIZE = 5 # number of markers to win

class Board

	constructor : (moves='') -> 
		@clear()
		for digit in moves
			@move parseInt digit
 
	copy : ->
		b = new Board()
		b.board = @board.slice() # 1D
		b.moves = @moves.slice() # 1D
		b.surr = @surr.slice() # 1D
		b

	extendSurr : -> # one step neighbours in eight directions 
		move = _.last @moves
		row = move // N
		col = move %% N
		for dr in [-1,0,1]
			for dc in [-1,0,1]
				if dr!=0 or dc!=0
					if 0<=row+dr<N and 0<=col+dc<N
						index = N*(row+dr)+col+dc 
						if @board[index] == 0 and index not in @surr
							@surr.push index 

		# for move in @moves
		# 	@surr = _.without @surr, move # 20 ggr långsammare

		newSurr = []
		for s in @surr
			if s not in @moves
				newSurr.push s
		@surr = newSurr

	clear : ->
		@moves = []
		@board = (0 for i in range N*N)
		@surr = []

	move : (play) ->
		@board[play] = @nextMarker()
		@moves.push parseInt play
		@extendSurr()

	nextBoard : (play) ->
		b = @copy()
		b.move play
		b

	lastMarker : -> [1,2][@moves.length % 2]
	nextMarker : -> [2,1][@moves.length % 2]

	calc : (dr,dc) ->
		helper = =>
			row = dr + index // N
			col = dc + index %% N
			res = 0
			while 0 <= row < N and 0 <= col < N and @board[row*N+col] == marker
				res++
				row += dr
				col += dc
			res
		marker = @lastMarker()
		index = _.last @moves
		1 + helper() >= WINSIZE

	done : ->
		if @moves.length <= 2 * (WINSIZE-1) then return false
		for dr in [-1,0,1]
			for dc in [-1,0,1]
				if dr!=0 or dc!=0
					if @calc dr,dc then return true 
		false

	draw : -> @moves.length == N*N # OBS! Kan vara vinst!

	winner : -> 
		if @draw() then return 0.5
		if @done() then return [1,0][@moves.length % 2] 
		null
	