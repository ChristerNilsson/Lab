class Computer

	constructor : ->

	play_complete : (b) ->
		while true
			marker = b.last_marker()
			b.move b.rand()
			if b.done() then return marker
			if M*N == b.moves.length then return "draw" 

	move : (board) ->
		score = [0,0,0,0,0,0,0]
		marker = board.last_marker()
		cands = (m for m in range N when board.board[m].length < M)
		if cands.length == 1 then return cands[0]
		for m in cands
			for i in range (20 * 2 ** level)
				b = board.copy()
				b.move m
				if b.done() then return m
				mrkr = @play_complete b
				if mrkr == marker
					score[m]++
				else if mrkr != 'draw'
					score[m]--
		bestm = cands[0]
		best = score[bestm]
		for m in cands
			if score[m] > best
				bestm = m
				best = score[m]
		return bestm
