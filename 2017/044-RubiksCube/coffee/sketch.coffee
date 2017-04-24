board = []
buttons = [
	[3,4],[2,4],[1,4],[0,3],[0,2],[0,1]
	[1,0],[2,0],[3,0],[4,1],[4,2],[4,3]
]

az = [
	[0,1,42,41,40,   2,3,9,16,15,    4,5,20,19,18,   6,7,31,30,29]
	[9,10,40,39,38,  11,12,49,48,47, 13,14,22,21,20, 15,16,4,3,2]
	[18,19,6,5,4,    20,21,15,14,13, 22,23,47,46,45, 24,25,33,32,31]
	[27,28,36,43,42, 29,30,0,7,6,    31,32,18,25,24, 33,34,45,52,51]
	[36,37,51,50,49, 38,39,11,10,9,  40,41,2,1,0,    42,43,29,28,27]
	[45,46,24,23,22, 47,48,13,12,11, 49,50,38,37,36, 51,52,27,34,33]
]

op = (n,d) ->
	arr = az[n]
	carr = (board[i] for i in arr)
	limit = if d==1 then 5 else 15
	carr = carr[limit..20].concat carr[0..limit]
	board[arr[i]] = carr[i] for i in range 20

setup = ->
	createCanvas 200,200
	textAlign CENTER,CENTER
	rectMode CENTER
	for i in range 54
		board.push i

colorize = (index) ->
	k = int board[index] / 9
	if k==0 then fc 1 # vit
	if k==1 then fc 0,0,1 # blå
	if k==2 then fc 1,0,0 # röd
	if k==3 then fc 0,1,0 # grön
	if k==4 then fc 0.5 # grå
	if k==5 then fc 1,1,0 # gul

textcolorize = (index) ->
	k = int board[index] / 9
	if k==0 then fc 0 # vit
	if k==1 then fc 1 # blå
	if k==2 then fc 1 # röd
	if k==3 then fc 0 # grön
	if k==4 then fc 0 # grå
	if k==5 then fc 0 # gul

rita = (x,y,index,tilt) ->
	a = 16
	b = 9
	colorize index
	if tilt == 0 then quad x-a,y, x,y-b, x+a,y, x,y+b
	if tilt == 1 then quad x+a/2,y-b/2, x-a/2,y-3*b/2, x-a/2,y+b/2, x+a/2,y+3*b/2
	if tilt == 2 then quad x-a/2,y-b/2, x+a/2,y-3*b/2, x+a/2,y+b/2, x-a/2,y+3*b/2

	textcolorize index
	text board[index],x,y

draw = ->
	bg 0.5
	a = 16
	b = 9
	y0 = 60

	for index in range 54
		side = int index / 9

		if side==0 # vit
			i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
			j = [0,1,2,2,2,1,0,0,1][index % 9]
			x = 100+a*(i+j-1)
			y = y0+b*(i-j+1)
			rita x,y, index, 0

		if side==1 # blå
			i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
			j = [0,1,2,2,2,1,0,0,1][index % 9]
			x = 100+a*(i+4.5)
			y = y0+b*(2*j+i-3.5)
			rita x,y, index, 1

		if side==2 # röd
			i = [-1,0,1,1,1,0,-1,-1,0][index % 9]
			j = [0,0,0,1,2,2,2,1,1][index % 9]
			x = 100+a*(i+1.5)
			y = y0+b*(2*j-i+2.5)
			rita x,y, index, 2

		if side==3 # grön
			i = [-1,-1,-1,0,1,1,1,0,0][index % 9]
			j = [2,1,0,0,0,1,2,2,1][index % 9]
			x = 100+a*(i-1.5)
			y = y0+b*(2*j+i+2.5)
			rita x,y, index, 1

		if side==4 # orange
			i = [-1, 0, 1, 1, 1, 0,-1,-1, 0][index % 9]
			j = [ 2, 2, 2, 1, 0, 0, 0, 1, 1][index % 9]
			x = 100+a*(i-4.5)
			y = y0+b*(2*j-i-3.5)
			rita x,y, index, 2

		if side==5 # gul
			i = [ 1, 1, 1, 0,-1,-1,-1, 0, 0][index % 9]
			j = [ 0, 1, 2, 2, 2, 1, 0, 0, 1][index % 9]
			x = 100+a*(i+j-1)
			y = y0+b*(i-j+13)
			rita x,y, index, 0

mousePressed = ->
	# i = int mouseX/40
	# j = int mouseY/40
	# for d in range 2
	# 	for [x,y],index in buttons[d]
	# 		if x==i and y==j then op index,d
	op 5,1
	#op 0,1
	#op 1,0
	#op 1,1
