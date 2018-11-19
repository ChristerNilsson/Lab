class Computer

	constructor : ->

	play_complete : (b) ->
		while true
			marker = b.last_marker()
			m = b.rand()
			if b.board[m].length < M
				b.move m
				if b.calc() then return marker
			if M*N == b.moves.length then return "draw" 

	move : (board) ->
		arr = [0,0,0,0,0,0,0]
		marker = board.last_marker()
		lst = (m for m in range N when board.board[m].length < M)
		if lst.length == 1 then return lst[0]
		for m in lst
			for i in range (20 * 2 ** level)
				b = board.copy()
				b.move m
				if b.calc() then return m
				mrkr = @play_complete b
				if mrkr == marker
					arr[m]++
				else if mrkr != 'draw'
					arr[m]--
		bestm = lst[0]
		best = arr[bestm]
		for m in lst
			if arr[m] > best
				bestm = m
				best = arr[m]
		return bestm
