# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

#  4  4  4  4  4  0  8  8  8  8  8
#  5  5  5  5  5  1  9  9  9  9  9
#  6  6  6  6  6  2 10 10 10 10 10
#  7  7  7  7  7  3 11 11 11 11 11
#    12 13 14 15 16 17 18 19 20

SUIT = "kl hj sp ru".split ' '
RANK = "Ess 2 3 4 5 6 7 8 9 T Kn D K".split ' '
OFFSETX = 468
W = 263.25
H = 352
w = W/3
h = H/3
img = null
board=null
cards = null
hist = []
marked = null
cands = null
hash = null
aceCards = 4
done = null
originalBoard = null

preload = -> img = loadImage 'cards/Color_52_Faces_v.2.0.png'

range = _.range

makeBoard = (wild=false)->
	cards = []
	for rank in range 1,13
		for suit in range 4
			cards.push [suit,rank,rank]
	cards = _.shuffle cards

	board = []
	for i in range 21 
		board.push []

	for suit,heap in [2,1,3,0]
		board[heap].push [suit,0,0]
	for i in range 4,12
		for j in range 5 
			rr = if wild then int random 4,12 else i
			board[rr].push cards.pop()
	for heap in [12,13,14,15,17,18,19,20]
		board[heap].push cards.pop()

fakeBoard = ->
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,2,2],[1,3,3],[1,1,1],[3,1,1],[3,2,2]],[[0,4,4],[0,12,12],[3,5,5],[1,8,8],[3,9,9]],[[2,11,11],[3,12,12],[0,6,6],[2,5,5],[1,7,7]],[[0,8,8],[3,11,11],[2,6,6],[2,9,9],[1,12,12]],[[0,9,9],[0,10,10],[2,10,10],[2,4,4],[2,7,7]],[[1,2,2],[3,4,4],[3,6,6],[0,5,5],[1,11,11]],[[0,1,1],[0,7,7],[1,10,10],[1,5,5],[3,8,8]],[[0,3,3],[1,4,4],[3,3,3],[2,2,2],[3,10,10]],[[0,11,11]],[[3,7,7]],[[2,1,1]],[[2,8,8]],[],[[1,6,6]],[[2,3,3]],[[2,12,12]],[[1,9,9]]] # nix!
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,10,10],[2,11,11],[0,6,6],[3,9,9],[1,8,8]],[[3,10,10],[2,10,10],[0,12,12],[0,4,4],[3,1,1]],[[3,12,12],[1,3,3],[1,4,4],[1,9,9],[0,2,2]],[[3,4,4],[3,5,5],[2,5,5],[2,9,9],[2,3,3]],[[3,6,6],[1,7,7],[0,5,5],[2,7,7],[3,8,8]],[[2,4,4],[0,9,9],[1,2,2],[3,11,11],[1,6,6]],[[2,8,8],[2,1,1],[2,2,2],[1,10,10],[3,3,3]],[[1,1,1],[1,11,11],[1,12,12],[3,7,7],[2,12,12]],[[0,11,11]],[[3,2,2]],[[1,5,5]],[[0,8,8]],[],[[2,6,6]],[[0,3,3]],[[0,1,1]],[[0,7,7]]] # 851 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[2,3,3],[2,12,12],[2,11,11],[3,10,10],[1,7,7]],[[1,11,11],[0,5,5],[2,9,9],[3,12,12],[1,5,5]],[[0,12,12],[3,8,8],[1,9,9],[0,6,6],[1,6,6]],[[3,1,1],[2,7,7],[0,8,8],[0,7,7],[1,3,3]],[[1,8,8],[0,9,9],[2,10,10],[3,9,9],[1,4,4]],[[1,12,12],[3,2,2],[3,3,3],[3,4,4],[1,2,2]],[[3,6,6],[2,1,1],[0,2,2],[2,8,8],[0,3,3]],[[1,1,1],[3,7,7],[2,6,6],[3,11,11],[0,1,1]],[[2,5,5]],[[2,2,2]],[[1,10,10]],[[2,4,4]],[],[[3,5,5]],[[0,10,10]],[[0,11,11]],[[0,4,4]]] # 963 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[3,12,12],[3,9,9],[2,5,5],[3,2,2],[1,10,10]],[[0,1,1],[0,10,10],[2,4,4],[1,3,3],[3,7,7]],[[0,3,3],[0,11,11],[2,7,7],[3,8,8],[1,2,2]],[[0,5,5],[2,6,6],[0,6,6],[3,3,3],[1,5,5]],[[0,4,4],[3,5,5],[0,2,2],[3,10,10],[2,2,2]],[[2,10,10],[0,12,12],[2,1,1],[2,11,11],[0,9,9]],[[3,4,4],[1,7,7],[1,6,6],[2,12,12],[1,8,8]],[[1,1,1],[1,12,12],[1,11,11],[1,4,4],[2,3,3]],[[0,8,8]],[[3,11,11]],[[2,9,9]],[[0,7,7]],[],[[3,1,1]],[[2,8,8]],[[3,6,6]],[[1,9,9]]] # 264 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[1,1,1],[0,12,12],[3,3,3],[2,7,7],[3,11,11]],[[2,11,11],[2,8,8],[3,6,6],[0,1,1],[0,6,6]],[[1,8,8],[1,6,6],[0,3,3],[1,3,3],[0,7,7]],[[0,11,11],[1,10,10],[3,12,12],[1,11,11],[1,2,2]],[[0,4,4],[3,2,2],[2,2,2],[3,7,7],[0,5,5]],[[2,5,5],[2,9,9],[3,8,8],[3,9,9],[2,4,4]],[[2,10,10],[0,9,9],[1,12,12],[3,4,4],[3,10,10]],[[2,12,12],[3,5,5],[1,4,4],[2,1,1],[0,2,2]],[[1,5,5]],[[0,10,10]],[[0,8,8]],[[1,9,9]],[],[[3,1,1]],[[1,7,7]],[[2,6,6]],[[2,3,3]]] # 397 ms
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,2,2],[2,4,4],[2,10,10],[2,5,5],[1,1,1],[3,12,12],[2,12,12],[3,11,11],[1,8,8],[1,6,6]],[[3,9,9],[2,11,11],[0,12,12],[0,3,3],[3,10,10]],[[3,3,3],[0,9,9]],[[2,7,7],[1,4,4],[3,2,2],[1,9,9],[0,6,6],[1,5,5],[0,1,1]],[[1,3,3],[1,2,2],[2,2,2],[2,6,6],[1,11,11]],[[3,7,7],[2,8,8],[1,7,7],[3,1,1],[0,8,8]],[[2,3,3],[3,5,5],[3,6,6]],[[1,12,12],[3,4,4],[0,5,5]],[[0,7,7]],[[3,8,8]],[[1,10,10]],[[0,11,11]],[],[[0,4,4]],[[0,10,10]],[[2,1,1]],[[2,9,9]]]
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[2,7,7],[0,8,8],[0,2,2],[0,5,5]],[[2,9,9],[1,5,5],[0,3,3],[2,11,11],[1,10,10]],[[2,2,2],[1,8,8]],[[1,11,11],[2,6,6],[2,10,10],[2,5,5],[3,3,3],[1,1,1]],[[3,2,2],[3,12,12],[2,3,3],[1,7,7],[3,4,4],[3,11,11]],[[3,8,8],[0,10,10],[3,7,7],[0,12,12],[1,3,3],[0,9,9],[1,12,12]],[[0,7,7],[2,12,12],[0,6,6],[3,9,9]],[[1,2,2],[0,4,4],[1,6,6],[2,4,4],[1,4,4],[1,9,9]],[[3,6,6]],[[2,8,8]],[[2,1,1]],[[3,10,10]],[],[[0,11,11]],[[0,1,1]],[[3,1,1]],[[3,5,5]]] # 118 ms
	#board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[3,3,3],[2,3,3],[0,6,6],[3,5,5],[0,9,9],[2,10,10],[1,10,10]],[[0,10,10],[0,7,7],[3,8,8],[2,11,11]],[[0,12,12],[3,7,7],[2,1,1],[2,8,8],[1,7,7]],[[1,4,4],[2,5,5],[2,6,6],[1,2,2],[0,1,1],[2,2,2],[3,11,11],[2,7,7]],[[3,6,6],[3,9,9],[0,4,4],[3,4,4],[1,8,8]],[[0,3,3],[3,12,12],[1,11,11]],[[2,4,4],[0,2,2],[3,10,10],[0,8,8]],[[1,5,5],[2,9,9],[1,6,6],[1,1,1]],[[0,5,5]],[[0,11,11]],[[2,12,12]],[[1,3,3]],[],[[1,12,12]],[[1,9,9]],[[3,1,1]],[[3,2,2]]]

