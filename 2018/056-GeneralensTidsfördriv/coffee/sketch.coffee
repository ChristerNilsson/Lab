# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

#  4  4  4  4  4  0  8  8  8  8  8
#  5  5  5  5  5  1  9  9  9  9  9
#  6  6  6  6  6  2 10 10 10 10 10
#  7  7  7  7  7  3 11 11 11 11 11
#    12 13 14 15    16 17 18 19

ACES = [0,1,2,3]
HEAPS = [4,5,6,7,8,9,10,11]
PANEL4 =       [14,15,16,17]
PANEL8 = [12,13,14,15,16,17,18,19]

SUIT = "club heart spade diamond".split ' '
RANK = "A 2 3 4 5 6 7 8 9 T J Q K".split ' '
OFFSETX = 468
W = 263.25
H = 352
w = W/3
h = H/3
LIMIT = 2000 # Maximum steps considered before giving up.

faces = null
backs = null

board = null
cards = null
hist = null
cands = null
hash = null
aceCards = 4
originalBoard = null
start = null
timing = null
autoShake = []
shake = true
N = null # Max rank
srcs = null
dsts = null

preload = -> 
	faces = loadImage 'cards/Color_52_Faces_v.2.0.png'
	backs = loadImage 'cards/Playing_Card_Backs.png'

range = _.range

compress = (board) ->
	for heap in HEAPS
		if board[heap].length > 1
			temp = board[heap][0]
			res = []
			for i in range 1,board[heap].length
				[suit1,h1,v1] = temp
				[suit2,h2,v2] = board[heap][i]
				if suit1==suit2 and 1 == abs v1-h2
					temp = [suit1,h1,v2]
				else
					res.push temp 
					temp = [suit2,h2,v2]
			res.push temp
			board[heap] = res

makeBoard = (maxRank,wild=false)->
	N = maxRank
	cardsPerSequence = N//2-1
	#panelCards = maxRank*4 - 8 * cardsPerSequence 

	cards = []
	for rank in range 1,maxRank
		for suit in range 4
			cards.push [suit,rank,rank]
	cards = _.shuffle cards

	board = []
	for i in range 20
		board.push []

	for suit,heap in range 4 
		board[heap].push [suit,0,0]
	for i in range 4,12
		for j in range cardsPerSequence 
			rr = if wild then int random 4,12 else i
			board[rr].push cards.pop()

	if N%2==0 then lst = PANEL4
	if N%2==1 then lst = PANEL8

	for heap in lst
		board[heap].push cards.pop()

	compress board

