# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

#  4  4  4  4  4  0  8  8  8  8  8
#  5  5  5  5  5  1  9  9  9  9  9
#  6  6  6  6  6  2 10 10 10 10 10
#  7  7  7  7  7  3 11 11 11 11 11
#    12 13 14 15    16 17 18 19      PANEL

# I vissa situationer vill man styra one click.
# Exempel:
# Vid klick på 6 vill man ha 7,6 istf 5,6
# 5     3,4,6      7
# Tidigare
# 5,6   3,4        7
# samt klick på 6 ger
#                  7,6,5
# men man vill kanske ha
# 5     3,4        7,6

SEQS = 8 # 6: kan fungera, 4: tar mkt lång tid att skapa problem

ACES = [0,1,2,3]
HEAPS = [4,5,6,7,8,9,10,11].slice 0,SEQS
PANEL = [12,13,14,15,16,17,18,19].slice 0,SEQS

Suit = 'chsd'
Rank = "A23456789TJQK"
SUIT = "club heart spade diamond".split ' '
RANK = "A23456789TJQK" 
LONG = " Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King".split ' '

# Konstanter för cards.png
OFFSETX = 468
W = 263.25
H = 352

w = null
h = null
LIMIT = 1000 # Maximum steps considered before giving up. 1000 is too low, hint fails sometimes.

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
N = null # Max rank
#classic = false
srcs = null
dsts = null
hintsUsed = null
oneClickData = {lastMarked:-1, counter:0}

level = 0
maxLevel = 15
maxMoves = null

print = console.log
range = _.range
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

preload = -> 
	faces = loadImage 'cards/Color_52_Faces_v.2.0.png'
	backs = loadImage 'cards/Playing_Card_Backs.png'

pack = (suit,under,over) -> Suit[suit] + RANK[under] + if under==over then '' else RANK[over]
assert 'cA', pack 0,0,0 
assert 'dA', pack 3,0,0 
assert 'd2', pack 3,1,1 
assert 'hJQ', pack 1,10,11 
assert 'hJ', pack 1,10,10 
#print 'pack ok'

unpack = (n) -> 
	suit = Suit.indexOf n[0]
	under = RANK.indexOf n[1] 
	if n.length==3 then over = RANK.indexOf n[2] else over = under
	[suit,under,over]
assert [0,0,0], unpack 'cA'
assert [3,0,0], unpack 'dA'
assert [1,10,11], unpack 'hJQ'
assert [1,10,10], unpack 'hJ'
#print 'unpack ok'

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
#print 'compressOne ok'

calcAntal = (lst) ->
	res = 0
	for card in lst
		[suit,under,over] = unpack card
		res += 1 + Math.abs under-over
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

dumpBoard = (board) -> (heap.join ' ' for heap in board).join '|'

makeBoard = (lvl)->
	N = [3,4,5,5,6,7,7,8,9,9,10,11,11,12,13,13][lvl]
	classic = lvl % 3 == 0
	#N = maxRank

	cards = []
	for suit in range 4
		for rank in range 1,N # 2..K
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
		zz = if classic then 4+i%SEQS else int random 4,4+SEQS
		board[zz].push card

	compress board

readBoard = (b) -> (if heap=='' then [] else heap.split ' ') for heap in b.split '|'

