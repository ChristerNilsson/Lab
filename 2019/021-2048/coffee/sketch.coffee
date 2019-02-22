SIZES = [0,128,96,80,64]
COLORS = '0 F00 0F0 FF0 0FF F0F FFF 08F 0F8 800 808 80F 00F 080'.split ' '

ts = null
board = null

move = (lst)->
	lst = (item for item in lst when item>0)
	for i in range lst.length-1 
		if lst[i] == lst[i+1] then [lst[i], lst[i+1]] = [lst[i]+1, 0]	
	lst = (item for item in lst when item>0)
	lst.unshift 0 for i in range 4 - lst.length		
	lst
# assert [0,0,0,2], move [1,0,0,1]
# assert [0,0,2,1], move [0,2,0,1]
# assert [1,2,3,4], move [1,2,3,4]
# assert [0,1,3,1], move [1,2,2,1]
# assert [0,0,2,2], move [1,1,1,1]
# assert [0,0,2,2], move [0,2,1,1]
# assert [0,0,0,2], move [1,1,0,0]
# assert [0,0,0,2], move [0,1,1,0]

class Board
	constructor : ->
		@grid = (0 for i in range 16)
		@addTile 2

	mv : (indices) ->
		lst = move (@grid[index] for index in indices)
		@grid[index] = lst[i] for index,i in indices

	addTile : (n=1) ->
		cands = (index for tile,index in @grid when tile==0)
		@grid[index] = 1 for index in _.sample cands,n
						
	move : (m) -> 
		original = @grid.slice()
		if m not in [0,1,2,3] then return 
		@mv t for t in ts[m]
		if not _.isEqual @grid,original then @addTile() 

	draw : ->
		for cell,i in @grid
			x = 100 + 200*(i%%4)
			y = 100 + 200*(i//4)
			fill "##{COLORS[cell]}8"
			rect x,y,180,180,4
			value = 2**cell
			textSize SIZES[value.toString().length]
			fill 0
			if cell > 0 then text value,x,y+3

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