setup = ->
	createCanvas 800,600
	newGame 'C'

showHeap = (board,heap,x,y,dx) ->
	n = calcAntal board[heap]
	if n==0 then return 
	x0 = width/2 - w/2
	if x < 0 then x0 += -w+dx
	if x > 0 then x0 += w-dx
	x = x0 + x*dx/2
	y = y * h
	for card,k in board[heap]
		[suit,rank2,rank1] = card
		dr = if rank1 < rank2 then 1 else -1
		for rank in range rank1,rank2+dr,dr
			image img, x,y+13, w,h, OFFSETX+W*rank,1092+H*suit,243,H
			x += dx

	if marked? and marked == heap 
		fill 0,128,0,128
		if y==4*h 
			ellipse x-w/2,y+h/2,20 
		else
			if dx<0  then ellipse x+w,  y+h/2,20
			if dx>0  then ellipse x,    y+h/2,20
			if dx==0 then ellipse x+w/2,y+h/2,20

calcAntal = (lst) -> # Klarar ej Ess Kung Dam ... just nu
	res=0
	for [suit,rank1,rank2] in lst
		res += 1 + abs(rank1-rank2)
	res

display = (board) ->
	background 128

	textAlign CENTER,CENTER

	fill 255,255,0
	text 'R = Restart',width/2,height-80
	text 'C = Classic',width/2,height-60
	text 'W = Wild',width/2,height-40

	for heap,y in [0,1,2,3]
		showHeap board, heap, 0, y, 0

	for heap,y in [4,5,6,7]
		n = calcAntal board[heap]
		dx = if n<=7 then w/2 else (width/2-w/2-w)/(n-1)
		showHeap board, heap, -2, y, -dx

	for heap,y in [8,9,10,11]
		n = calcAntal board[heap]
		dx = if n<=7 then w/2 else (width/2-w/2-w)/(n-1)
		showHeap board, heap, 2, y, dx

	for heap,x in [12,13,14,15,16,17,18,19,20]
		xx = [-8,-6,-4,-2,0,2,4,6,8][x]
		showHeap board, heap, xx,4, w

