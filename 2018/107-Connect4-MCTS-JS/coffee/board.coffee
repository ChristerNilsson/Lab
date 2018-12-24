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
		@moves = []
		@board = ['', '', '', '', '', '', '']

	move : (m) ->
		@board[m] += @next_marker()
		@moves.push m

	undo : -> @board[@moves.pop()].pop()

	last_marker : -> 'OX'[@moves.length % 2]
	next_marker : -> 'XO'[@moves.length % 2]

	calc_columns : ->
		marker = @last_marker()
		m = _.last @moves
		count = 0
		row = @board[m]
		i = row.length - 1
		while row[i] == marker and i >= 0
			count++
			i--
		count == 4

	calc_rows : ->
		marker = @last_marker()
		m = _.last @moves
		count = 1
		n = @board[m].length - 1

		for i in range m+1,N
			if n >= @board[i].length or @board[i][n] != marker then break
			count++

		for i in range m-1,-1,-1
			if n >= @board[i].length or @board[i][n] != marker then break
			count++

		count >= 4

	helper : (di, dj, marker, m, n) ->
		i = m+di
		j = n+dj
		res = 0
		while 0 <= j < M and 0 <= i < N and j < @board[i].length and @board[i][j] == marker
			res++
			i += di
			j += dj
		return res

	calc_diagonal : (dj) ->
		marker = @last_marker()
		m = _.last @moves
		count = 1
		n = @board[m].length - 1
		count += @helper +1,+dj,marker,m,n
		count += @helper -1,-dj,marker,m,n
		count >= 4

	done : ->
		if @calc_columns() then return true
		if @calc_rows() then return true
		if @calc_diagonal 1 then return true
		if @calc_diagonal -1 then return true
		false
