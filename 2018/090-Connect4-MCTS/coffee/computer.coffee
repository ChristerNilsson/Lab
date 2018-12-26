# class Computer

# 	constructor : ->

# 	play_complete : (b) ->
# 		while true
# 			marker = b.lastMarker()
# 			b.move b.rand()
# 			if b.done() then return marker
# 			if M*N == b.moves.length then return "draw" 

	# move : (board) ->
	# 	start = Date.now()
	# 	marker = board.last_marker()
	# 	cands = ([0,m] for m in range N when board.board[m].length < M)
	# 	if cands.length == 1 then return cands[0][1]

	# 	antal = 0
	# 	end = Date.now() + 2 ** level * thinkingTime
	# 	while Date.now() < end
	# 		for cand in cands
	# 			antal++
	# 			b = board.copy()
	# 			b.move cand[1]
	# 			if b.done() then return cand[1]
	# 			mrkr = @play_complete b
	# 			if mrkr == marker
	# 				cand[0]++
	# 			else if mrkr != 'draw'
	# 				cand[0]--

	# 	cand  = _.max cands, (cand) -> cand[0]
	# 	print Date.now() - start, antal/(2 ** level * thinkingTime/1000)
	# 	cand[1]

	# move : (board) ->
	# 	mc = new MonteCarlo new Node null,null,board,[0,1,2,3,4,5,6]
	# 	result = mc.runSearch()