fakeBoard = ->
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,2,2],[1,3,3],[1,1,1],[3,1,1],[3,2,2]],[[0,4,4],[0,12,12],[3,5,5],[1,8,8],[3,9,9]],[[2,11,11],[3,12,12],[0,6,6],[2,5,5],[1,7,7]],[[0,8,8],[3,11,11],[2,6,6],[2,9,9],[1,12,12]],[[0,9,9],[0,10,10],[2,10,10],[2,4,4],[2,7,7]],[[1,2,2],[3,4,4],[3,6,6],[0,5,5],[1,11,11]],[[0,1,1],[0,7,7],[1,10,10],[1,5,5],[3,8,8]],[[0,3,3],[1,4,4],[3,3,3],[2,2,2],[3,10,10]],[[0,11,11]],[[3,7,7]],[[2,1,1]],[[2,8,8]],[],[[1,6,6]],[[2,3,3]],[[2,12,12]],[[1,9,9]]] # nix!
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,10,10],[2,11,11],[0,6,6],[3,9,9],[1,8,8]],[[3,10,10],[2,10,10],[0,12,12],[0,4,4],[3,1,1]],[[3,12,12],[1,3,3],[1,4,4],[1,9,9],[0,2,2]],[[3,4,4],[3,5,5],[2,5,5],[2,9,9],[2,3,3]],[[3,6,6],[1,7,7],[0,5,5],[2,7,7],[3,8,8]],[[2,4,4],[0,9,9],[1,2,2],[3,11,11],[1,6,6]],[[2,8,8],[2,1,1],[2,2,2],[1,10,10],[3,3,3]],[[1,1,1],[1,11,11],[1,12,12],[3,7,7],[2,12,12]],[[0,11,11]],[[3,2,2]],[[1,5,5]],[[0,8,8]],[],[[2,6,6]],[[0,3,3]],[[0,1,1]],[[0,7,7]]] # 851 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[2,3,3],[2,12,12],[2,11,11],[3,10,10],[1,7,7]],[[1,11,11],[0,5,5],[2,9,9],[3,12,12],[1,5,5]],[[0,12,12],[3,8,8],[1,9,9],[0,6,6],[1,6,6]],[[3,1,1],[2,7,7],[0,8,8],[0,7,7],[1,3,3]],[[1,8,8],[0,9,9],[2,10,10],[3,9,9],[1,4,4]],[[1,12,12],[3,2,2],[3,3,3],[3,4,4],[1,2,2]],[[3,6,6],[2,1,1],[0,2,2],[2,8,8],[0,3,3]],[[1,1,1],[3,7,7],[2,6,6],[3,11,11],[0,1,1]],[[2,5,5]],[[2,2,2]],[[1,10,10]],[[2,4,4]],[],[[3,5,5]],[[0,10,10]],[[0,11,11]],[[0,4,4]]] # 963 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[3,12,12],[3,9,9],[2,5,5],[3,2,2],[1,10,10]],[[0,1,1],[0,10,10],[2,4,4],[1,3,3],[3,7,7]],[[0,3,3],[0,11,11],[2,7,7],[3,8,8],[1,2,2]],[[0,5,5],[2,6,6],[0,6,6],[3,3,3],[1,5,5]],[[0,4,4],[3,5,5],[0,2,2],[3,10,10],[2,2,2]],[[2,10,10],[0,12,12],[2,1,1],[2,11,11],[0,9,9]],[[3,4,4],[1,7,7],[1,6,6],[2,12,12],[1,8,8]],[[1,1,1],[1,12,12],[1,11,11],[1,4,4],[2,3,3]],[[0,8,8]],[[3,11,11]],[[2,9,9]],[[0,7,7]],[],[[3,1,1]],[[2,8,8]],[[3,6,6]],[[1,9,9]]] # 264 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[1,1,1],[0,12,12],[3,3,3],[2,7,7],[3,11,11]],[[2,11,11],[2,8,8],[3,6,6],[0,1,1],[0,6,6]],[[1,8,8],[1,6,6],[0,3,3],[1,3,3],[0,7,7]],[[0,11,11],[1,10,10],[3,12,12],[1,11,11],[1,2,2]],[[0,4,4],[3,2,2],[2,2,2],[3,7,7],[0,5,5]],[[2,5,5],[2,9,9],[3,8,8],[3,9,9],[2,4,4]],[[2,10,10],[0,9,9],[1,12,12],[3,4,4],[3,10,10]],[[2,12,12],[3,5,5],[1,4,4],[2,1,1],[0,2,2]],[[1,5,5]],[[0,10,10]],[[0,8,8]],[[1,9,9]],[],[[3,1,1]],[[1,7,7]],[[2,6,6]],[[2,3,3]]] # 397 ms
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,2,2],[2,4,4],[2,10,10],[2,5,5],[1,1,1],[3,12,12],[2,12,12],[3,11,11],[1,8,8],[1,6,6]],[[3,9,9],[2,11,11],[0,12,12],[0,3,3],[3,10,10]],[[3,3,3],[0,9,9]],[[2,7,7],[1,4,4],[3,2,2],[1,9,9],[0,6,6],[1,5,5],[0,1,1]],[[1,3,3],[1,2,2],[2,2,2],[2,6,6],[1,11,11]],[[3,7,7],[2,8,8],[1,7,7],[3,1,1],[0,8,8]],[[2,3,3],[3,5,5],[3,6,6]],[[1,12,12],[3,4,4],[0,5,5]],[[0,7,7]],[[3,8,8]],[[1,10,10]],[[0,11,11]],[],[[0,4,4]],[[0,10,10]],[[2,1,1]],[[2,9,9]]]
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[2,7,7],[0,8,8],[0,2,2],[0,5,5]],[[2,9,9],[1,5,5],[0,3,3],[2,11,11],[1,10,10]],[[2,2,2],[1,8,8]],[[1,11,11],[2,6,6],[2,10,10],[2,5,5],[3,3,3],[1,1,1]],[[3,2,2],[3,12,12],[2,3,3],[1,7,7],[3,4,4],[3,11,11]],[[3,8,8],[0,10,10],[3,7,7],[0,12,12],[1,3,3],[0,9,9],[1,12,12]],[[0,7,7],[2,12,12],[0,6,6],[3,9,9]],[[1,2,2],[0,4,4],[1,6,6],[2,4,4],[1,4,4],[1,9,9]],[[3,6,6]],[[2,8,8]],[[2,1,1]],[[3,10,10]],[],[[0,11,11]],[[0,1,1]],[[3,1,1]],[[3,5,5]]] # 118 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[3,3,3],[2,3,3],[0,6,6],[3,5,5],[0,9,9],[2,10,10],[1,10,10]],[[0,10,10],[0,7,7],[3,8,8],[2,11,11]],[[0,12,12],[3,7,7],[2,1,1],[2,8,8],[1,7,7]],[[1,4,4],[2,5,5],[2,6,6],[1,2,2],[0,1,1],[2,2,2],[3,11,11],[2,7,7]],[[3,6,6],[3,9,9],[0,4,4],[3,4,4],[1,8,8]],[[0,3,3],[3,12,12],[1,11,11]],[[2,4,4],[0,2,2],[3,10,10],[0,8,8]],[[1,5,5],[2,9,9],[1,6,6],[1,1,1]],[[0,5,5]],[[0,11,11]],[[2,12,12]],[[1,3,3]],[],[[1,12,12]],[[1,9,9]],[[3,1,1]],[[3,2,2]]]
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,7,7],[1,10,10],[0,1,1],[0,2,2],[2,7,7]],[[2,1,1],[2,8,8],[1,3,3],[1,7,7],[3,11,11]],[[2,2,2],[3,6,6],[3,8,8],[2,4,4],[0,3,3]],[[3,1,1],[0,5,5],[3,2,2],[2,3,3],[1,2,2]],[[3,4,4],[2,10,10],[1,11,11],[0,11,11],[2,5,5]],[[3,9,9],[0,6,6],[2,11,11],[0,10,10],[3,12,12]],[[1,9,9],[1,12,12],[0,4,4],[1,6,6],[2,6,6]],[[1,1,1],[2,12,12],[1,5,5],[3,7,7],[1,8,8]],[[3,10,10]],[[0,9,9]],[[3,3,3]],[[0,12,12]],[],[[2,9,9]],[[0,8,8]],[[1,4,4]],[[3,5,5]]]
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[3,9,9],[0,4,4],[3,5,5],[0,7,7],[1,5,5]],[[1,10,10],[3,7,7],[0,6,6],[3,11,11],[3,8,8]],[[2,2,2],[3,1,1],[1,1,1],[1,9,9],[0,9,9]],[[1,2,2],[2,7,7],[1,6,6],[3,6,6],[3,3,3]],[[1,7,7],[2,3,3],[0,1,1],[2,1,1],[0,3,3]],[[2,8,8],[1,11,11],[2,6,6],[0,10,10],[3,4,4]],[[2,5,5],[2,12,12],[3,10,10],[0,2,2],[1,8,8]],[[2,11,11],[2,9,9],[0,12,12],[3,12,12],[1,4,4]],[[1,12,12]],[[0,5,5]],[[2,10,10]],[[3,2,2]],[],[[1,3,3]],[[2,4,4]],[[0,11,11]],[[0,8,8]]]
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[2,10,10],[2,12,12],[1,8,8],[1,12,12],[3,3,3]],[[1,2,2],[0,5,5]],[[3,12,12],[2,4,4],[3,8,8],[1,5,5],[0,8,8]],[[1,11,11],[0,1,1],[0,4,4]],[[1,7,7],[1,3,3],[0,10,10],[3,4,4],[2,1,1],[3,11,11]],[[2,9,9],[2,5,5],[1,6,6],[2,2,2],[1,1,1],[0,3,3]],[[2,6,6],[2,3,3],[3,1,2],[0,2,2],[1,9,9],[3,7,7],[3,10,10],[0,11,11],[2,7,7]],[[2,8,8],[3,6,6],[1,10,10]],[[0,6,6]],[[3,5,5]],[[3,9,9]],[[0,12,12]],[],[[2,11,11]],[[0,9,9]],[[1,4,4]],[[0,7,7]]]
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[2,11,11],[1,6,6],[1,8,8],[2,4,4],[1,4,4],[3,9,9],[0,10,10],[2,9,9]],[[0,5,5],[0,11,11],[0,6,6]],[[0,2,2],[2,5,5],[2,1,1],[0,3,3]],[[2,8,8],[2,3,3],[1,9,9],[3,10,10],[0,4,4],[0,1,1],[0,12,12],[2,6,6],[1,12,12]],[[3,5,4],[3,11,11],[1,3,3],[3,6,6],[1,10,10],[3,8,8]],[[0,8,8]],[[1,1,1],[1,11,11]],[[1,7,7],[2,2,2],[1,2,2],[3,3,3],[3,1,2]],[[1,5,5]],[[0,7,7]],[[2,10,10]],[[3,7,7]],[],[[2,12,12]],[[0,9,9]],[[3,12,12]],[[2,7,7]]] # 68000
	board = [[[0,0,0]],[[1,0,0]],[[2,0,0]],[[3,0,0]],[[0,10,10],[2,8,8],[0,1,1],[3,10,10],[2,6,6]],[[0,4,4],[3,8,9],[1,8,8],[0,9,9]],[[3,3,3],[1,2,2],[3,11,11],[2,10,10],[2,2,2]],[[1,9,9],[1,3,3],[1,6,6],[2,9,9],[3,7,7]],[[1,7,7],[1,5,5],[3,2,1],[2,7,7]],[[3,6,6],[1,11,11],[0,11,11],[1,1,1],[2,11,11]],[[2,1,1],[0,5,7],[3,4,4]],[[2,3,3],[0,2,2],[1,4,4],[3,5,5],[2,5,5]],[],[],[[1,10,10]],[[0,3,3]],[[0,8,8]],[[2,4,4]],[],[]]