fakeBoard = ->
	N = 6
	classic = false 
	if N==6 then board = "cA|hA|sA|dA|h5|c3|s65|c2 d5||s3|d2 h6 d4|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6"
	if N==13 then board = "cA|hA|sA|dA|h6 s8 h3 s2 d5|dJ s3 c9 d7|sK h7 dQ s5 h5 d34|cQ sJ dT d6|c7 cK hT d2 s4 c8|sQ s7 cJ s9T h9|h8 c56 c4 hJ d8|cT c3|c2|h2|h4|s6|d9|hQ|hK|dK"
	if N==13 then board = "cA|hA|sA|dA|c5 c7 h2 d7 c9 s6 c3 d8 s9|h8 dQ cQK dK h7 s2 dT|c4 sJQ d5||hQ h54 c8 h3 d3|cJT s4 c6 s8 hJT|d2 d4 s5|h9 sK s3|d6|d9|sT|h6|s7|hK|dJ|c2"
	if N==13 then board = "cA2|hA|sA|dA|c5 c7 h2 d7 c9 s6 c3 d8 s9|h8 dQ cQK dK h7 s2 dT|c4 sJQ d5||hQ h54 c8 h3 d3|cJT s4 c6 s8 hJT|d2 d4 s5|h9 sK s3|d6|d9|sT|h6|s7|hK|dJ|"
	if N==13 then board = "cA2|hA|sA|dA|c5 c7 h2 d7 c9 s6 c3 d8 s9|h8 dQ cQK dK h7 s2 dT|c4 sJQ d5|s5|hQ h54 c8 h3 d3|cJT s4 c6 s8 hJT|d2 d4|h9 sK s3|d6|d9|sT|h6|s7|hK|dJ|"
	if N==13 then board = "cA|hA|sA|dA|c9 h3 s8|h5 s7 sJ hK h4 s3 c7 hT s4|s9 d2|s5 d7 c4|s6 h9|c3 d3 h6|d6 d8 dK sT s2 c5 cK c6 c8 d4 h2|dT hQ cT d5 hJ dJ cJ|c2|d9|sQ|cQ|h7|dQ|sK|h8"
	if N==13 then board = "cA|hA|sA|dA|s4 cJ s3 c3 dK hJ cQ c2 h4|sQK|s9 d2 dT|s2 dQ sJ hT|d8 h3 d7 h5 h2 c9|d3 s6 sT d9 c7 c4|cK c8 h7 c5|dJ hK s87 s5 cT|d6|h9|d4|h8|d5|h6|c6|hQ"
	board = readBoard board
	print board

setup = ->
	print 'Z'
	createCanvas innerWidth, innerHeight-0.5
	w = width/9 
	h = height/4 
	angleMode DEGREES

	newGame 0
	display board 

keyPressed = -> 
	if key == 'X' 
		N = 7
		board = "cA7|hA4|sA3|dA2||h6|s5 d6||h5 d5||s4 s6|d34||d7|s7|h7||||"
		hist = [[12,0,1],[5,1,1],[8,3,1],[9,1,1],[11,1,1],[16,2,1],[17,0,1],[10,0,1],[9,0,1],[18,2,1],[19,0,1],[7,0,1]]		
		board = readBoard board
		print board 
	display board

menu1 = ->
	dialogue = new Dialogue width/2,height/2,0.15*h 

	r1 = 0.25 * height 
	r2 = 0.085 * height
	dialogue.clock ' ',6,r1,r2,120 #360/14+90

	dialogue.buttons[0].info ['Undo',hist.length], -> 
		if hist.length > 0 then undoMove hist.pop()
		dialogues.pop()

	dialogue.buttons[1].info ['Hint',hintsUsed], -> 
		hint()
		dialogues.pop()

	dialogue.buttons[5].info 'Easier', -> 
		level = constrain level-1,0,maxLevel
		newGame level
		dialogues.pop()

	#menu2 'Level','C3 W4 W5 C5 W6 W7 C7 W8 W9 C9 WT WJ CJ WQ WK CK '

	# dialogue.buttons[3].info 'Next', ->
	# 	nextLevel()
	# 	dialogues.pop()

	dialogue.buttons[4].info 'Link'

	dialogue.buttons[3].info 'Restart', -> 
		restart()
		dialogues.pop()

	dialogue.buttons[2].info 'Harder', -> 
		level = constrain level+1,0,maxLevel
		newGame level
		dialogues.pop()

# menu2 = (title,items) -> 
# 	dialogue = new Dialogue width/2,height/2,0.15*h
# 	items = items.split ' '
# 	r1 = 0.4 * height 
# 	r2 = 0.07 * height
# 	dialogue.clock title,items.length,r1,r2

