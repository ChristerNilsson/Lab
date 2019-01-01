M = 10  # number of rows
N = 10  # number of cols
WINSIZE = 5 # number of markers to win

class Board

	constructor : (moves='') -> 
		@clear()
		for digit in moves
			@move parseInt digit
 
	copy : ->
		b = new Board()
		b.board = @board.slice() 
		b.moves = @moves.slice()
		b

	surr : -> # one step neighbours in eight directions 
		res = {}
		for move in @moves
			row = move // N
			col = move %% N
			for dr in [-1,0,1]
				for dc in [-1,0,1]
					if dr!=0 or dc!=0
						if 0 <= row+dr < N and 0 <= col+dc < N 
							index = N*(row+dr)+col+dc 
							res[index] = index
		res[move] = -1 for move in @moves
		(m for i,m of res when m != -1)

	clear : ->
		@moves = []
		@board = (0 for i in range M*N)

	move : (play) ->
		@board[play] = @nextMarker()
		@moves.push play

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

	draw : -> @moves.length == M*N # OBS! Kan vara vinst!

	legalPlays : -> (i for i in range M*N when @board[i] == 0)

	winner : -> 
		if @draw() then return 0.5
		if @done() then return [1,0][@moves.length % 2] 
		null
	
######
# rand : -> _.sample (i for b,i in @board when b.length < M)
# getRandom = (b) -> int b * Math.random()
# undo : -> 
# 	index = @moves.pop() 
# 	@board[index] = @board[index].slice 0, @board[index].length-1



