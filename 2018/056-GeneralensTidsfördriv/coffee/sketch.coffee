# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

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
holes = 0
done = null

preload = -> img = loadImage 'cards/Color_52_Faces_v.2.0.png'

range = _.range

makeBoard = ->
	board = []
	for i in range 21 
		board.push []

	for suit,heap in [2,1,3,0]
		board[heap].push [suit,0,0]
	for i in range 4,12
		for j in range 5 
			rr = int random 4,12
			board[i].push cards.pop()
	for heap in [12,13,14,15,17,18,19,20]
		board[heap].push cards.pop()

	print JSON.stringify(board)

fakeBoard = ->
	board = [[[2,0,0]],[[1,0,0]],[[3,0,0]],[[0,0,0]],[[0,2,2],[1,3,3],[1,1,1],[3,1,1],[3,2,2]],[[0,4,4],[0,12,12],[3,5,5],[1,8,8],[3,9,9]],[[2,11,11],[3,12,12],[0,6,6],[2,5,5],[1,7,7]],[[0,8,8],[3,11,11],[2,6,6],[2,9,9],[1,12,12]],[[0,9,9],[0,10,10],[2,10,10],[2,4,4],[2,7,7]],[[1,2,2],[3,4,4],[3,6,6],[0,5,5],[1,11,11]],[[0,1,1],[0,7,7],[1,10,10],[1,5,5],[3,8,8]],[[0,3,3],[1,4,4],[3,3,3],[2,2,2],[3,10,10]],[[0,11,11]],[[3,7,7]],[[2,1,1]],[[2,8,8]],[],[[1,6,6]],[[2,3,3]],[[2,12,12]],[[1,9,9]]]
	# board = []
	# for i in range 21 
	# 	board.push []

	# for heap in range 4
	# 	board[heap].push [heap,0,0]
	# board[4].push [0,5,5]
	# board[5].push [1,5,3]
	# board[5].push [2,5,3]
	# board[7].push [3,5,3]
	# board[8].push [0,6,6]
	# board[9].push [1,6,9]
	# board[10].push [2,6,9]
	# board[11].push [3,6,9]
	# for heap in [12,13,14,15,17,18,19,20]
	# 	board[heap].push cards.pop()

setup = ->
	createCanvas 800,600

	cards = []
	for rank in range 1,13
		for suit in range 4
			cards.push [suit,rank,rank]
	cards = _.shuffle cards

	fakeBoard()
	display board 
	cands = [board]
	done = board 
	hash = {}

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

calcAntal = (lst) ->
	res=0
	for [suit,rank1,rank2] in lst
		res += 1 + abs(rank1-rank2)
	res

display = (board) ->
	background 128

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
	if sa==sb and abs(a1-b1) in [1,12] then return true
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

srcs = [4,5,6,7, 8,9,10,11, 12,13,14,15, 17,17,19,20]
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

countHoles = (b) ->
	res	= 0
	for heap in range 4,12
		if b[heap].length == 0 then res++
	res

expand = (b) ->
	res = []
	moves = findAllMoves b
	for [src,dst] in moves
		b1 = _.cloneDeep b
		makeMove b1,src,dst
		key = makeKey b1
		if key not of hash
			hash[key] = true
			res.push b1
			if holes + 1 == countHoles b1
				holes++
				display b1
				print 'Done!',holes
				done = b1
	res

solve = ->
	res = []
	done = null
	for cand in cands 
		res = res.concat expand cand
		if done? then return 
	cands = res

keyPressed = -> 
	if key == 'R' # reset 
		display done 
		cands = [done]
		hash = {}

	if key == ' ' 
		solve()
		print cands.length, _.size hash
