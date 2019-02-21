move = (lst)->
	res = lst
	i = res.length-1
	while i>=0
		if res[i]==0 then res.splice i,1 else i--
	i = res.length-1
	while i > 0
		if res[i] == res[i-1] 
			value = res[i] + 1
			res.splice i,1 
			res[i-1] = value
		i--
	res.unshift 0 for i in range 4 - res.length		
	res
assert [0,0,0,2], move [1,0,0,1]
assert [0,0,2,1], move [0,2,0,1]
assert [1,2,3,4], move [1,2,3,4]
assert [0,1,3,1], move [1,2,2,1]
assert [0,0,2,2], move [1,1,1,1]

class Board
	constructor : ->
		@grid = (0 for i in range 16)
		@grid[index]=1 for index in _.sample range(16),2			

	mv : (indices) ->
		lst = (@grid[index] for index in indices)
		lst = move lst
		@grid[index]=lst[i] for index,i in indices

	addTile : (lst) ->
		cands = (index for index in lst when @grid[index]==0)
		if cands.length == 0 then return false	
		index = _.sample cands
		@grid[index]=1
		true

	make : (lst,d) ->	item+d*i for item,k in lst for i in range 4
			
	move : (m) -> 
		if m not in [0,1,2,3] then return 
		ts = []
		ts.push @make [12,8,4,0], 1
		ts.push @make [0,1,2,3], 4 
		ts.push @make [0,4,8,12], 1 
		ts.push @make [3,2,1,0], 4 
		lst = ts[m]
		@mv t for t in lst
		@addTile (t[0] for t in lst)

	draw : ->
		textSize 64
		textAlign CENTER,CENTER
		rectMode CENTER
		for cell,i in @grid
			x = 100 + 200*(i%%4)
			y = 100 + 200*(i//4)
			fc 1,1,cell*0.1
			rect x,y,180,180,4
			fc if cell<5 then 0 else 0
			if cell != 0 then text 2**cell,x,y+3

board = null

setup = ->
	createCanvas 801,801
	board = new Board()

draw = ->
	bg 0.5
	board.draw()

keyPressed = -> board.move [UP_ARROW, RIGHT_ARROW, DOWN_ARROW, LEFT_ARROW].indexOf keyCode
