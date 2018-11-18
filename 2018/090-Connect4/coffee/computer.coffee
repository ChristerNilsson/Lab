class Computer

	constructor : (@name='MonteCarlo') ->

	play_complete : (b) ->
		while true
			marker = b.last_marker()
			m = b.rand()
			if b.board[m].length < 6
				b.move m
				if b.calc() then return marker
			if 42 == b.moves.length then return "draw" 

	move : (board) ->
		start = Date.now()
		arr = [0,0,0,0,0,0,0]
		marker = board.last_marker()
		lst = (m for m in range 7 when board.board[m].length < 6)
		if lst.length == 1 then return lst[0]
		for m in lst
			for i in range (20 * 2 ** level)
				b = board.copy()
				b.move m
				if b.calc() then return m
				mrkr = @play_complete b
				if mrkr == marker
					arr[m] += 1
				else if mrkr != 'draw'
					arr[m] -= 1
		bestm = lst[0]
		best = arr[bestm]
		for m in lst
			if arr[m] > best
				bestm = m
				best = arr[m]
		print Date.now()-start
		return bestm
