SIZES = [0,64,64,64,64,64,64,36,36,36,36,36]
COLORS = '0 FF0 F65 5C6 29C 96A FC0 F65 FCF 000 2FC A6B'.split ' '

ts = null
board = null

move = (lst)->
	i = lst.length-1
	while i>=0
		if lst[i]==0 then lst.splice i,1 else i--
	i = lst.length-1		
	while i>0
		if lst[i] == lst[i-1] 
			value = lst[i] + 1
			lst.splice i,1 
			lst[i-1] = value	
			i--
		i--
	lst.unshift 0 for i in range 4 - lst.length		
	lst
assert [0,0,0,2], move [1,0,0,1]
assert [0,0,2,1], move [0,2,0,1]
assert [1,2,3,4], move [1,2,3,4]
assert [0,1,3,1], move [1,2,2,1]
assert [0,0,2,2], move [1,1,1,1]
assert [0,0,2,2], move [0,2,1,1]
assert [0,0,0,2], move [1,1,0,0]
assert [0,0,0,2], move [0,1,1,0]

class Board
	constructor : ->
		@grid = (0 for i in range 16)
		@grid[index]=1 for index in _.sample range(16),2			

	mv : (indices) ->
		lst = (@grid[index] for index in indices)
		lst = move lst
		@grid[index]=lst[i] for index,i in indices

	addTile : () ->
		cands = (index for tile,index in @grid when tile==0)
		if cands.length == 0 then return false	
		index = _.sample cands
		@grid[index] = 1
		true
			
	move : (m) -> 
		original = @grid.slice()
		if m not in [0,1,2,3] then return 
		@mv t for t in ts[m]
		if not _.isEqual @grid,original then @addTile() 

	draw : ->
		for cell,i in @grid
			x = 100 + 200*(i%%4)
			y = 100 + 200*(i//4)
			fill "##{COLORS[cell]}" 
			rect x,y,180,180,4
			textSize SIZES[cell]
			fill 0
			if cell != 0 then text 2**cell,x,y+3

make = (lst,d) ->	item+d*i for item,k in lst for i in range 4

setup = ->
	createCanvas 801,801
	textAlign CENTER,CENTER
	rectMode CENTER
	board = new Board()
	ts = []
	ts.push make [12,8,4,0], 1
	ts.push make [0,1,2,3], 4 
	ts.push make [0,4,8,12], 1 
	ts.push make [3,2,1,0], 4 

draw = ->
	bg 0.5
	board.draw()

keyPressed = -> board.move [UP_ARROW, RIGHT_ARROW, DOWN_ARROW, LEFT_ARROW].indexOf keyCode
