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

ACES = [0,1,2,3]
HEAPS = [4,5,6,7,8,9,10,11]
PANEL = [12,13,14,15,16,17,18,19]

Suit = 'chsd'
Rank = "A23456789TJQK"
SUIT = "club heart spade diamond".split ' '
RANK = "A23456789TJQK" 
LONG = " Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King Classic".split ' '

# Konstanter för cards.png
OFFSETX = 468
W = 263.25
H = 352

w = null
h = null
LIMIT = 1000 # Maximum steps considered before giving up.

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
classic = false
srcs = null
dsts = null
hintsUsed = null
#maxHints = null
counter = 0
scaleFactor = null

dialogues = []

print = console.log
range = _.range
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

class Dialogue 
	constructor : (@x,@y,@textSize=20) -> 
		@buttons = []
		dialogues.push @
	add : (button) -> 
		button.dlg = @
		@buttons.push button	
	show : ->
		fill 255,255,0,128
		push()
		translate @x,@y
		textSize @textSize
		for button in @buttons
			button.show @
		pop()
	execute : (mx,my) ->
		for button in @buttons
			if button.inside mx,my,@
				button.execute()
				return true
		false 

class Button 
	constructor : (@txt, @x, @y, @r, @event = -> print @txt) ->
	info : (@txt,@event) ->
	show : ->
		ellipse @x,@y,2*@r,2*@r
		push()
		fill 0
		stroke 0
		textAlign CENTER,CENTER
		textSize @dlg.textSize
		text @txt, @x,@y
		pop()
	inside : (mx,my) -> @r > dist mx, my, @dlg.x + @x, @dlg.y + @y
	execute : -> @event()

preload = -> 
	faces = loadImage 'cards/Color_52_Faces_v.2.0.png'
	backs = loadImage 'cards/Playing_Card_Backs.png'

pack = (suit,under,over) -> Suit[suit] + Rank[under] + if under==over then '' else Rank[over]
assert 'cA', pack 0,0,0 
assert 'dA', pack 3,0,0 
assert 'd2', pack 3,1,1 
assert 'hJQ', pack 1,10,11 
assert 'hJ', pack 1,10,10 
#print 'pack ok'

unpack = (n) -> 
	suit = Suit.indexOf n[0]
	under = Rank.indexOf n[1] 
	if n.length==3 then over = Rank.indexOf n[2] else over = under
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

dumpBoard = (board) -> (heap.join ' ' for heap in board).join '|'
		
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

readBoard = (b) -> heap.split ' ' for heap in b.split '|'

fakeBoard = ->
	N = 13
	classic = false 
	if N==13 then board = "cA|hA|sA|dA|h6 s8 h3 s2 d5|dJ s3 c9 d7|sK h7 dQ s5 h5 d34|cQ sJ dT d6|c7 cK hT d2 s4 c8|sQ s7 cJ s9T h9|h8 c56 c4 hJ d8|cT c3|c2|h2|h4|s6|d9|hQ|hK|dK"
	board = readBoard board

setup = ->
	# Lås upplösning till 1280x709 (borde dock vara 1920x1200)
	# Skala därefter om.
	print windowWidth,windowHeight
	createCanvas windowWidth-0.5,windowHeight - 0.5
	print scaleFactor = min height/709,width/1280
	w = W/2.2
	h = H/2.2

	newGame '3'

	x = width/2 
	y = 709-110
	dialogue = new Dialogue x,y
	dialogue.add new Button 'Undo',-578,0.3*h, 0.25*h, -> if hist.length > 0 then undoMove hist.pop()
	dialogue.add new Button 'Menu',   0,0.3*h, 0.25*h, -> menu()
	dialogue.add new Button 'Hint', 578,0.3*h, 0.25*h, -> hint()

	display board 

keyPressed = -> 
	if key == 'X' 
		N = 13
		board = [[101],[10103],[20101],[30103],[10404,30808,1313,1009],[506],[10707,303,20202,20505,20708],[11212,1111,20303,21010],[202,10808,707,20404],[10909,10505,20909,10606],[11010,21111,808,20606,31109],[11111,21313,30404,404,30705],[21212],[31313],[],[1212],[31212],[],[],[11313]]
		hist = [[4,6,1],[7,10,1],[9,1,1],[17,3,1],[18,4,1],[14,8,1],[5,3,1],[8,11,2],[5,1,1],[5,10,1]]
	display board

