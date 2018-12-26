M = 6  # antal rader
N = 7  # antal kolumner

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

	calcColumns : ->
		m = _.last @moves
		row = @board[m]
		i = row.length - 2
		if i<2 then return false # 50% more pos/sec
		marker = @lastMarker()
		count = 1
		while row[i] == marker and i >= 0
			count++
			i--
		count == 4

	calcRows : ->
		marker = @lastMarker()
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

	calcDiagonal : (dj) ->
		marker = @lastMarker()
		m = _.last @moves
		count = 1
		n = @board[m].length - 1
		count += @helper +1,+dj,marker,m,n
		count += @helper -1,-dj,marker,m,n
		count >= 4

	done : ->
		if @moves.length<=6 then return false
		if @calcColumns()   then return true
		if @calcRows()      then return true
		if @calcDiagonal +1 then return true
		if @calcDiagonal -1 then return true
		false

	draw : -> @moves.length == M*N

	legalPlays : -> (col for col in range N when @board[col].length < M)
	winner : ->
		if @draw() then return 0
		if @done() then return [1,-1][@moves.length % 2] 
		null

	isPlayer : (player) -> player == [-1,1][@moves.length % 2]  
	

###### tester ######

# b = new Board()
# b.move 1
# b.move 2
# c = b.copy()
# c.move 1

# assert b.moves,[1,2]
# assert b.board[1],'X'
# assert b.board[2],'O'
# assert b.lastMarker(), 'O'

# assert c.moves,[1,2,1]
# assert c.board[1],'XX'
# assert c.board[2],'O'
# assert c.lastMarker(), 'X'

# b.clear()
# assert b.moves,[]
# assert b.board[1],''
# assert b.board[2],''

# c = b.nextBoard 3
# assert c.moves,[3]
# assert c.board[3],'X'

# c.undo()
# assert c.moves,[]
# assert c.board[3],''
# assert c.legalPlays(), [0,1,2,3,4,5,6]
# c.move 3 for i in range 6
# assert c.board[3],'XOXOXO'
# assert c.legalPlays(), [0,1,2,4,5,6]

# # Vertikalt fyra
# c = new Board '131313' 
# assert c.done(),false 
# c.move 1
# assert c.board[1],'XXXX'
# assert c.board[3],'OOO'
# assert c.done(),true

# # Horisontell fyra
# c = new Board '061626'
# assert c.done(),false 
# c.move 3
# assert c.done(),true

# # Diagonal fyra
# c = new Board '543253445'
# assert c.done(),false 
# c.move 5
# assert c.done(),true
# assert c.winner(),1
# assert c.draw(),false

# print 'Ready!'