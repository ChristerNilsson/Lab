# Vectorized Playing Cards 2.0 - http://sourceforge.net/projects/vector-cards/
# Copyright 2015 - Chris Aguilar - conjurenation@gmail.com
# Licensed under LGPL 3 - www.gnu.org/copyleft/lesser.html

W = 263.25
H = 352
img = null
board=null
hist = []
preload = -> img = loadImage 'cards/Color_52_Faces_v.2.0.png'

marked = null

setup = ->
	createCanvas 800,600
	
	# createCanvas 4000,2600
	# image img, 0,0 #, w,h, 460+W*i,1080+H*j,W,H
	# return

	cards=[]
	for i in range 1,13
		for j in range 4
			cards.push [j,i]
	cards = _.shuffle cards
	board = []
	for i in range 21 
		board.push []
	for i in range 4
		board[i].push [i,0]
	for i in range 4,12
		for j in range 5 
			rr = int random 4,12
			board[rr].push cards.pop()
	for i in [12,13,14,15,17,18,19,20]
		board[i].push cards.pop()

	display()

showCard = (heap,k,x,y) ->
	n = board[heap].length
	if n==0 then return 

	w = W/3
	dx = w
	x0 = width/2 - w/2
	if n>7
		dx = (width/2-w/2-w)/(n-1)*2
		x0 += if x<0 then -w+dx	else w-dx
	h = H/3
	x = x0 + x*dx/2
	y = y * h

	[j,i] = board[heap][k]
	image img, x,y, w,h, 449+W*i,1080+H*j,W,H
	if marked?
		if k==board[heap].length-1
			if marked == heap 
				fc 0,1,0,0.5
				circle x+w/2,y+h/2,20

display = ->
	bg 0.5
	for heap in [0,1,2,3]
		n = board[heap].length
		showCard heap,n-1, 0, heap

	for heap,y in [4,5,6,7]
		for z,x in board[heap] 
			showCard heap,x, -2-x, y

	for heap,y in [8,9,10,11]
		for z,x in board[heap] 
			showCard heap,x, 2+x, y

	for heap,x in [12,13,14,15,16,17,18,19,20]
		xx = [-8,-6,-4,-2,0,2,4,6,8][x]
		showCard heap,0, xx,4

legalMove = (a,b) ->
	if b in [12,13,14,15,17,18,19,20] then return false 
	if a in [0,1,2,3] then return false 
	b1 = board[12].length + board[13].length + board[14].length + board[15].length 
	b2 = board[17].length + board[18].length + board[19].length + board[20].length 
	if a==16 then return b1==0 or b2==0
	if b==16 then return board[16].length==0 and a in [4,5,6,7,8,9,10,11]
	if board[b].length==0 then return true
	if a in [0,1,2,3] then return false
	if b in [12,13,14,15,17,18,19,20] then return false
	c1 = _.last board[a]
	c2 = _.last board[b]
	if c1[0]==c2[0] and abs(c1[1]-c2[1]) in [1,12] then return true
	false

makeMove = (a,b) ->
	board[b].push board[a].pop()
	hist.push [a,b]

keyPressed = ->
	if key==' '
		[a,b] = hist.pop()
		board[a].push board[b].pop()
		display()

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
			if legalMove marked,marked1  
				makeMove marked,marked1
		marked = null
	else
		marked = marked1
	display()

# draw = ->
# 	#display()
# 	bg 0.5
# 	image img, 0,0 #, w,h, 460+W*i,1080+H*j,W,H

# mousePressed = ->
# 	print mouseX