legalMove = (board,a,b) ->
	if a in [0,1,2,3] then return false 
	if b in [12,13,14,15,17,18,19,20] then return false 
	b1 = board[12].length + board[13].length + board[14].length + board[15].length 
	b2 = board[17].length + board[18].length + board[19].length + board[20].length 
	if a==16 then return b1==0 or b2==0
	if b==16 then return board[16].length==0 and a in [4,5,6,7,8,9,10,11]
	#print a,b,board[a].length,_.last board[a],board[b].length,_.last board[b]
	if board[a].length==0 then return false
	if board[b].length==0 then return true
	[sa,a1,a2] = _.last board[a]
	[sb,b1,b2] = _.last board[b]
	if sa==sb and abs(a1-b1) in [1] then return true # 1,12
	false

makeMove = (board,a,b) -> # from a to b
	suit = _.last(board[a])[0]
	acard = board[a].pop()
	rank1 = acard[2]
	rank2 = acard[1]
	if board[b].length > 0 then	rank2 = board[b].pop()[2]
	board[b].push [suit,rank1,rank2]

mousePressed = ->
	mx = mouseX//(W/3)
	my = mouseY//(H/3)
	if my >= 4
		marked1 = 12 + mx
	else
		if mx==4 then marked1 = my
		else if mx<4 then marked1 = 4+my
		else marked1 = 8+my

	if marked?
		if marked1 != marked 
			if legalMove board,marked,marked1  
				makeMove board,marked,marked1
		marked = null
	else
		marked = marked1
	display board

####### AI-section ########

srcs = [4,5,6,7, 8,9,10,11, 12,13,14,15, 17,18,19,20]
dsts = [0,1,2,3, 4,5,6,7, 8,9,10,11]

findAllMoves = (b) ->
	res = []
	for src in srcs
		for dst in dsts
			if src!=dst
				if legalMove b,src,dst then res.push [src,dst]
	res

makeKey = (b) ->
	res = ''
	for heap,index in b
		for [suit,r1,r2] in heap
			if r1==r2
				res += 'shrk'[suit] + str(r1)
			else
				res += 'shrk'[suit] + str(r1) + str(r2)
		res += ' '
	res 

countAceCards = (b) ->
	res	= 0
	for heap in [0,1,2,3]
		res += calcAntal b[heap]
	res

expand = (b) ->
	res = []
	moves = findAllMoves b
	for [src,dst] in moves
		b1 = _.cloneDeep b
		makeMove b1,src,dst
		key = makeKey b1
		if key not of hash
			hash[key] = [src,dst,b]
			res.push b1
			if aceCards < countAceCards b1
				aceCards = countAceCards b1
				#print 'Done!',aceCards
				done = b1
	res

solve = ->
	done = null
	while done == null 
		if cands.length == 0 then return
		res = []
		for cand in cands 
			res = res.concat expand cand
		cands = res

newGame = (key) ->
	while true 
		makeBoard key=='W'
		originalBoard = _.cloneDeep board
		cands = [board]
		done = board 
		hash = {}
		aceCards = 4

		start = millis()
		while 52 > countAceCards done
			solve()
			cands = [done]
			if done==null then break
		if done?
			print JSON.stringify(board)
			printSolution hash,done
			print millis()-start
			display board
			return 

keyPressed = -> 
	if key == 'R'
		board = _.cloneDeep originalBoard
		display board

	if key in ['C','W']
		newGame key 

prettyCard = ([suit,rank1,rank2],antal=2) ->
	if antal==1
		"#{RANK[rank1]}"
	else if rank1==rank2
		"#{SUIT[suit]} #{RANK[rank1]}"
	else
		"#{SUIT[suit]} #{RANK[rank1]}..#{RANK[rank2]}"

prettyMove = (src,dst,b) ->
	c1 = _.last b[src]
	if b[dst].length>0
		c2 = _.last b[dst]
		"#{prettyCard c1} till #{prettyCard c2,1}"
	else
		"#{prettyCard c1} till hål"

printSolution = (hash, b) ->
	key = makeKey b
	solution = []
	while key of hash
		[src,dst,b] = hash[key]
		solution.push hash[key]
		key = makeKey b
	solution.reverse()
	s = ''
	for [src,dst,b] in solution
		s += "\n" + prettyMove src,dst,b
	print s