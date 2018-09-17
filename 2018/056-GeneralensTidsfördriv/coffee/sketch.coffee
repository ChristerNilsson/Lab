# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

#  4  5  6  7  8  9 10 11  0 
#  4  5  6  7  8  9 10 11  1
#  4  5  6  7  8  9 10 11  2 
#  4  5  6  7  8  9 10 11  3
#  4  5  6  7  8  9 10 11
# 12 13 14 15 16 17 18 19  PANEL

ACES  = [0,1,2,3]
HEAPS = [4,5,6,7,8,9,10,11]
PANEL = [12,13,14,15,16,17,18,19]

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
cands = null
hash = null
aceCards = 4
originalBoard = null

startCompetition = null
N = null # Max rank
srcs = null
dsts = null

alternativeDsts = []

infoLines = []
general = null

released = true 

print = console.log
range = _.range
Array.prototype.clear = -> @length = 0
assert = (a, b, msg='Assert failure') -> chai.assert.deepEqual a, b, msg

getParameters = (h = window.location.href) -> 
	h = decodeURI h
	arr = h.split '?'
	if arr.length != 2 then return {}
	s = arr[1]
	if s=='' then return {}
	_.fromPairs (f.split '=' for f in s.split('&'))

myRandom = (a,b) -> 
	x = 10000 * Math.sin general.fastSeed++
	r = x - Math.floor x
	a + Math.floor (b-a) * r

myShuffle = (array) ->
	n = array.length 
	for i in range n
		j = myRandom i, n
		value = array[i]
		array[i] = array[j]
		array[j] = value

copyToClipboard = (txt) ->
	copyText = document.getElementById "myClipboard"
	copyText.value = txt 
	copyText.select()
	document.execCommand "copy"

makeLink = -> 
	url = window.location.href + '?'
	index = url.indexOf '?'
	url = url.substring 0,index
	url + '?cards=' + general.slowSeed

class BlackBox # Avgör om man lyckats eller ej. Man får tillgodogöra sig tidigare drag.
	constructor : -> @clr()
	clr : ->
		@total = [0,0,0] # [time,computer,human]
		@count = 0
		#@success = false 
	show : -> # print 'BlackBox',@count,@total

class General
	constructor : ->
		@slowSeed = 1 # stored externally
		@fastSeed = 1 # used internally
		@start = null
		@maxMoves = null
		@hist = null
		@hintsUsed = 0
		@blackBox = new BlackBox()
		@clr()
		@getLocalStorage()

	success : -> @blackBox.total[2] + @hist.length <= @blackBox.total[1] + @maxMoves 

	probe : (time) ->
		if not @success() then return false 
		total = @blackBox.total
		total[0] += time
		total[1] += @maxMoves
		total[2] += @hist.length
		true

	getLocalStorage : ->
		print 'direct',localStorage.Generalen
		if localStorage.Generalen? then hash = JSON.parse localStorage.Generalen else hash = {}
		if 5 != _.size hash then hash = {level:0, slowSeed:1, fastSeed:1, total:[0,0,0], hintsUsed:0} 
		print 'hash',JSON.stringify hash
		# {level,slowSeed,fastSeed,total,hintsUsed} = hash
		@level = hash.level
		@slowSeed = hash.slowSeed
		@fastSeed = hash.fastSeed
		@blackBox.total = hash.total
		@hintsUsed = hash.hintsUsed
		print 'get', JSON.stringify hash

	putLocalStorage : ->
		s = JSON.stringify {level: @level, slowSeed:@slowSeed, fastSeed:@fastSeed, total:@blackBox.total, hintsUsed:@hintsUsed} 
		localStorage.Generalen = s 
		print 'put',s

	clr : ->
		@blackBox.clr()
		@level = 0
		@timeUsed = 0
		#@putLocalStorage()

	totalRestart : -> 
		@slowSeed = int random 65536		
		@clr()

	handle : (mx,my) ->
		marked = [(mx + if my >= 3 then 12 else 4),my]
		heap = oneClick marked,board,true

		if @timeUsed == 0 and 4*N == countAceCards board
			timeUsed = (millis() - @start) // 1000
			if @probe timeUsed
				@timeUsed = timeUsed
				@blackBox.show()
			@putLocalStorage()
			printManualSolution()

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

	#general.fastSeed++ # nödvändig?
	myShuffle cards

	board = []
	for i in range 20
		board.push []

	for suit,heap in range 4 
		board[heap].push pack suit,0,0 # Ess

	for heap in PANEL
		board[heap].push cards.pop()

	for card,i in cards
		heap = if classic then 4+i%8 else myRandom 4,12
		board[heap].push card

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
	print 'X'
	canvas = createCanvas innerWidth-0.5, innerHeight-0.5
	canvas.position 0,0 # hides text field used for clipboard copy.

	general = new General()

	w = width/9 
	h = height/4 
	angleMode DEGREES

	params = getParameters()
	if 'cards' of params
		general.slowSeed = parseInt params.cards
		general.level = 0

	startCompetition = millis()
	infoLines.push 'Level Moves Bonus Cards   Time Hints'.split ' '
	infoLines.push '0 0 0 0   0 0'.split ' '

	newGame general.level
	display board 

