WINSIZE = 4

getRandom = (b) -> int b * Math.random()

class Board

	constructor : (moves='') -> # @board,@moves
		@clear()
		for digit in moves
			@move int digit
 
	copy : ->
		b = new Board()
		b.board = @board.slice() 
		b.moves = @moves.slice()
		b

	rand : -> _.sample (i for b,i in @board when b.length < M)

	clear : ->
		@moves = [] # list of 0..6
		@board = ['', '', '', '', '', '', '']

	move : (m) ->
		@board[m] += @nextMarker()
		@moves.push m

	undo : -> @board[@moves.pop()].pop()

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
