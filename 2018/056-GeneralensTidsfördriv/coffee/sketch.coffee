# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

#  4  4  4  4  4  0  8  8  8  8  8
#  5  5  5  5  5  1  9  9  9  9  9
#  6  6  6  6  6  2 10 10 10 10 10
#  7  7  7  7  7  3 11 11 11 11 11
#    12 13 14 15    16 17 18 19      PANEL

ACES = [0,1,2,3]
HEAPS = [4,5,6,7,8,9,10,11]
PANEL = [12,13,14,15,16,17,18,19]

SUIT = "club heart spade diamond".split ' '
RANK = "A 2 3 4 5 6 7 8 9 T J Q K".split ' '
LONG = " Ace 2 3 4 5 6 7 8 9 Ten Jack Queen King".split ' '
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
classic = false
srcs = null
dsts = null

preload = -> 
	faces = loadImage 'cards/Color_52_Faces_v.2.0.png'
	backs = loadImage 'cards/Playing_Card_Backs.png'

range = _.range
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

compress = (board) ->
	for heap in HEAPS
		if board[heap].length > 1
			temp = board[heap][0]
			res = []
			for i in range 1,board[heap].length
				[suit1,h1,v1] = unpack temp
				[suit2,h2,v2] = unpack board[heap][i]
				if suit1==suit2 and 1 == abs v1-h2
					temp = pack suit1,h1,v2
				else
					res.push temp 
					temp = pack suit2,h2,v2
			res.push temp
			board[heap] = res

# suit är nollbaserad
# rank1 är nollbaserad
# rank2 är nollbaserad
# I talet räknas rank1 och rank2 upp
pack = (suit,rank1,rank2=rank1) ->
	if rank1 == rank2 then rank2 = -1 
	suit + 10 * (rank1+1) + 1000 * (rank2+1) # rank=1..13 suit=0..3 
assert 10, pack 0,0 # club A
assert 13, pack 3,0 # diamond A
assert 23, pack 3,1,1 # diamond 2
assert 12111, pack 1,10,11 # heart J,Q
assert 111, pack 1,10,10 # heart J,J

