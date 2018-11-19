class Computer

	constructor : ->

	play_complete : (b) ->
		while true
			marker = b.last_marker()
			b.move b.rand()
			if b.done() then return marker
			if M*N == b.moves.length then return "draw" 

	move : (board) ->
		start = Date.now()
		marker = board.last_marker()
		cands = ([0,m] for m in range N when board.board[m].length < M)
		if cands.length == 1 then return cands[0][1]
		for cand in cands
			for j in range 2 ** level
				for i in range PROBES # shorter ranges
					b = board.copy()
					b.move cand[1]
					if b.done() then return cand[1]
					mrkr = @play_complete b
					if mrkr == marker
						cand[0]++
					else if mrkr != 'draw'
						cand[0]--

		cand  = _.max cands, (cand) -> cand[0]
		print Date.now() - start, -cand[0]
		cand[1]
