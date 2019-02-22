N = 4
SIZES = [0,128,128,80,64,48,42]
COLORS = '0 #F00 #0F0 #FF0 #0FF #F0F #FFF #08F #0F8 #800 #808 #80F #FFF #08F #0F8 #800 #808 #80F'.split ' '
[WIN,LOSE] =  [1,2]

ts = board = null
score = state = 0

move = (lst)->
	lst = (item for item in lst when item > 0)
	for i in range lst.length
		if i < lst.length-1 and lst[i] == lst[i+1] 
			[lst[i], lst[i+1]] = [lst[i]+1, 0]	
			score += 2**lst[i]
	lst = (item for item in lst when item > 0)
	lst.unshift 0 for i in range N - lst.length		
	lst

class Board
	constructor : ->
		@grid = (0 for i in range N * N)
		@addTile() for i in range 2

	mv : (indices) ->
		lst = move (@grid[index] for index in indices)
		@grid[index] = lst[i] for index,i in indices

	addTile : ->
		index = _.sample (index for tile,index in @grid when tile == 0)
		@grid[index] = if random() < 0.9 then 1 else 2
		
	updateState : ->
		tmp = new Board()
		tmp.grid = @grid.slice()
		for m in range N
			tmp.mv t for t in ts[m]
		if _.isEqual tmp.grid,@grid then state = LOSE
					
	move : (m) -> 
		if m not in [0,1,2,3] or state > 0 then return 
		original = @grid.slice()
		@mv t for t in ts[m]
		if not _.isEqual @grid,original then @addTile() 
		@updateState()

	draw : ->
		for cell,i in @grid
			x = 100 + i %% N * 200
			y = 100 + i // N * 200
			fill COLORS[cell]
			rect x,y,180,180,4
			value = 2 ** cell
			textSize SIZES[value.toString().length]
			fill 0
			if cell > 0 then text value,x,y+3
			textSize 64
			text score,200,850
			text ['','You Win','Game Over'][state],600,850

make = (lst,d) ->	item + d*i for item,k in lst for i in range N

setup = ->
	test()
	createCanvas 801,801+100
	textAlign CENTER,CENTER
	rectMode CENTER
	board = new Board()
	ts = []
	ts.push make [12,8,4,0], 1
	ts.push make [0,1,2,3], N
	ts.push make [0,4,8,12], 1 
	ts.push make [3,2,1,0], N 
	score = 0

draw = ->
	bg 0.5
	board.draw()

keyPressed = -> board.move [UP_ARROW, RIGHT_ARROW, DOWN_ARROW, LEFT_ARROW].indexOf keyCode
