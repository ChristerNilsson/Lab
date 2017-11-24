# 3x3, en sida, 1680 positioner. Max sex drag.
# Två klick krävs för att välja drag.
#   Första klick väljer tile.
#   Andra klick var det ska vara.
# Tolv drag möjliga

released = true 

class RubikSquare9
	reset : ->
		@BUTTONS = [[14,14,3,3],[20,14,3,3],[26,14,3,3], [14,20,3,3],[20,20,3,3],[26,20,3,3], [14,26,3,3],[20,26,3,3],[26,26,3,3], [14,30,3,1],[20,30,3,1],[26,30,3,1]]
		@level = 1
		@history = []
		@memory = -1
		@createGame()

	randint : (n) -> int n * random()

	newGame : ->
		if @level >= @history.length and _.isEqual @board,[0,1,2,0,1,2,0,1,2] then d=1 else d=-1
		@level = constrain @level+d,1,6
		@history = []
		@createGame()

	createGame : ->
		bigstring = rubikSquareData[@level]
		arr = bigstring.split ' '
		s = arr[@randint(arr.length)]
		@board = (parseInt(ch) for ch in s)

	move : (m,d,board) ->
		[i,j,k] = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8]][m]
		bd = board[..]
		[a,b,c] = [bd[i],bd[j],bd[k]]
		if d==0 then [a,b,c] = [b,c,a] else [a,b,c] = [c,a,b]
		[bd[i],bd[j],bd[k]] = [a,b,c]
		bd

	draw : ->
		bg 0
		textAlign CENTER,CENTER
		textSize 20
		rectMode CENTER,CENTER
		for c,i in @board
			sc 1
			if c==0 then fc 1,0,0
			if c==1 then fc 0,1,0
			if c==2 then fc 0,0,1
			[x,y,w,h] = @BUTTONS[i]
			rect 10*x, 10*y,20*w,20*h
		if @memory >= 0
			[x,y,w,h] = @BUTTONS[@memory]
			fc 0
			sc()
			circle 10*x,10*y,10
		[x,y,w,h] = @BUTTONS[10]
		fc 1,1,0
		sc()
		text @level-@history.length,10*x,10*y
		if @history.length > 0
			[x,y,w,h] = @BUTTONS[9]
			text "undo",10*x,10*y
			[x,y,w,h] = @BUTTONS[11]
			text "new",10*x,10*y

	undo : ->
		if @history.length == 0 then return
		@board = @history.pop()
		@memory = -1

	mousePressed : (mx,my) ->
		index = -1
		for [x,y,w,h],i in @BUTTONS
			if x-w <= mx/10 <= x+w and y-h <= my/10 <= y+h then index = i
		if 0 <= index < 9
			if @memory == -1
				@memory = index
			else if @memory == index
				@memory = -1
			else
				hash =
					"01":[0,1], "02":[0,0], "10":[0,0], "12":[0,1], "20":[0,1], "21":[0,0]
					"34":[1,1], "35":[1,0], "43":[1,0], "45":[1,1], "53":[1,1], "54":[1,0]
					"67":[2,1], "68":[2,0], "76":[2,0], "78":[2,1], "86":[2,1], "87":[2,0]
					"03":[3,1], "06":[3,0], "30":[3,0], "36":[3,1], "60":[3,1], "63":[3,0]
					"14":[4,1], "17":[4,0], "41":[4,0], "47":[4,1], "71":[4,1], "74":[4,0]
					"25":[5,1], "28":[5,0], "52":[5,0], "58":[5,1], "82":[5,1], "85":[5,0]
				pair = hash["" + @memory + index]
				if pair
					[m,d] = pair
					@history.push @board[..]
					@board = @move m,d,@board
					@memory = -1
		if index==9 then @undo()
		if index==11 then @newGame()

app = new RubikSquare9

setup = ->
	createCanvas 400,400
	app.reset()

draw = -> app.draw()

mouseReleased = ->
	released = true
	false

mousePressed = ->
	if not released then return
	released = false 
	app.mousePressed mouseX,mouseY