unpack = (n) -> 
	suit = n%10
	rank1 = (n//10)%100 
	rank2 = n//1000 
	if rank2 == 0 then rank2 = rank1
	[suit,rank1-1,rank2-1]
assert [0,0,0], unpack 10
assert [3,0,0], unpack 13
assert [1,10,11], unpack 12111

makeBoard = (maxRank,classic)->
	N = maxRank

	cards = []
	for suit in range 4
		for rank in range 1,maxRank # 2..K
			cards.push pack suit,rank 
	cards = _.shuffle cards

	board = []
	for i in range 20
		board.push []

	for suit,heap in range 4 
		board[heap].push pack suit,0 # Ess

	for heap in PANEL
		board[heap].push cards.pop()

	for card,i in cards
		board[if classic then 4+i%8 else int random 4,12].push card

	compress board
	#print board 

fakeBoard = ->
	board = [[10],[11],[12],[13],[],[],[],[],[],[],[],[],[21],[33],[23],[31],[30],[22],[32],[20]]

makeAutoShake = ->
	autoShake = []
	for i in range 52
		autoShake.push [int(random(-2,2)),int(random(-2,2))]

setup = ->
	createCanvas 800,600
	makeAutoShake()
	newGame '3'
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
		[suit,unvisible,visible] = unpack card
		dr = if unvisible < visible then 1 else -1
		for rank in range unvisible,visible+dr,dr
			[x0,y0] = if shake then autoShake[13*suit+rank] else [0,0]
			image faces, x0+x,y0+y+13, w,h, OFFSETX+W*rank,1092+H*suit,243,H
			x += dx

	card = _.last board[heap]
	[suit,unvisible,visible] = unpack card
	if heap in ACES and visible == N-1
		[x0,y0] = if shake then autoShake[13*suit+rank] else [0,0]
		image backs, x0+x,y0+y+13, w,h, OFFSETX+860,1092+622,243,H

display = (board) ->
	background 0,128,0

	textAlign CENTER,CENTER
	textSize 10

	x = width/2-5
	y = height-110

	fill 200
	text 'U = Undo',          x,y
	text 'R = Restart',       x,y+10
	text '3 4 5 6 = Easy',    x,y+20
	text '7 8 9 T = Medium',  x,y+30
	text 'J Q K = Hard',      x,y+40
	text 'C = Classic',       x,y+50
	text 'Space = Next',      x,y+60

	if timing != null then text "#{timing} seconds", x,y+105
	textSize 24
	text (if classic then 'Classic' else LONG[N]), x,y+84
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

	for heap,x in PANEL
		xx = [-8,-6,-4,-2,2,4,6,8][x]
		showHeap board, heap, xx,4, w

legalMove = (board,a,b) ->
	if a in ACES then return false 
	if b in PANEL then return false 
	if board[a].length==0 then return false
	if board[b].length==0 then return true
	[sa,a1,a2] = unpack _.last board[a]
	[sb,b1,b2] = unpack _.last board[b]
	if sa==sb and abs(a2-b2) == 1 then return true 
	false

makeMove = (board,a,b,record) -> # from heap a to heap b
	[suit,visible,unvisible] = unpack board[a].pop() # reverse order
	if record then hist.push [a, b, 1 + abs unvisible-visible]
	if board[b].length > 0
		[xx,unvisible,yy] = unpack board[b].pop()
	board[b].push pack suit,unvisible,visible 

undoMove = ([a,b,antal]) ->
	[suit, unvisible, visible] = unpack board[b].pop()
	if unvisible < visible
		board[a].push pack suit,visible, visible-antal+1
		if visible!=unvisible+antal-1 then board[b].push pack suit,unvisible,visible-antal
	else
		board[a].push pack suit,visible, visible+antal-1
		if unvisible!=visible+antal-1 then board[b].push pack suit,unvisible,visible+antal

mousePressed = -> 
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

	for heap in ACES.concat HEAPS 	
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
	#srcCards = calcSrcCards board
	display board

####### AI-section ########

#calcSrcCards 

findAllMoves = (b) ->
	srcs = HEAPS.concat PANEL 
	dsts = ACES.concat HEAPS 
	res = []
	for src in srcs
		used = false 
		for dst in dsts
			if src!=dst
				if legalMove b,src,dst
					if b[dst].length == 0 
						if used then continue
						used = true
					res.push [src,dst]
	res

makeKey = (b) -> 
	# kanske 4-11 bör sorteras först
	# följande kod medför hängning senare:
	# a = b.slice 0,4
	# c = b.slice 4,12
	# d = b.slice 12,20
	# c.sort()
	# b = a.concat(c).concat(d)

	res = ''
	for heap,index in b
		if heap.length==0
			res += '.'
		for card in heap
			[suit,r1,r2] = unpack card
			if r1==r2
				res += 'chsd'[suit] + RANK[r1]
			else
				res += 'chsd'[suit] + RANK[r1] + RANK[r2]
		res += '|'
	#print res 
	res 

calcAntal = (lst) ->
	res=0
	for card in lst
		[suit,unvisible,visible] = unpack card
		#print 'antal',card,suit,unvisible,visible
		res += 1 + abs(unvisible-visible)
	#print res
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
			#print level,key
			hash[key] = [src,dst,b]
			#print [countAceCards(b1), level+1, b1]
			res.push [countAceCards(b1), level+1, b1] 
	res

newGame = (key) ->
	start = millis()
	timing = null
	hist = []
	classic = key=='C'
	while true 
		if key in '3456789TJQK' then makeBoard 3+'3456789TJQK'.indexOf(key),classic
		if key in 'C' then makeBoard 13,classic

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
			print 'heapsize',_.size(hash)
			#for key of hash
			#	print key,hash[key]
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

nextLevel = ->
	if 4*N == countAceCards board
		N++
	else
		N--
	N = constrain N,3,13
	classic = false
	newGame '   3456789TJQK'[N]

keyPressed = -> 
	if key == 'U' and hist.length > 0 then undoMove hist.pop()
	if key == 'R' then restart()
	if key in '3456789TJQKC' then newGame key 
	if key == 'A' then shake = not shake
	if key == ' ' then nextLevel()
	display board
		
prettyCard = (card,antal=2) ->
	[suit,unvisible,visible] = unpack card 
	if antal==1 then "#{RANK[visible]}"
	else "#{SUIT[suit]} #{RANK[visible]}"
assert "diamond 3", prettyCard pack(3,2)
assert "3", prettyCard pack(3,2),1

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