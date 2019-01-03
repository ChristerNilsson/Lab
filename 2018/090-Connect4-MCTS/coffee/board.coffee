M = 6  # antal rader
N = 7  # antal kolumner
WINSIZE = 4

getRandom = (b) -> int b * Math.random()

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

	rand : -> _.sample (i for b,i in @board when b.length < M)

	clear : ->
		@moves = []
		@board = ('' for i in range N)

	move : (m) ->
		@board[m] += @nextMarker()
		@moves.push m

	nextBoard : (play) ->
		b = @copy()
		b.move play
		b

	undo : -> 
		index = @moves.pop() 
		@board[index] = @board[index].slice 0, @board[index].length-1

	lastMarker : -> 'OX'[@moves.length % 2]
	nextMarker : -> 'XO'[@moves.length % 2]

	calc : (dr,dc) ->
		helper = =>
			r = row + dr 
			c = col + dc
			res = 0
			while 0 <= r < M and 0 <= c < N and r < @board[c].length and @board[c][r] == marker
				res++
				r += dr
				c += dc
			res
		marker = @lastMarker()
		col = _.last @moves
		row = @board[col].length-1
		1 + helper() >= WINSIZE

	done : ->
		if @moves.length <= 2 * (WINSIZE-1) then return false
		for dr in [-1,0,1]
			for dc in [-1,0,1]
				if dr!=0 or dc!=0
					if @calc dr,dc then return true 
		false

	draw : -> @moves.length == M*N # OBS! Kan vara vinst!

	legalPlays : -> (col for col in range N when @board[col].length < M)

	winner : -> 
		if @draw() then return 0.5
		if @done() then return [1,0][@moves.length % 2] 
		null
	