menu = ->
	dialogue = new Dialogue 0,0,32

	angleMode DEGREES

	x = width/2
	y = height/2

	r1 = 290
	r2 = 60
	for i in range 15
		v = i*360/15
		dialogue.add new Button '', x+r1*cos(v), y+r1*sin(v), r2, -> 

	dialogue.add new Button 'Back',x,y,r2, -> dialogues.pop()

	for level,i in LONG.slice 3
		print level,i
		f = -> 
			button = dialogue.buttons[i]	
			index = i+2
			button.txt = level 
			button.event = -> 
				newGame "A23456789TJQKC"[index]
				dialogues.pop()
		f()

	xoff = 100
	yoff = 500
	bstep = 2*w+32

	dialogue.buttons[12].info 'Restart', -> 
		restart()
		dialogues.pop()

	dialogue.buttons[13].info 'Next', ->
		nextLevel()
		dialogues.pop()

	dialogue.buttons[14].info 'Link'
	
showHeap = (board,heap,x,y,dx) -> # dx kan vara både pos och neg
	n = calcAntal board[heap]
	if n==0 then return 

	x0 = 1280/2 - w/2

	if x < 0 then x0 += -w+dx
	if x > 0 then x0 += w-dx
	x = x0 + x*dx/2
	y = y * 0.9*h - 10
	for card,k in board[heap]
		[suit,under,over] = unpack card
		dr = if under < over then 1 else -1
		for rank in range under,over+dr,dr
			image faces, x,y+13, w,h, OFFSETX+W*rank,1092+H*suit,243,H
			x += dx

	# visa eventuellt baksidan
	card = _.last board[heap]
	[suit,under,over] = unpack card
	if heap in ACES and over == N-1
		image backs, x,y+13, w,h, OFFSETX+860,1092+622,243,H

display = (board) ->
	background 0,128,0

	scale scaleFactor

	fill 200

	textSize 20

	x = width/2
	y = height

	textAlign CENTER,CENTER
	text hist.length,  w/2,709-h+40
	text 'Generalens', w/2,709-5

	text (if classic then 'Classic' else LONG[N]), x,709-h+40
	text '73s', x,709-h+160

	text hintsUsed, width-w/2,709-h+40
	text 'Tidsfördriv', width-w/2,709-h+160

	for heap,y in ACES
		showHeap board, heap, 0, y, 0

	for heap,y in [4,5,6,7]
		n = calcAntal board[heap]
		dx = if n<=7 then w/2 else min w/2,(width/2-w/2-w)/(n-1)
		showHeap board, heap, -2, y, -dx

	for heap,y in [8,9,10,11]
		n = calcAntal board[heap]
		dx = if n<=7 then w/2 else min w/2,(width/2-w/2-w)/(n-1)
		showHeap board, heap, 2, y, dx

	for heap,x in PANEL
		xx = [-8,-6,-4,-2,2,4,6,8][x]
		showHeap board, heap, xx,4, w-7

	showDialogue()

showDialogue = -> (_.last dialogues).show()

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

mousePressed = -> 

	counter++
	if not (0 < mouseX < width) then return
	if not (0 < mouseY < height) then return

	dialogue = _.last dialogues
	mx = mouseX/scaleFactor
	my = mouseY/scaleFactor
	if not dialogue.execute mx,my 
	
		offset = (1280-9*w)/2
		marked = null
		mx = (mouseX/scaleFactor-offset)//w
		my = mouseY/scaleFactor//h
		if my >= 4
			if mx<=3 then marked = 12 + mx
			if mx>=5 then marked = 11 + mx
		else
			if mx==4 then marked = my
			else if mx<4 then marked = [4,5,6,7][my]
			else marked = [8,9,10,11][my]
		#print 'marked',marked 

		if marked != null
			holes = []
			found = false

			alternativeDsts = [] # för att kunna välja mellan flera via Undo
			for heap in ACES.concat HEAPS
				if board[heap].length==0 then holes.push heap
				if heap not in holes and legalMove board,marked,heap  
					alternativeDsts.push heap
			if alternativeDsts.length > 0
				heap = alternativeDsts[counter % alternativeDsts.length]  
				makeMove board,marked,heap,true
				found = true
			if not found
				for heap in holes	
					if legalMove board,marked,heap
						makeMove board,marked,heap,true
						break 

			if 4*N == countAceCards board 
				msg = "#{(millis() - start) // 1000} seconds"

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

# hint = ->
# 	if hintsLeft == 0 then return
# 	hintsLeft--
# 	undone = []
# 	while true 
# 		res = hintOne()
# 		if res? or hist.length==0
# 			for u in undone
# 				print "Undo: #{u}"
# 			print "Move: #{res}"
# 			return
# 		card = hist.pop()
# 		undone.push undoMove card

hint = ->
	hintsUsed++
	res = hintOne()
	if res? or hist.length==0 then return 
	undoMove hist.pop()

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
		hintsUsed = 0
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
	msg = ''

nextLevel = ->
	if 4*N == countAceCards board
		N++
	else
		N--
	N = constrain N,3,13
	classic = false
	newGame '   3456789TJQK'[N]

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