keyPressed = -> 
	if key == 'X' 
		N = 7
		board = "cA7|hA4|sA3|dA2||h6|s5 d6||h5 d5||s4 s6|d34||d7|s7|h7||||"
		general.hist = [[12,0,1],[5,1,1],[8,3,1],[9,1,1],[11,1,1],[16,2,1],[17,0,1],[10,0,1],[9,0,1],[18,2,1],[19,0,1],[7,0,1]]		
		board = readBoard board
		print board 
	display board

# returnerar övre, vänstra koordinaten för översta kortet i högen som [x,y]
getCenter = (heap) -> 
	if heap in ACES then return [int(8*w), int(heap*h)]
	if heap in PANEL then return [int((heap-12)*w), int(3*h)]
	if heap in HEAPS 
		n = calcAntal board[heap]
		dy = if n == 0 then 0 else min h/4,2*h/(n-1)
		return [int((heap-4)*w), int((n-1)*dy)]

menu0 = (src,dst,col) ->
	dialogue = new Dialogue 0,int(w/2),int(h/2),int(0.10*h),col
	r = int 0.05 * height
	[x,y] = getCenter src
	dialogue.add new Button 'From', x,y,r, -> dialogues.pop()
	[x,y] = getCenter dst 
	dialogue.add new Button 'To',   x,y,r, -> dialogues.pop()

