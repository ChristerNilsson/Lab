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

Suit = 'chsd'
Rank = "A23456789TJQK"
SUIT = "club heart spade diamond".split ' '
RANK = "A23456789TJQK" #.split ' '
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
msg = ''
autoShake = []
shake = true
N = null # Max rank
classic = false
srcs = null
dsts = null
hintsLeft = null
maxHints = null

preload = -> 
	faces = loadImage 'cards/Color_52_Faces_v.2.0.png'
	backs = loadImage 'cards/Playing_Card_Backs.png'

print = console.log
range = _.range
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

pack = (suit,under,over) -> Suit[suit] + Rank[under] + if under==over then '' else Rank[over]
assert 'cA', pack 0,0,0 
assert 'dA', pack 3,0,0 
assert 'd2', pack 3,1,1 
assert 'hJQ', pack 1,10,11 
assert 'hJ', pack 1,10,10 
print 'pack ok'

unpack = (n) -> 
	suit = Suit.indexOf n[0]
	under = Rank.indexOf n[1] 
	if n.length==3 then over = Rank.indexOf n[2] else over = under
	[suit,under,over]
assert [0,0,0], unpack 'cA'
assert [3,0,0], unpack 'dA'
assert [1,10,11], unpack 'hJQ'
assert [1,10,10], unpack 'hJ'
print 'unpack ok'

compress = (board) ->
	for heap in HEAPS
		board[heap] = compressOne board[heap]

compressOne = (cards) ->
	if cards.length > 1
		res = []
		temp = cards[0]
		for i in range 1,cards.length
			[suit1,under1,over1] = unpack temp     # understa
			[suit2,under2,over2] = unpack cards[i] # översta
			if suit1 == suit2 and under2-over1 in [-1,1]
				temp = pack suit1,under1,over2
			else
				res.push temp 
				temp = pack suit2,under2,over2
		res.push temp
		res
	else 
		cards
assert [],compressOne [] 
assert ['cA'],compressOne ['cA'] 
assert ['cA2'],compressOne ['cA','c2'] 
assert ['c23'],compressOne ['c2','c3'] 
assert ['cA4'],compressOne ['cA2','c34'] 
assert ['cA3'],compressOne ['cA','c2','c3'] 
assert ['cA6'],compressOne ['cA2','c34','c56'] 
assert ['cA2','h34','c56'],compressOne ['cA2','h34','c56'] 
print 'compressOne ok'

dumpBoard = (board) -> heap.join ' ' for heap in board
		
makeBoard = (maxRank,classic)->
	N = maxRank

	cards = []
	for suit in range 4
		for rank in range 1,maxRank # 2..K
			cards.push pack suit,rank,rank 
	cards = _.shuffle cards

	board = []
	for i in range 20
		board.push []

	for suit,heap in range 4 
		board[heap].push pack suit,0,0 # Ess

	for heap in PANEL
		board[heap].push cards.pop()

	for card,i in cards
		board[if classic then 4+i%8 else int random 4,12].push card

	compress board

fakeBoard = ->
	N = 13
	classic = false 
	if N==13 then board = ["cA","hA","sA","dA","cQ d2 d5 cJ c8 d8","h5 sJ c4 dK h8 sT","h6 d4 c56 cT s8","d9 s4 h3 d3","s2 c7 s9","h4 h7 hK s65","hQ sK dJ sQ c2 d7 c9","hT c3 h2","d6","dQ","s3","dT","cK","s7","h9","hJ"]
	if N==13 then board = ["cA","hA","sA","dA","dK hQ h6 d7 h7","s6 d6 cJ dQ dT","s8 s45 d3 sT","c7 sK hK c8 d8","c3 s9 c9 s3 h9","h4 c6 sJ h3 d2","cT c4 s7 d5 h5","hJ d9 dJ h8 h2","cQ","s2","c2","d4","c5","sQ","cK","hT"] # 146 s

makeAutoShake = ->
	autoShake = []
	for i in range 52
		autoShake.push [int(random(-2,2)),int(random(-2,2))]

setup = ->
	createCanvas 800,600
	makeAutoShake()
	newGame '3'
	display board 

