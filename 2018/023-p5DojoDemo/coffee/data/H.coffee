ID_Hex =
	v:'2017-04-29'
	k:'bg fc sc range operators dist for [] quad circle if text class'
	l:47
	b:"""
class Hex extends Application
	reset : ->
		super
	draw : ->
	newGame : ->
	undo : ->
	mousePressed : (mx,my) ->
app = new Hex
"""

	a:"""
class Hex extends Application
	reset : ->
		super
		@A = 6
		@B = 5
		@C = 3
		@newGame()

	mousePressed : (mx,my) ->
		index = -1
		for i in range -5,6
			for j in range -5,6
				x = 100 + i*(2*@A+1) + @A*j
				y = 100 + j*(2*@B+@C-1)
				if dist(x,y,mx,my) < 7 then index = 11*(j+5)+i+5
		if index >= 0 and @board[index] == 0
			@history.push index
			n = @history.length
			if n % 2 == 0 then n = -n
			@board[index] = n

	newGame : ->
		@history = []
		@board = Array(11*11).fill 0

	undo : ->
		if @history.length > 0
			index = @history.pop()
			@board[index] = 0

	draw : ->
		bg 0.5
		textAlign CENTER,CENTER
		textSize 9
		for i in range -5,6
			for j in range -5,6
				index = 11*(j+5)+i+5
				x = 100+i*(2*@A+1) + @A*j
				y = 100+j*(2*@B+@C-1)
				bc = @B+@C
				sc() # 0,1,0
				fc 0,1,0
				quad x,y-bc, x,y+bc, x-@A,y+@C, x-@A,y-@C
				quad x,y-bc, x,y+bc, x+@A,y+@C, x+@A,y-@C
				n = @board[index]
				if n != 0
					if n>0 then fc(1) else fc(0)
					circle x,y,6
					sc()
					if n>0 then fc(0) else fc(1)
					text abs(n),x,y

app = new Hex "a"
"""
	c:
		app : "reset()|newGame()|undo()"
	d : "reset()|newGame()|mousePressed 100,100|mousePressed 100,80|mousePressed 80,80|mousePressed 30,50|mousePressed 140,50|undo()|undo()|undo()|undo()|undo()"
	e:
		Play : "http://www.lutanho.net/play/hex.html"
		Wikipedia : "https://en.wikipedia.org/wiki/Hex_(board_game)"

ID_HorizontalLine =
	v:'2017-04-29'
	k:'sc line'
	l:2
	b: ""
	a: """
sc 1,0,1
line 10,70, 190,70
"""

ID_HorizontalSquares =
	v:'2017-10-05'
	k:'range rect for lerp'
	l:3
	b:"""
# Börja med att rita de två första kvadraterna mha rect
# Därefter kan du börja med for-loopen
# De parametrar som är olika är lämpliga att lerpas

rect  5,5,10,10
rect 25,5,10,10
for i in range 5
	x = lerp 5,25,i
	rect
"""
	a:"""
for i in range 10
	x = 5+20*i
	rect x,5, 10,10
"""