makeAutoShake = ->
	autoShake = []
	for i in range 52
		autoShake.push [int(random(-2,2)),int(random(-2,2))]

setup = ->
	createCanvas 800,600
	makeAutoShake()
	newGame '5'
	display board 

showHeap = (board,heap,x,y,dx) ->
	n = calcAntal board[heap]
	if n==0 then return 
	x0 = width/2 - w/2
	if x < 0 then x0 += -w+dx
	if x > 0 then x0 += w-dx
	x = x0 + x*dx/2
	y = y * h
	for card,k in board[heap]
		[suit,unvisible,visible] = card
		dr = if unvisible < visible then 1 else -1
		for rank in range unvisible,visible+dr,dr
			[x0,y0] = if shake then autoShake[13*suit+rank] else [0,0]
			image faces, x0+x,y0+y+13, w,h, OFFSETX+W*rank,1092+H*suit,243,H
			x += dx

	if heap in ACES and card[2]==N-1
		[x0,y0] = if shake then autoShake[13*suit+rank] else [0,0]
		image backs, x0+x,y0+y+13, w,h, OFFSETX+860,1092+622,243,H

calcAntal = (lst) ->
	res=0
	for [suit,unvisible,visible] in lst
		res += 1 + abs(unvisible-visible)
	res

display = (board) ->
	background 0,0,255

	textAlign CENTER,CENTER
	textSize 10

	x = width/2-5
	y = height-110

	fill 200
	text 'U = Undo',          x,y
	text 'R = Restart',       x,y+15
	text '5 6 7 = Easy',      x,y+30
	text '8 9 T = Medium',    x,y+45
	text 'J Q K = Hard',      x,y+60
	text 'W = Wild',          x,y+75
	if timing != null then text "#{timing} seconds", x,y+105
	textSize 20
	text '     56789TJQK'[N], x,y+91
	textAlign LEFT,CENTER
	textSize 10
	text 'Generalens Tidsfördriv', 0,height-5

	for heap,y in ACES
		showHeap board, heap, 0, y, 0

	for heap,y in [4,5,6,7]
		n = calcAntal board[heap]
		dx = if n<=7 then w/2 else (width/2-w/2-w)/(n-1)
		showHeap board, heap, -2, y, -dx

	for heap,y in [8,9,10,11]
		n = calcAntal board[heap]
		dx = if n<=7 then w/2 else (width/2-w/2-w)/(n-1)
		showHeap board, heap, 2, y, dx
			
	for heap,x in PANEL8
		xx = [-8,-6,-4,-2,2,4,6,8][x]
		showHeap board, heap, xx,4, w

