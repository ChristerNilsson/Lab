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
msg = ''
autoShake = []
shake = true
N = null # Max rank
classic = false
srcs = null
dsts = null
hintsLeft = null

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

fakeBoard = ->
	N = 13
	classic = false 
	if N==3 then board = [[10],[11],[12],[13],[],[],[],[],[],[],[],[],[21],[33],[23],[31],[30],[22],[32],[20]] # 3
	if N==4 then board = [[10],[11],[12],[13],[32],[],[21],[],[],[],[41],[42],[33],[23],[31],[20],[43],[22],[30],[40]] # 4
	if N==4 then board = [[10],[11],[12],[13],[23,43],[],[],[],[],[],[41],[22],[32],[42],[31],[40],[33],[21],[20],[30]]
	if N==5 then board = [[10],[11],[12],[13],[21,30],[43,20],[],[53],[32],[50,22],[],[],[41],[51],[31],[42],[23],[52],[40],[33]] # 5
	if N==5 then board = [[10],[11],[12],[13],[],[3041],[20],[33],[42],[],[53],[4030],[52],[50],[32],[22],[51],[43],[21],[23]]
	if N==6 then board = [[10],[11],[12],[13],[32,51,5060],[62],[31],[],[22],[53],[42,3023],[52],[43],[30],[20],[61],[21],[41],[63],[40]] # 6 
	if N==7 then board = [[10],[11],[12],[13],[23,63],[],[20,72,50,21,51],[31,73,22],[53,41,61],[33],[],[6070],[62],[42],[71],[30],[43],[40],[32],[52]] # 7
	if N==7 then board = [[10],[11],[12],[13],[53,33],[30,72],[40,42],[23,73],[60,22,63],[],[71,43,5041],[61],[50],[52],[21],[62],[70],[20],[31],[32]]
	if N==8 then board = [[10],[11],[12],[13],[62,20,50,43,31,70],[51,60,2033,72],[52,22,81],[83],[73],[30,63],[41,40],[],[80],[42],[53],[71],[32],[21],[82],[61]] # 8
	if N==9 then board = [[10],[11],[12],[13],[53,80,71,91],[50,93,70],[42,81],[41,7063,61],[32,82,21],[20,40],[30,52,72],[62,92,90],[51],[83],[43],[33],[60],[23],[22],[31]] # 9
	if N==10 then board = [[10],[11],[12],[13],[93,90,41,20,83,23],[53,62,103],[100,43,61],[],[22,81,51,80,33],[102,73,31],[21,32,91,72],[50,52,82,40],[92],[70],[30],[60],[42],[63],[71],[101]] # T
	if N==11 then board = [[10],[11],[12],[13],[3042,53,93,33,103,82],[3021,72],[91,40],[111],[50,20,52,23,92,80,113,71,101],[100,43,90,83],[62,41],[70,61,112,63],[51],[60],[73],[22],[102],[81],[30],[110]] # J
	if N==12 then board = [[10],[11],[12],[13],[20,73],[60,100,33,92,71,51],[91,61,103,90,50],[80,93,121,23,52],[102,30,111,63,21,53,81],[122,83,112],[43,62,40],[42,70,123,41,22],[113],[31],[110],[120],[72],[101],[32],[82]] # Q
	if N==13 then board = [[10],[11],[12],[13],[22,53,100,40,33],[5061,102,131],[5062,93,73,42,60,72,83],[41,111,81,133,63,50,120],[70,71],[92,20,121,130],[11123,31,9080,23],[101,82,91,43],[32],[132],[112],[122],[21],[103],[110],[30]] # K
	if N==13 then board = [[10],[11],[12],[13],[50,101,112,43,42],[62,133,72,102,53],[71,63,111,30,80],[20,100,32,81,103],[51,22,61,92,91],[110,52,82,21,60],[122,121,41,83,123],[120,73,40,90,113],[93],[70],[33],[31],[131],[132],[23],[130]] # C

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
		for rank,i in range unvisible,visible+dr,dr
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

	if 4*N == countAceCards board 
		if hintsLeft==3
			msg = "#{(millis() - start) // 1000} seconds"
		else if hintsLeft==2
			msg = "1 hint used"
		else
			msg = "#{3-hintsLeft} hints used"

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
			[suit,r1,r2] = unpack card
			if r1==r2
				res += 'chsd'[suit] + RANK[r1]
			else
				res += 'chsd'[suit] + RANK[r1] + RANK[r2]
		res += '|'
	res 

calcAntal = (lst) ->
	res=0
	for card in lst
		[suit,unvisible,visible] = unpack card
		res += 1 + abs(unvisible-visible)
	res

countAceCards = (b) ->
	res	= 0
	for heap in ACES
		res += calcAntal b[heap]
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
	antal = 0
	while true 
		res = hintOne()
		if res or hist.length==0 
			print "Undos: #{antal} res #{res}"
			return
		undoMove hist.pop()
		antal++

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
		makeMove board,src,dst,true
		print "hint: #{int millis()-hintTime} ms"
		return true 
	else
		board = origBoard
		return false 

newGame = (key) ->
	start = millis()
	hintsLeft = 3
	msg = ''
	hist = []
	classic = key=='C'
	while true 
		if key in '3456789TJQK' then makeBoard 3+'3456789TJQK'.indexOf(key),classic
		if key in 'C' then makeBoard 13,classic

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
			#print 'heapsize',_.size(hash)
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
	if key == 'H' then hint()
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
		[path,b] = hash[key]
		solution.push hash[key]
		key = makeKey b
	solution.reverse()
	s = ''
	for [path,b],index in solution
		[src,dst] = _.last path 
		s += "\n#{index}: #{prettyMove src,dst,b}"
	print s
