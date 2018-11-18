M = 6  # antal rader
N = 7  # antal kolumner
DOT = '.'

getRandom = (b) -> int b * Math.random()

class Board

	constructor : (moves='') ->
		@clear()
		for digit in moves
			@move int digit
 
	copy : ->
		b = new Board()
		b.board = @board.slice() #(x for x in @board)
		b.moves = @moves.slice()
		b

	rand : -> _.sample (i for b,i in @board when b.length < M)

	clear : ->
		@moves = []
		@board = ['', '', '', '', '', '', '']

	move : (m) ->
		@board[m] += @next_marker()
		@moves.push m

	undo : ->
		m = @moves.pop()
		@board[m].pop()

	last_marker : -> 'OX'[@moves.length % 2]
	next_marker : -> 'XO'[@moves.length % 2]
	display_simple : -> '\n:' + '\n:'.join(@board) + '\n 012345\n'

	display : ->
		res = '\n'
		for j in range 5, -1, -1
			res += str(j)
			for i in range N
				if j < @board[i].length
					res += ' ' + @board[i][j]
				else
					res += ' ' + DOT 
			res += "\n"
		res += '  0 1 2 3 4 5 6\n'
		res

	calc_columns : ->
		marker = @last_marker()
		m = _.last @moves
		count = 0
		row = @board[m]
		i = row.length - 1
		while row[i] == marker and i >= 0
			count += 1
			i -= 1
		count == 4

	calc_rows : ->
		marker = @last_marker()
		m = _.last @moves
		count = 1
		n = @board[m].length - 1
		i = m+1
		while i < 7 and n < @board[i].length and @board[i][n] == marker
			count += 1
			i += 1
		i = m-1
		while i >= 0 and n < @board[i].length and @board[i][n] == marker
			count += 1
			i -= 1
		count >= 4

	helper : (di, dj, marker,m,n) ->
		i = m+di
		j = n+dj
		res = 0
		while 0 <= j < M and 0 <= i < N and j < @board[i].length and @board[i][j] == marker
			res += 1
			i += di
			j += dj
		return res

	calc_diagonal : (dj) ->
		marker = @last_marker()
		m = _.last @moves
		count = 1
		n = @board[m].length - 1
		count += @helper 1, dj,marker,m,n
		count += @helper -1, -dj,marker,m,n
		count >= 4

	calc : ->
		if @calc_columns() then return true
		if @calc_rows() then return true
		if @calc_diagonal 1 then return true
		if @calc_diagonal -1 then return true
		false