# 	for lvl,i in items
# 		do -> 
# 			button = dialogue.buttons[i]	
# 			index = i
# 			button.txt = lvl 
# 			button.event = -> 
# 				newGame index 
# 				dialogues.pop()
# 				dialogues.pop()

showHeap = (board,heap,x,y,dy) -> # dx kan vara både pos och neg
	n = calcAntal board[heap]
	if n==0 then return 
	y = y * h + y * dy
	x = x * w 
	for card,k in board[heap]
		[suit,under,over] = unpack card
		dr = if under < over then 1 else -1
		for rank in range under,over+dr,dr
			noFill()
			stroke 0
			image faces, x, y, w,h*1.1, OFFSETX+W*rank,1092+H*suit,225,H-1
			y += dy

	# visa eventuellt baksidan
	card = _.last board[heap]
	[suit,under,over] = unpack card
	if heap in ACES and over == N-1
		image backs, x, y, w,h*1.1, OFFSETX+860,1092+622,225,H-1

display = (board) ->
	background 0,128,0

	textAlign LEFT,BOTTOM
	fill 64
	textSize 0.2*h
	text 'Generalens Tidsfördriv', 0.05*w,3*h

	textAlign CENTER,BOTTOM
	if hintsUsed == 0 then text msg, width/2,3*h

	textAlign RIGHT,BOTTOM
	text "#{if level%3==0 then 'Classic' else 'Wild'} #{LONG[N]}", 7.95*w,3*h

	textAlign CENTER,TOP
	for heap,y in ACES
		showHeap board, heap, 8, y, 0
	for heap,x in HEAPS
		n = calcAntal board[heap]
		dy = min h/4,(2-0.0)*h/(n-1)
		showHeap board, heap, x, 0, dy
	for heap,x in PANEL
		showHeap board, heap, x, 3, 0

	noStroke()
	showDialogue()

showDialogue = -> if dialogues.length>0 then (_.last dialogues).show()

legalMove = (board,src,dst) ->
	if src in ACES then return false 
	if dst in PANEL  then return false 
	if board[src].length==0 then return false
	if board[dst].length==0 then return true
	[suit1,under1,over1] = unpack _.last board[src]
	[suit2,under2,over2] = unpack _.last board[dst]
	if suit1 == suit2 and 1 == Math.abs over1-over2 then return true 
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
	msg = ''
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

# returns destination
oneClick = (data,marked,board,sharp=false) ->
	if _.isEqual data.lastMarked, marked then data.counter++ else data.counter = 0

	holes = []
	found = false

	for heap in ACES
		if legalMove board,marked[0],heap  
			if sharp then makeMove board,marked[0],heap,true
			found = true 
			return heap

	if not found # Går ej att flytta till något ess. 
		alternativeDsts = [] # för att kunna välja mellan flera via Undo
		for heap in HEAPS
			if board[heap].length == 0
				if marked[0] in PANEL or calcAntal(board[marked[0]]) > 1
					holes.push heap
			else 
				if legalMove board,marked[0],heap
					alternativeDsts.push heap
		if holes.length > 0 then alternativeDsts.push holes[0]		

		if alternativeDsts.length > 0
			heap = alternativeDsts[data.counter % alternativeDsts.length]  
			if sharp then makeMove board,marked[0],heap,true
			data.lastMarked = marked 
			return heap

	return marked[0] # no Move can happen

# assert1.jpg
b1 = readBoard "cA|hA|sA|dA|h5|c3|s65|c2 d5||s3|d2 h6 d4|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6"
assert 11, oneClick {lastMarked:0, counter:0},[4,0],b1 # hj5 to hj4
assert 5,  oneClick {lastMarked:0, counter:0},[5,0],b1 # kl3 no move
assert 8,  oneClick {lastMarked:0, counter:0},[6,1],b1 # sp5 to hole