showHeap = (board,heap,x,y,dx) -> # dx kan vara både pos och neg
	n = calcAntal board[heap]
	if n==0 then return 
	x0 = width/2 - w/2
	if x < 0 then x0 += -w+dx
	if x > 0 then x0 += w-dx
	x = x0 + x*dx/2
	y = y * h
	for card,k in board[heap]
		[suit,under,over] = unpack card
		dr = if under < over then 1 else -1
		for rank in range under,over+dr,dr
			[x0,y0] = if shake then autoShake[13*suit+rank] else [0,0]
			image faces, x0+x,y0+y+13, w,h, OFFSETX+W*rank,1092+H*suit,243,H
			x += dx

	# visa eventuellt baksidan
	card = _.last board[heap]
	[suit,under,over] = unpack card
	if heap in ACES and over == N-1
		[x0,y0] = if shake then autoShake[13*suit+rank] else [0,0]
		image backs, x0+x,y0+y+13, w,h, OFFSETX+860,1092+622,243,H

display = (board) ->
	background 0,128,0

	textAlign CENTER,CENTER
	textSize 10

	x = width/2-5+2
	y = height-110

	fill 200
	text 'U = Undo',          x,y
	text 'R = Restart',       x,y+10

	text '3 4 5 6 7 8 9 T J Q K',    x,y+20
	text 'Easy    Level    Hard',    x,y+30

	text 'C = Classic',       x,y+40
	text 'Space = Next',      x,y+60
	text "H = Hint (#{hintsLeft} left)", x,y+70

	text msg, x,y+105
	textSize 24
	text (if classic then 'Classic' else LONG[N]), x,y+89
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

legalMove = (board,src,dst) ->
	if src in ACES then return false 
	if dst in PANEL then return false 
	if board[src].length==0 then return false
	if board[dst].length==0 then return true
	[suit1,under1,over1] = unpack _.last board[src]
	[suit2,under2,over2] = unpack _.last board[dst]
	if suit1==suit2 and abs(over1-over2) == 1 then return true 
	false

makeMove = (board,src,dst,record) -> 
	[suit,under1,over1] = unpack board[src].pop() 
	over = under1 
	under = over1 
	if record then hist.push [src, dst, 1 + abs under1-over1]
	if board[dst].length > 0
		[suit2,under2,over2] = unpack board[dst].pop()
		under = under2 
	board[dst].push pack suit,under,over 

# returns text move
undoMove = ([src,dst,antal]) -> 
	res = prettyUndoMove src,dst,board,antal
	[board[src],board[dst]] = undoMoveOne board[src],board[dst],antal
	res

undoMoveOne = (a,b,antal) ->
	[suit, under, over] = unpack b.pop()
	if under < over 
		a.push pack suit,over,over-antal+1
		if over-under != antal-1	
			b.push pack suit,under,over-antal
	else
		a.push pack suit,over,over+antal-1
		if under-over != antal-1
			b.push pack suit,under,over+antal #
	[a,b]
assert [['d9T'],['dJ']], undoMoveOne [],['dJ9'],2
assert [['d9'],['dJT']], undoMoveOne [],['dJ9'],1

prettyUndoMove = (src,dst,b,antal) ->
	c2 = _.last b[dst]
	if b[src].length > 0
		c1 = _.last b[src]
		"#{prettyCard2 c2,antal} to #{prettyCard c1}"
	else
		if src in HEAPS then "#{prettyCard2 c2,antal} to hole"
		if src in PANEL then "#{prettyCard2 c2,antal} to panel"

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

	if 4*N == countAceCards board 
		if hintsLeft == maxHints
			msg = "#{(millis() - start) // 1000} seconds"
		else if hintsLeft == maxHints-1
			msg = "1 hint used"
		else
			msg = "#{maxHints - hintsLeft} hints used"

	display board

####### AI-section ########

findAllMoves = (b) ->
	srcs = HEAPS.concat PANEL 
	dsts = ACES.concat HEAPS 
	res = []
	for src in srcs
		for dst in dsts
			if src != dst
				if legalMove b,src,dst
					res.push [src,dst]
	res

makeKey = (b) -> 
	res = ''
	for heap,index in b
		if heap.length==0
			res += '.'
		for card in heap
			[suit,under,over] = unpack card
			if under==over
				res += 'chsd'[suit] + RANK[over]
			else
				res += 'chsd'[suit] + RANK[under] + RANK[over]
		res += '|'
	res 

calcAntal = (lst) ->
	res = 0
	for card in lst
		[suit,under,over] = unpack card
		res += 1 + abs under-over
	res