legalMove = (board,a,b) ->
	if a in ACES then return false 
	if b in PANEL8 then return false 
	if board[a].length==0 then return false
	if board[b].length==0 then return true
	[sa,a1,a2] = _.last board[a]
	[sb,b1,b2] = _.last board[b]
	if sa==sb and abs(a2-b2) == 1 then return true 
	false

makeMove = (board,a,b,record) -> # from heap a to heap b
	[suit,visible,unvisible] = board[a].pop() # reverse order
	if record then hist.push [a, b, 1 + abs unvisible-visible]
	if board[b].length > 0 then unvisible = board[b].pop()[1]
	board[b].push [suit,unvisible,visible] 

undoMove = ([a,b,antal]) ->
	#print 'undo', prettyMove b,a,board
	[suit, unvisible, visible] = board[b].pop()
	if unvisible < visible
		board[a].push [suit,visible,  visible-antal+1]
		if visible!=unvisible+antal-1 then board[b].push [suit,unvisible,visible-antal]
	else
		board[a].push [suit,visible,  visible+antal-1]
		if unvisible!=visible+antal-1 then board[b].push [suit,unvisible,visible+antal]

mousePressed = -> # one click
	if not (0 < mouseX < width) then return
	if not (0 < mouseY < height) then return

	marked = null
	mx = mouseX//(W/3)
	my = mouseY//(H/3)
	if my >= 4
		if mx<=3 then marked = 12 + mx
		if mx>=5 then marked = 11 + mx
	else
		if mx==4 then marked = my
		else if mx<4 then marked = [4,5,6,7][my]
		else marked = [8,9,10,11][my]
	if marked==null then return 

	holes = []
	found = false

	for heap in ACES.concat HEAPS # [0,1,2,3, 4,5,6,7,8,9,10,11] 	
		if board[heap].length==0 then holes.push heap
		if heap not in holes and legalMove board,marked,heap  
			makeMove board,marked,heap,true
			found = true
			break 
	if not found
		for heap in holes	
			if legalMove board,marked,heap  
				makeMove board,marked,heap,true
				break 

	if 4*N == countAceCards board then timing = (millis() - start) // 1000
	display board