assert 10, oneClick {lastMarked:0, counter:0},[7,1],b1 # ru5 to ru4
assert 8,  oneClick {lastMarked:[7,1], counter:0},[7,1],b1 # ru5 to hole

assert 8, oneClick {lastMarked:0, counter:0},[8,-1],b1 # hole click
assert 9, oneClick {lastMarked:0, counter:0},[9,0],b1 # sp3 no move

assert 7, oneClick {lastMarked:0, counter:0},[10,2],b1 # ru4 to ru5
assert 8, oneClick {lastMarked:[10,2], counter:0},[10,2],b1 # ru4 to hole
assert 7, oneClick {lastMarked:[10,2], counter:1},[10,2],b1 # ru4 to ru5

b1a = readBoard "cA|hA|sA|dA|h5|c3|s65|c2 d54||s3|d2 h6|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6"
assert 4, oneClick {lastMarked:[10,2], counter:0},[10,1],b1a # hj6 to hj5
assert 8, oneClick {lastMarked:[10,1], counter:0},[10,1],b1a # hj6 to hole

assert 4, oneClick {lastMarked:0, counter:0},[11,1],b1 # hj4 to hj5
assert 8, oneClick {lastMarked:[11,1], counter:0},[11,1],b1 # hj4 to hole xxx

assert 1, oneClick {lastMarked:0, counter:0},[12,0],b1 # hj2 to A
assert 8, oneClick {lastMarked:0, counter:0},[13,0],b1 # kl5 to hole

assert 5, oneClick {lastMarked:0, counter:0},[14,0],b1 # kl4 to kl3
assert 8, oneClick {lastMarked:[14,0], counter:0},[14,0],b1 # kl4 to hole

assert 11, oneClick {lastMarked:0, counter:0},[15,0],b1 # hj3 to hj4
assert 8, oneClick {lastMarked:[15,0], counter:0},[15,0],b1 # hj3 to hole

assert 8, oneClick {lastMarked:0, counter:0},[16,0],b1 # kl6 to hole

assert 6, oneClick {lastMarked:0, counter:0},[17,0],b1 # sp4 to sp5
assert 9, oneClick {lastMarked:[17,0], counter:0},[17,0],b1 # sp4 to sp3
assert 8, oneClick {lastMarked:[17,0], counter:1},[17,0],b1 # sp4 to hole

assert 2, oneClick {lastMarked:0, counter:0},[18,0],b1 # sp2 to A

assert 7, oneClick {lastMarked:0, counter:0},[19,0],b1 # ru6 to ru5
assert 8, oneClick {lastMarked:[19,0], counter:0},[19,0],b1 # ru6 to hole

# assert2.jpg
b2 = readBoard "cA|hA|sA|dA|d5 h2 d3 h3|c7|c34|d4 h76|||s3 d6 c6|d7 c5 d2|c2|s4|s6|h5|s5|s7|s2|h4"
#assert 8, oneClick {lastMarked:0, marked:9, counter:0},b2 #hj6 to hole

mousePressed = -> 

	if not (0 < mouseX < width) then return
	if not (0 < mouseY < height) then return

	dialogue = _.last dialogues
	if dialogues.length==0 or not dialogue.execute mouseX,mouseY 

		mx = mouseX//w
		my = mouseY//h

		if mx == 8 
			if dialogues.length == 0 then menu1() else dialogues.pop()
			display board
			return

		marked = [(mx + if my >= 3 then 12 else 4),my]
		heap = oneClick oneClickData,marked,board,true

		if msg == '' and 4*N == countAceCards board 
			nextLevel()
			msg = "#{(millis() - start) // 1000} s"
			printManualSolution()

	print "#{hist.length} of #{maxMoves} moves"
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

expand = ([aceCards,level,b,path]) ->
	res = []
	moves = findAllMoves b
	for move in moves
		[src,dst] = move
		b1 = _.cloneDeep b
		makeMove b1,src,dst
		key = dumpBoard b1
		if key not of hash
			newPath = path.concat [move]
			hash[key] = [newPath, b]
			res.push [countAceCards(b1), level+1, b1, path.concat([move])] 
	res