countAceCards = (b) ->
	res	= 0
	for heap in ACES
		res += calcAntal b[heap]
	res

countPanelCards = (b) ->
	res	= 0
	for heap in PANEL
		res += b[heap].length
	res

expand = ([aceCards,level,b,path]) ->
	res = []
	moves = findAllMoves b
	for move in moves
		[src,dst] = move
		b1 = _.cloneDeep b
		makeMove b1,src,dst
		key = makeKey b1
		if key not of hash
			newPath = path.concat([move])
			hash[key] = [newPath, b]
			res.push [countAceCards(b1), level+1, b1, path.concat([move])] 
	res

hint = ->
	if hintsLeft == 0 then return
	hintsLeft--
	undone = []
	while true 
		res = hintOne()
		if res? or hist.length==0
			for u in undone
				print "Undo: #{u}"
			print "Move: #{res}"
			return
		card = hist.pop()
		undone.push undoMove card

hintOne = -> 
	hintTime = millis()
	aceCards = countAceCards board
	if aceCards == N*4 then return 
	cands = []
	cands.push [aceCards,hist.length,board,[]] # antal kort på ässen, antal drag, board
	hash = {}
	nr = 0
	cand = null
	origBoard = _.cloneDeep board

	while nr < LIMIT and cands.length > 0 and aceCards < N*4
		nr++ 
		cand = cands.pop()
		aceCards = cand[0]
		if aceCards < N*4 
			increment = expand cand
			cands = cands.concat increment
			cands.sort (a,b) -> if a[0] == b[0] then b[1]-a[1] else a[0]-b[0]

	if aceCards == N*4
		board = cand[2]
		path = cand[3]
		board = origBoard
		[src,dst] = path[0]
		s = prettyMove src,dst,board
		makeMove board,src,dst,true
		print "hint: #{int millis()-hintTime} ms"
		return s
	else
		board = origBoard
		return null

newGame = (key) ->
	start = millis()
	msg = ''
	hist = []
	classic = key=='C'
	while true 
		if key in '3456789TJQK' then makeBoard 3+'3456789TJQK'.indexOf(key),classic
		if key in 'C' then makeBoard 13,classic
		maxHints = N
		hintsLeft = maxHints
		originalBoard = _.cloneDeep board

		aceCards = countAceCards board		
		cands = []
		cands.push [aceCards,0,board,[]] # antal kort på ässen, antal drag, board
		hash = {}
		nr = 0
		cand = null

		#print LIMIT,N,nr,cands.length,aceCards
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
			print JSON.stringify dumpBoard originalBoard 
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
	if key == 'H' then hint()
	if key == 'X' 
		N = 13
		board = [[101],[10103],[20101],[30103],[10404,30808,1313,1009],[506],[10707,303,20202,20505,20708],[11212,1111,20303,21010],[202,10808,707,20404],[10909,10505,20909,10606],[11010,21111,808,20606,31109],[11111,21313,30404,404,30705],[21212],[31313],[],[1212],[31212],[],[],[11313]]
		hist = [[4,6,1],[7,10,1],[9,1,1],[17,3,1],[18,4,1],[14,8,1],[5,3,1],[8,11,2],[5,1,1],[5,10,1]]
	display board
		
prettyCard2 = (card,antal) ->
	[suit,under,over] = unpack card 
	if antal==1 
		"#{SUIT[suit]} #{RANK[over]}"
	else
		if under < over
			"#{SUIT[suit]} #{RANK[over]}..#{RANK[over-antal+1]}"
		else
			"#{SUIT[suit]} #{RANK[over]}..#{RANK[over+antal-1]}"

prettyCard = (card,antal=2) ->
	[suit,under,over] = unpack card 
	if antal==1 then "#{RANK[over]}"
	else "#{SUIT[suit]} #{RANK[over]}"
assert "club A", prettyCard pack 0,0,0
assert "club T", prettyCard pack 0,9,9
assert "heart J", prettyCard pack 1,10,10
assert "spade Q", prettyCard pack 2,11,11
assert "diamond K", prettyCard pack 3,12,12
assert "3", prettyCard pack(3,2,2),1
print 'prettyCard ok'

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
		[path,b] = hash[key]
		solution.push hash[key]
		key = makeKey b
	solution.reverse()
	s = ''
	for [path,b],index in solution
		[src,dst] = _.last path 
		s += "\n#{index}: #{prettyMove src,dst,b}"
	print s
