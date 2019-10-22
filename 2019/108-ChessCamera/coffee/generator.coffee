# en passant saknas
# bondeförvandling saknas
# rockad saknas

BLACK = 0
WHITE = 1

index = (row,col) -> 8*row+col
position = (index) -> [Math.floor(index/8),index%8]

class Generator
	constructor : (@player, @board) -> # player: 0=black 1=white
		assert @board.length, 64
		@dirs =
			K : [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
			Q : [[-1,0],[1,0],[0,-1],[0,1],[-1,-1],[1,1],[1,-1],[-1,1]]
			R : [[-1,0],[0,-1],[0,1],[1,0]]
			B : [[-1,-1],[1,1],[1,-1],[-1,1]]
			N : [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]

	handleKN : (index0,res0,res1,dirs) ->
		[row,col] = position index0
		for [r,c] in dirs
			[r1,c1] = [row+r,col+c]
			if 0 <= r1 <= 7 and 0 <= c1 <= 7
				index1 = index r1,c1
				if @board[index1] not in 'KQRBNP'
					res0.push index0
					res1.push index1

	handleBRQ : (index0,res0,res1,dirs) ->
		[row,col] = position index0
		for [dr,dc] in dirs
			[r,c] = [row,col]
			while true 
				[r,c] = [r+dr,c+dc]
				if 0 <= r <= 7 and 0 <= c <= 7 
					index1 = index r,c
					if @board[index1] in ' kqrbnp' 
						res0.push index0
						res1.push index1
					if @board[index1] != ' ' then break
				else 
					break
		res1.sort (a,b) -> a-b

	handleP : (index0,res0,res1,player) ->
		[row,col] = position index0
		if player == WHITE

			if @board[index0-9] in 'kqrbnp' # snett vänster
				res0.push index0
				res1.push index0-9

			if @board[index0-8] == ' ' # ett steg
				res0.push index0
				res1.push index0-8

			if @board[index0-7] in 'kqrbnp' # snett höger
				res0.push index0
				res1.push index0-7

			if row == 6 and @board[index0-8] == ' ' and @board[index0-16] == ' ' # två steg
				res0.push index0
				res1.push index0-16

		if player == BLACK

			if @board[index0+9] in 'kqrbnp' # snett höger
				res0.push index0
				res1.push index0+9

			if @board[index0+8] == ' ' # ett steg
				res0.push index0
				res1.push index0+8

			if @board[index0+7] in 'kqrbnp' # snett vänster
				res0.push index0
				res1.push index0+7

			if row == 1 and @board[index0+8] == ' ' and @board[index0+16] == ' ' # två steg
				res0.push index0
				res1.push index0+16

	handleK : (index0,res0,res1) -> @handleKN index0,res0,res1,@dirs.K
	handleN : (index0,res0,res1) -> @handleKN index0,res0,res1,@dirs.N
	handleB : (index0,res0,res1) -> @handleBRQ index0,res0,res1,@dirs.B
	handleR : (index0,res0,res1) -> @handleBRQ index0,res0,res1,@dirs.R
	handleQ : (index0,res0,res1) -> @handleBRQ index0,res0,res1,@dirs.Q

	moves : (player) ->
		p = @player
		q = 1-p
		[p0,p1] = @createMoves player
		[q0,q1] = @createMoves 1-player

		# tag bort de drag som innebär att kungen kan tas.
		result = []
		for i in range p1.length
			if p1[i] not in q1
				result.push [p0[i],p1[i]]
		result

	createMoves : (player) ->
		res0 = []
		res1 = []
		for i in range 64
			piece = @board[i]
			if @board[i] != ' '
				if player == 'kK'.indexOf piece then @handleK i,res0,res1
				if player == 'nN'.indexOf piece then @handleN i,res0,res1
				if player == 'bB'.indexOf piece then @handleB i,res0,res1
				if player == 'rR'.indexOf piece then @handleR i,res0,res1
				if player == 'qQ'.indexOf piece then @handleQ i,res0,res1
				if player == 'pP'.indexOf piece then @handleP i,res0,res1
		[res0,res1]

assert index(0,0), 0
assert index(7,7), 63
assert [0,0], position 0
assert [7,7], position 63

generator = new Generator 1, 'K                                  k                            '
res0 = []
res1 = []
generator.handleK 0,res0,res1
assert res0, [0,0,0]
assert res1, [1,8,9]

board = ''
board += ' Q B    '
board += '        '
board += '  KN    '
board += '  R     '
board += '   k    '
board += '        '
board += '        '
board += 'N       '
generator = new Generator 9,board

res0 = []
res1 = []
generator.handleK(18,res0,res1)
assert res0, [18,18,18,18,18,18]
assert res1, [ 9,10,11,17,25,27]

res0 = []
res1 = []
generator.handleN(56,res0,res1)
assert res0, [56,56]
assert res1, [41,50]

res0 = []
res1 = []
generator.handleR(26,res0,res1)
assert res0, [26,26,26,26,26,26,26, 26,26,26,26]
assert res1, [24,25,27,28,29,30,31, 34,42,50,58]

res0 = []
res1 = []
generator.handleB(3,res0,res1)
assert res0, [3,3,3,    3,3,3,3]
assert res1, [10,12,17,21,24,30,39]

res0 = []
res1 = []
generator.handleQ(1,res0,res1)
assert res0, [1,1,1,1,1,1,1,1,1,1,1]
assert res1, [0,2,8,9,10,17,25,33,41,49,57]

#assert [[18,18,18,18,18,18,18, 19,19,19,19,19,19,19,19, 56,56],[ 9,10,11,17,25,26,27, 2,4,9,13,25,29,34,36, 41,50]], generator.createMoves WHITE
# assert [[35,35,35,35,35,35,35,35],[26,27,28,35,36,42,43,44]], generator.createMoves BLACK

#generator = new Generator 'rnbqkbnkpppppppp                                RNBQKBNR'
#assert generator.moves, 'a2a3 a2a4 b2b3 b2b4 c2c3 c2c4 d2d3 d2d4 e2e3 e2e4 f2f3 f2f4 g2g3 g2g4 h2h3 h2h4 b1a3 b2c3 g1f3 g1h3'

console.log 'Ready!'