hint = ->
	if 4*N == countAceCards board then return 
	hintsUsed++
	res = hintOne()
	if res or hist.length==0 then return 
	undoMove hist.pop()

hintOne = -> 
	hintTime = millis()
	aceCards = countAceCards board
	if aceCards == N*4 then return true
	cands = []
	cands.push [aceCards,hist.length,board,[]] # antal kort på ässen, antal drag, board
	hash = {}
	nr = 0
	cand = null
	origBoard = _.cloneDeep board

	while nr < 10000 and cands.length > 0 and aceCards < N*4
		nr++ 
		cand = cands.pop()
		aceCards = cand[0]
		if aceCards < N*4 
			increment = expand cand
			cands = cands.concat increment
			cands.sort (a,b) -> if a[0] == b[0] then b[1]-a[1] else a[0]-b[0]
	print N,nr,cands.length,aceCards

	if aceCards == N*4
		board = cand[2]
		#printAutomaticSolution hash, board
		path = cand[3]
		board = origBoard
		[src,dst] = path[0]
		makeMove board,src,dst,true
		print "hint: #{int millis()-hintTime} ms"
		return true
	else
		print 'hint failed. Should never happen!'
		#print N,nr,cands.length,aceCards,_.size hash
		board = origBoard
		return false

newGame = (lvl) -> # 0..15
	level = lvl
	start = millis()
	msg = ''
	hist = []
	while true 
		makeBoard level 
		hintsUsed = 0
		originalBoard = _.cloneDeep board

		aceCards = countAceCards board		
		cands = []
		cands.push [aceCards,0,board,[]] # antal kort på ässen, antal drag, board
		hash = {}
		nr = 0
		cand = null

		while nr < LIMIT and cands.length > 0 and aceCards < N*4
			nr++ 
			cand = cands.pop()
			aceCards = cand[0]
			increment = expand cand
			cands = cands.concat increment
			cands.sort (a,b) -> if a[0] == b[0] then b[1]-a[1] else a[0]-b[0]

		if aceCards == N*4
			print JSON.stringify dumpBoard originalBoard 
			board = cand[2]
			printAutomaticSolution hash,board
			board = _.cloneDeep originalBoard
			print "#{int millis()-start} ms"
			start = millis()
			maxMoves = int cand[1] * 1.1 # +10%
			print 'maxMoves',maxMoves
			return 

restart = ->
	hist = []
	board = _.cloneDeep originalBoard
	msg = ''

nextLevel = ->
	if hist.length <= maxMoves and level <= maxLevel and hintsUsed == 0 and 4*N == countAceCards board then level++ else level--
	level = constrain level,0,15
	if level>maxLevel then maxLevel=level
	newGame level

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
#print 'prettyCard ok'

prettyMove = (src,dst,b) ->
	c1 = _.last b[src]
	if b[dst].length > 0
		c2 = _.last b[dst]
		"#{prettyCard c1} to #{prettyCard c2,1}"
	else
		if dst in HEAPS then "#{prettyCard c1} to hole"
		else "#{prettyCard c1} to panel"

printAutomaticSolution = (hash, b) ->
	key = dumpBoard b
	solution = []
	while key of hash
		[path,b] = hash[key]
		solution.push hash[key]
		key = dumpBoard b
	solution.reverse()
	s = 'Automatic Solution:'
	for [path,b],index in solution
		[src,dst] = _.last path 
		s += "\n#{index}: #{prettyMove src,dst,b} (#{src} to #{dst})"
	print s

printManualSolution = ->
	b = _.cloneDeep originalBoard
	s = 'Manual Solution:'
	for [src,dst,antal],index in hist
		s += "\n#{index}: #{prettyMove src,dst,b}"
		makeMove b,src,dst,false
	print s