menu1 = ->
	dialogue = new Dialogue 1,int(4*w),int(1.5*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.085 * height
	dialogue.clock ' ',6,r1,r2,90+360/12

	dialogue.buttons[0].info 'Undo', general.hist.length > 0, -> 
		if general.hist.length > 0 
			[src,dst,antal] = _.last general.hist
			dialogues.pop()
			undoMove general.hist.pop()
			menu0 src,dst,'#ff0'
		else
			dialogues.pop()

	dialogue.buttons[1].info 'Hint', true, -> 
		dialogues.pop()
		hint() # Lägger till menu0

	dialogue.buttons[2].info 'Cycle Move', alternativeDsts.length > 1, ->
		alternativeDsts.push alternativeDsts.shift()
		[src,dst,antal] = general.hist.pop()
		undoMove [src,dst,antal]
		heap = alternativeDsts[0] 
		makeMove board,src,heap,true
		# dialogues.pop() # do not pop!

	dialogue.buttons[3].info 'Next', general.success(), -> 
		general.level = (general.level+1) % 16
		newGame general.level
		general.timeUsed = 0
		general.putLocalStorage()
		dialogues.pop()

	dialogue.buttons[4].info 'Help', true, ->
		window.open "https://github.com/ChristerNilsson/Lab/tree/master/2018/056-GeneralensTidsf%C3%B6rdriv#generalens-tidsf%C3%B6rdriv"

	dialogue.buttons[5].info 'More...', true, -> 
		menu2()

menu2 = ->
	dialogue = new Dialogue 2,int(4*w),int(1.5*h),int(0.15*h) 

	r1 = 0.25 * height 
	r2 = 0.11 * height
	dialogue.clock ' ',3,r1,r2,90+360/6

	dialogue.buttons[0].info 'Restart', true, -> 
		restart()
		dialogues.clear()

	dialogue.buttons[1].info 'Total Restart', true, -> 
		general.totalRestart()
		newGame 0
		dialogues.clear()

	dialogue.buttons[2].info 'Link', true, ->
		link = makeLink()
		copyToClipboard link		
		#msg = 'Link copied to clipboard'
		dialogues.clear()

showHeap = (board,heap,x,y,dy) -> # dy kan vara både pos och neg
	n = calcAntal board[heap]
	x = x * w 
	if n > 0
		y = y * h + y * dy
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

	generalen()

	textAlign CENTER,TOP
	for heap,y in ACES
		showHeap board, heap, 8, y, 0
	for heap,x in HEAPS
		n = calcAntal board[heap]
		dy = if n == 0 then 0 else min h/4,2*h/(n-1)
		showHeap board, heap, x, 0, dy
	for heap,x in PANEL
		showHeap board, heap, x, 3, 0

	showInfo()

	noStroke()
	showDialogue()

text3 = (a,b,c,y) ->

showInfo = ->
	fill 64
	print 'textSize'
	textSize 0.1*(w+h)

	total = general.blackBox.total

	infoLines[1][0] = general.level
	infoLines[1][1] = general.maxMoves - general.hist.length
	infoLines[1][2] = total[1] - total[2] # bonus
	infoLines[1][3] = 4*N - countAceCards(board) # cards
	infoLines[1][6] = total[0] # time 
	infoLines[1][7] = general.hintsUsed # hints

	fill 255,255,0,128
	stroke 0,128,0

	textAlign CENTER,BOTTOM
	for i in range 8 
		x = w*(i+0.5)
		for j in range 2
			y = h*(2.8 + 0.2*j)
			text infoLines[j][i], x,y

generalen = ->
	textAlign CENTER,CENTER
	textSize 0.5*(w+h)
	stroke 0,64,0
	noFill()
	text 'Generalens',  4*w,0.5*h
	text 'Tidsfördriv', 4*w,1.5*h

showDialogue = -> if dialogues.length > 0 then (_.last dialogues).show()

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
	if record then general.hist.push [src, dst, 1 + abs under1-over1]
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

# returns destination
oneClick = (marked,board,sharp=false) ->

	holes = []
	found = false

	alternativeDsts = [] # för att kunna välja mellan flera via Cycle Moves
	for heap in ACES
		if legalMove board,marked[0],heap  
			if sharp then makeMove board,marked[0],heap,true
			found = true 
			return heap

	if not found # Går ej att flytta till något ess. 
		for heap in HEAPS
			if board[heap].length == 0
				if marked[0] in PANEL or calcAntal(board[marked[0]]) > 1
					holes.push heap
			else 
				if legalMove board,marked[0],heap
					alternativeDsts.push heap
		if holes.length > 0 then alternativeDsts.push holes[0]		

		if alternativeDsts.length > 0
			heap = alternativeDsts[0]
			if sharp then makeMove board,marked[0],heap,true
			return heap

	return marked[0] # no Move can happen

# assert1.jpg
# b1 = readBoard "cA|hA|sA|dA|h5|c3|s65|c2 d5||s3|d2 h6 d4|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6"
# assert 11, oneClick {lastMarked:0, counter:0},[4,0],b1 # hj5 to hj4
# assert 5,  oneClick {lastMarked:0, counter:0},[5,0],b1 # kl3 no move
# assert 8,  oneClick {lastMarked:0, counter:0},[6,1],b1 # sp5 to hole

# assert 10, oneClick {lastMarked:0, counter:0},[7,1],b1 # ru5 to ru4
# assert 8,  oneClick {lastMarked:[7,1], counter:0},[7,1],b1 # ru5 to hole

# assert 8, oneClick {lastMarked:0, counter:0},[8,-1],b1 # hole click
# assert 9, oneClick {lastMarked:0, counter:0},[9,0],b1 # sp3 no move

# assert 7, oneClick {lastMarked:0, counter:0},[10,2],b1 # ru4 to ru5
# assert 8, oneClick {lastMarked:[10,2], counter:0},[10,2],b1 # ru4 to hole
# assert 7, oneClick {lastMarked:[10,2], counter:1},[10,2],b1 # ru4 to ru5

# b1a = readBoard "cA|hA|sA|dA|h5|c3|s65|c2 d54||s3|d2 h6|d3 h4|h2|c5|c4|h3|c6|s4|s2|d6"
# assert 4, oneClick {lastMarked:[10,2], counter:0},[10,1],b1a # hj6 to hj5
# assert 8, oneClick {lastMarked:[10,1], counter:0},[10,1],b1a # hj6 to hole

# assert 4, oneClick {lastMarked:0, counter:0},[11,1],b1 # hj4 to hj5
# assert 8, oneClick {lastMarked:[11,1], counter:0},[11,1],b1 # hj4 to hole xxx

# assert 1, oneClick {lastMarked:0, counter:0},[12,0],b1 # hj2 to A
# assert 8, oneClick {lastMarked:0, counter:0},[13,0],b1 # kl5 to hole

# assert 5, oneClick {lastMarked:0, counter:0},[14,0],b1 # kl4 to kl3
# assert 8, oneClick {lastMarked:[14,0], counter:0},[14,0],b1 # kl4 to hole

# assert 11, oneClick {lastMarked:0, counter:0},[15,0],b1 # hj3 to hj4
# assert 8, oneClick {lastMarked:[15,0], counter:0},[15,0],b1 # hj3 to hole

# assert 8, oneClick {lastMarked:0, counter:0},[16,0],b1 # kl6 to hole

# assert 6, oneClick {lastMarked:0, counter:0},[17,0],b1 # sp4 to sp5
# assert 9, oneClick {lastMarked:[17,0], counter:0},[17,0],b1 # sp4 to sp3
# assert 8, oneClick {lastMarked:[17,0], counter:1},[17,0],b1 # sp4 to hole

# assert 2, oneClick {lastMarked:0, counter:0},[18,0],b1 # sp2 to A

# assert 7, oneClick {lastMarked:0, counter:0},[19,0],b1 # ru6 to ru5
# assert 8, oneClick {lastMarked:[19,0], counter:0},[19,0],b1 # ru6 to hole

# assert2.jpg
b2 = readBoard "cA|hA|sA|dA|d5 h2 d3 h3|c7|c34|d4 h76|||s3 d6 c6|d7 c5 d2|c2|s4|s6|h5|s5|s7|s2|h4"
#assert 8, oneClick {lastMarked:0, marked:9, counter:0},b2 #hj6 to hole

hitGreen = (mx,my,mouseX,mouseY) ->
	if my==3 then return false
	seqs = board[mx+4]
	n = calcAntal seqs
	if n==0 then return true
	mouseY > h*(1+1/4*(n-1))

mouseReleased = ->
	released = true
	false

mousePressed = -> 

	if not released then return false
	released = false 

	if not (0 < mouseX < width) then return false
	if not (0 < mouseY < height) then return false 

	mx = mouseX//w
	my = mouseY//h

	if dialogues.length == 1 and dialogues[0].number == 0 then dialogues.pop() # dölj indikatorer

	dialogue = _.last dialogues
	if dialogues.length == 0 or not dialogue.execute mouseX,mouseY 

		if mx == 8 or hitGreen mx,my,mouseX,mouseY 
			if dialogues.length == 0 then menu1() else dialogues.pop()
			display board
			return false

		dialogues.clear()
		general.handle mx,my

	display board
	false 

####### AI-section ########

findAllMoves = (b) ->
	srcs = HEAPS.concat PANEL 
	dsts = ACES.concat HEAPS 
	res = []
	for src in srcs
		holeUsed = false
		for dst in dsts
			if src != dst
				if legalMove b,src,dst
					if b[dst].length==0
						if holeUsed then continue
						holeUsed=true
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
	general.hintsUsed++

	#dialogues.pop()

	res = hintOne()
	if res or general.hist.length==0 then return 

	# Gick ej att gå framåt, gå bakåt
	[src,dst,antal] = _.last general.hist 	
	menu0 src,dst,'#f00'
	print 'red',dialogues.length

hintOne = -> 
	hintTime = millis()
	aceCards = countAceCards board
	if aceCards == N*4 then return true
	cands = []
	cands.push [aceCards,general.hist.length,board,[]] # antal kort på ässen, antal drag, board

	hash = {}
	key = dumpBoard board
	path = []
	hash[key] = [path, board]

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
	#print N,nr,cands.length,aceCards

	if aceCards == N*4
		board = cand[2]
		#printAutomaticSolution hash, board
		path = cand[3]
		board = origBoard
		[src,dst] = path[0]
		#makeMove board,src,dst,true
		#dialogues.pop()
		menu0 src,dst,'#0f0'
		#print "hint: #{int millis()-hintTime} ms"
		return true
	else
		print 'hint failed. Should never happen!'
		#print N,nr,cands.length,aceCards,_.size hash
		board = origBoard
		return false

newGame = (lvl) -> # 0..15
	#lvl = 14
	general.level = lvl
	general.start = millis()
	general.hist = []
	print '#####','Level',lvl
	while true 
		makeBoard general.level 
		general.hintsUsed = 0
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

		print 'trying',nr,cands.length
		if aceCards == N*4
			print JSON.stringify dumpBoard originalBoard 
			board = cand[2]
			print makeLink()
			#print 'currentSeed', currentSeed
			printAutomaticSolution hash,board
			board = _.cloneDeep originalBoard
			print "#{int millis()-general.start} ms"
			general.start = millis()
			general.maxMoves = int cand[1] 
			return 

restart = ->
	general.hist = []
	board = _.cloneDeep originalBoard

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
	for [src,dst,antal],index in general.hist
		s += "\n#{index}: #{prettyMove src,dst,b}"
		makeMove b,src,dst,false
	print s