####### AI-section ########

findAllMoves = (b) ->
	srcs = HEAPS.concat PANEL8 #[4,5,6,7,8,9,10,11, 12,13,14,15,16,17,18,19]
	dsts = ACES.concat HEAPS #[0,1,2,3, 4,5,6,7,8,9,10,11]
	res = []
	for src in srcs
		for dst in dsts
			if src!=dst
				if legalMove b,src,dst then res.push [src,dst]
	res

makeKey = (b) -> # kanske 4-11 bör sorteras först
	res = ''
	for heap,index in b
		for [suit,r1,r2] in heap
			if r1==r2
				res += 'chsd'[suit] + RANK[r1]
			else
				res += 'chsd'[suit] + RANK[r1] + RANK[r2]
		res += ' '
	res 

countAceCards = (b) ->
	res	= 0
	for heap in ACES
		res += calcAntal b[heap]
	res

expand = ([aceCards,level,b]) ->
	res = []
	moves = findAllMoves b
	for [src,dst] in moves
		b1 = _.cloneDeep b
		makeMove b1,src,dst
		key = makeKey b1
		if key not of hash
			hash[key] = [src,dst,b]
			res.push [countAceCards(b1), level+1, b1] 
	res

newGame = (key) ->
	start = millis()
	timing = null
	hist = []
	while true 
		if key in '56789TJQK' then makeBoard 5+'56789TJQK'.indexOf key
		if key in 'W' then makeBoard 13,true

		originalBoard = _.cloneDeep board

		cands = []
		cands.push [4,0,board] # antal kort på ässen, antal drag, board
		hash = {}
		nr = 0
		cand = null
		aceCards = 4

		while nr < LIMIT and cands.length > 0 and aceCards < N*4
			nr++ 
			cand = cands.pop()
			aceCards = cand[0]
			increment = expand cand
			cands = cands.concat increment
			cands.sort (a,b) -> if a[0] == b[0] then b[1]-a[1] else a[0]-b[0]

		level = cand[1]
		print nr,aceCards,level
		if aceCards == N*4
			print JSON.stringify(originalBoard)
			board = cand[2]
			printSolution hash,board
			board = _.cloneDeep originalBoard
			print "#{int millis()-start} ms"
			start = millis()
			return 

restart = ->
	hist = []
	board = _.cloneDeep originalBoard

keyPressed = -> 
	if key == 'U' and hist.length > 0 then undoMove hist.pop()
	if key == 'R' then restart()
	if key in '56789TJQKW' then newGame key 
	if key == 'A' then shake = not shake
	display board
		
prettyCard = ([suit,unvisible,visible],antal=2) ->
	if antal==1 then "#{RANK[visible]}"
	else "#{SUIT[suit]} #{RANK[visible]}"

prettyMove = (src,dst,b) ->
	c1 = _.last b[src]
	if b[dst].length > 0
		c2 = _.last b[dst]
		"#{prettyCard c1} to #{prettyCard c2,1}"
	else
		if dst in HEAPS then "#{prettyCard c1} to hole"
		else "#{prettyCard c1} to panel"

printSolution = (hash, b) ->
	key = makeKey b
	solution = []
	while key of hash
		[src,dst,b] = hash[key]
		solution.push hash[key]
		key = makeKey b
	solution.reverse()
	s = ''
	for [src,dst,b],index in solution
		s += "\n#{index}: #{prettyMove src,dst,b}"
	print s