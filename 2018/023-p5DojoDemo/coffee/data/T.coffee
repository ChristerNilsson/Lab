ID_2048 =
	v:'2017-10-19'
	k:'fc sc range [] for rect if operators class text'
	l:103
	b:"""
class Button 
	constructor : (@number,@i,@j) ->
	draw : ->

class C2048 extends Application
	reset : ->
		super
		@seed=0
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	classes : -> [Button]
	draw  : ->
	right : ->
	left : ->
	up : ->
	down : ->
app = new C2048
"""
	a:"""

class Button 
	constructor : (@number,@i,@j) ->
		@x = @i * 50
		@y = @j * 50
	draw : ->
		fc 1
		sc 0
		rect @x,@y, 50,50
		fc 0
		textSize [0,40,40,30,20,15][str(@number).length]
		if @number != 0 then text @number, 25+@x, 25+@y

class C2048 extends Application
	reset : ->
		super
		@N = 4
		@state = ''
		@buttons = []
		@seed = 0

		for i in range @N
			for j in range @N
				button = new Button 0,i,j
				@buttons.push button 

		@new_piece()
		@new_piece()

	randint : (n) -> int n * fraction 10000 * Math.sin @seed++

	new_piece : ->
		moves = range @N*@N
		cands = (i for i in moves when @buttons[i].number==0)
		i = cands[@randint cands.length]
		@buttons[i].number = [2,4][@randint 2]

	shift : (numbers, index,delta) ->
		lst = (numbers[index+i*delta] for i in range @N) 
		lst = (item for item in lst when item != 0)
		for i in range lst.length
			if lst[i]==lst[i+1] and lst[i] != 0
				lst[i] *= 2
				lst[i+1] = 0

		while lst.length < @N
			lst.push 0

		for i in range @N
			numbers[index+i*delta] = lst[i]

		numbers

	move : (start,a,b) ->
		numbers = (button.number for button in @buttons) 
		last = numbers.slice()
		for i in range @N
			numbers = @shift numbers, start+i*a,b
		for button,i in @buttons
			button.number = numbers[i]
		if not _.isEqual numbers,last then @new_piece()
		numbers

	up    : -> @move 0,4,1
	down  : -> @move 3,4,-1
	left  : -> @move 0,1,4
	right : -> @move 12,1,-4
	check_lose : (b) ->
		numbers = (button.number for button in @buttons when button.number==0)
		if numbers.length==0 then @state = 'LOSE'

	classes : -> [Button]

	draw : ->
		textAlign CENTER,CENTER
		for button in @buttons
			button.draw()
		@check_lose()
		if @state != ''
			fc 1,0,0,0.5
			textSize 64
			text @state,100,100

app = new C2048 'a'
"""

	c:
		app: "reset()|right()|left()|up()|down()"
	e:
		"2048" : "https://en.wikipedia.org/wiki/2048_(video_game)"

ID_Tetramino =
	v:'2017-06-07'
	k:'bg fill cc range [] for rect if operators class'
	l:32
	b:"""
class Piece
	constructor : (@color,@patterns) ->
class Tetramino extends Application
	reset : ->
		super
	classes : -> [Piece]
	draw  : ->
	right : ->
	left : ->
	prev : ->
	next : ->
app = new Tetramino
"""
	a:"""
class Piece
	constructor : (@color,@patterns) -> @current = 0
	right : -> @current = (@current+1) %% @patterns.length
	left  : -> @current = (@current-1) %% @patterns.length
	draw  : ->
		pattern = @patterns[@current]
		fill cc @color
		for i in range 16
			if pattern >> i & 1
				x = i % 4
				y = i // 4
				rect 20*x,20*y,20,20
f = (a,b,c,d) -> 2**a + 2**b + 2**c + 2**d
class Tetramino extends Application
	reset : ->
		super
		@pieces = []
		@pieces.push new Piece 0,[f(1,5,9,13),f(4,5,6,7)]
		@pieces.push new Piece 1,[f(5,6,9,10)]
		@pieces.push new Piece 2,[f(1,5,6,9),f(4,5,6,9),f(1,4,5,9),f(1,4,5,6)]
		@pieces.push new Piece 3,[f(2,5,6,9),f(4,5,9,10)]
		@pieces.push new Piece 4,[f(1,5,6,10),f(5,6,8,9)]
		@pieces.push new Piece 5,[f(1,5,9,10),f(4,5,6,8),f(0,1,5,9),f(4,5,6,2)]
		@pieces.push new Piece 6,[f(1,5,9,8),f(0,4,5,6),f(1,2,5,9),f(4,5,6,10)]
		@current = 0
	classes : -> [Piece]
	draw  : -> @pieces[@current].draw()
	right : -> @pieces[@current].right()
	left : -> @pieces[@current].left()
	prev : -> @current = (@current-1) %% @pieces.length
	next : -> @current = (@current+1) %% @pieces.length
app = new Tetramino 'a'
"""
	c:
		app: "reset()|right()|left()|prev()|next()"
	e:
		"Wikipedia" : "https://en.wikipedia.org/wiki/Tetris"
		"Meth Meth Method" : "https://www.youtube.com/watch?v=H2aW5V46khA"

ID_Tetris =
	v:'2017-05-07'
	k:'bg fc range [] {} for rect if while _.contains operators class'
	l:109
	b:"""
class Tetris extends Application
	reset : ->
		super
	draw  : ->
	mousePressed : (mx,my) ->
app = new Tetris
"""
	a:"""
class Tetris extends Application
	reset : ->
		super
		@buttons = [[140,105,'-90'],[180,105,'+90'],[160,130,'dn'],[140,155,'lt'],[180,155,'rt'],[160,180,''],[160,50,0]]
		@seed = 0
		@arena = (new Array(12).fill(0) for i in range 20)
		@x=0
		@y=0
		@matrix = null
		@score = 0
		@playerReset()
	draw : ->
		bg 0
		fc 0.5
		rect 0,0,120,200
		sc 0
		@drawMatrix @arena, 0,0
		@drawMatrix @matrix, @x,@y
		@arenaSweep()
		textSize 20
		textAlign CENTER,CENTER
		@buttons[6][2] = @score
		for [x,y,txt],index in @buttons
			fc 0.5
			if index < 5 then circle x,y,15
			fc 1,1,0
			text txt,x,y
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	mousePressed : (mx,my) ->
		for [x,y,txt],index in @buttons
			if dist(mx,my,x,y) < 15
				if index==0 then @playerRotate -1 # -90
				if index==1 then @playerRotate 1  # +90
				if index==2 then @playerDown()    # DOWN
				if index==3 then @playerMove -1   # LEFT
				if index==4 then @playerMove 1    # RIGHT
				#if index==5 then @playerDrop()    # SPACE
	arenaSweep : ->
		for i in range @arena.length
			y = 19-i
			rad = @arena[y]
			if not _.contains rad, 0
				row = @arena.splice(y, 1)[0].fill 0
				@arena.unshift row
				@score++
	playerRotate : (dir) ->
		xpos = @x
		offset = 1
		@rotera @matrix, dir
		while @collide()
			@x += offset
			offset = -(offset + (offset > 0 ? 1 : -1))
			if offset > @matrix[0].length
				@rotera @matrix, -dir
				@x = xpos
				return
	playerReset : ->
		pieces = 'TJLOSZI'
		@matrix = @createPiece pieces[@randint pieces.length]
		@y = 0
		@x = (@arena[0].length / 2 | 0) - (@matrix[0].length / 2 | 0)
		if @collide()
			row.fill(0) for row in @arena
			@score = 0
	playerDown : ->
		@y++
		if @collide()
			@y--
			@merge()
			@playerReset()
			@arenaSweep()
	playerDrop : -> # hänger sig här!
		while not @collide()
			@playerDown()
	playerMove : (offset) ->
		@x += offset
		if @collide() then @x -= offset
	merge : ->
		for row,y in @matrix
			for value,x in row
				if value != 0 then @arena[y + @y][x + @x] = value
	rotera : (matrix, dir) ->
		for y in range matrix.length
			for x in range y
				[matrix[x][y], matrix[y][x]] = [matrix[y][x],matrix[x][y]]
		if dir > 0
			row.reverse() for row in matrix
		else
			matrix.reverse()
	collide : ->
		m = @matrix
		for y in range m.length
			for x in range m[y].length
				if (m[y][x] != 0 and (@arena[y + @y] and @arena[y + @y][x + @x]) != 0) then return true
		false
	createPiece : (type) ->
		if type == 'I' then [[0, 1, 0, 0],	[0, 1, 0, 0],	[0, 1, 0, 0],	[0, 1, 0, 0],]
		else if type == 'L' then [[0, 2, 0],[0, 2, 0],[0, 2, 2],]
		else if type == 'J' then [[0, 3, 0],[0, 3, 0],[3, 3, 0],]
		else if type == 'O' then [[4, 4],[4, 4],]
		else if type == 'Z' then [[5, 5, 0],[0, 5, 5],[0, 0, 0]]
		else if type == 'S' then [[0, 6, 6],[6, 6, 0],[0, 0, 0]]
		else if type == 'T' then [[0, 7, 0],[7, 7, 7],[0, 0, 0]]
	drawMatrix : (matrix, xoff,yoff) ->
		for row,y in matrix
			for value,x in row
				if value != 0
					fill cc value
					rect 10*(x + xoff), 10*(y + yoff), 10,10

app = new Tetris "a"
"""
	c:
		app: "reset()"
	e:
		"Wikipedia" : "https://en.wikipedia.org/wiki/Tetris"
		"Meth Meth Method" : "https://www.youtube.com/watch?v=H2aW5V46khA"

ID_TextA =
	v:'2017-04-29'
	k:'fc sc text textSize'
	l:4
	b:""
	a:"""
fc 1,1,0
sc()
textSize 32
text 'Coffeescript',0,100
"""

ID_TextB =
	v:'2017-04-29'
	k:'fc sc text textSize textAlign'
	l:5
	b:""
	a:"""
fc 1,1,0
sc()
textSize 32
textAlign CENTER,CENTER
text 'Coffeescript',100,100
"""

ID_TextC =
	v:'2017-09-30'
	k:'sc fc angleMode rotate text translate textSize textAlign'
	l:10
	b:""
	a:"""
sc()
fc 1,1,0
textSize 64
textAlign CENTER,CENTER
translate 100,100
angleMode DEGREES
rotate 90
text 'Coffee',0,0
fc 1,0,0
rotate 90
text 'script',0,0
"""

ID_TowerOfHanoi =
	v:'2017-05-13'
	k:'bg fc sc range operators [] text for if return constrain class line'
	l:40
	b:"""
class TowerOfHanoi extends Application
	reset : ->
		super
	draw : ->
	mousePressed : (mx,my) ->
app = new TowerOfHanoi
"""
	a:"""
class TowerOfHanoi extends Application
	reset : ->
		super
		@level = 0
		@H = 10
		@buttons = [33,100,167]
		@disk = null
		@newGame()
	draw : ->
		bg 0.75
		textSize 32
		textAlign CENTER,CENTER
		sc()
		text @counter,100,180
		for pile,i in @board
			x = @buttons[i]
			sc 0.5
			sw 3
			line x,55,x,140
			sc 0
			line 0,140,200,140
			sw @H
			for disk,j in pile
				y = 134 - j*@H
				stroke cc disk
				line x-3*(disk+1),y, x+3*(disk+1),y
	newGame : ->
		@counter=0
		@level = constrain @level+1,1,8
		@board = [range(@level).reverse(), [], []]
	mousePressed : (mx,my) ->
		if @disk==null and @board[0].length==0 and @board[1].length==0
			@newGame()
		else
			for x,index in @buttons
				if x-33 <= mx <= x+33
					if @disk == null
						@disk = @board[index].pop()
					else
						pile = @board[index]
						if pile.length == 0 or _.last(pile) > @disk
							@counter++
							pile.push @disk
							@disk = null

app = new TowerOfHanoi "a"

"""
	c:
		app : "reset()"
	e:
		Wikipedia : "https://en.wikipedia.org/wiki/Tower_of_Hanoi"

ID_Triangle =
	v:'2017-04-29'
	k:'fc triangle'
	l:2
	b:""
	a:"""
fc 1
triangle 20,40, 160,100, 100,140
"""

ID_TwoArcs =
	v:'2017-09-30'
	k:'fc sc sw arc angleMode strokeCap'
	l:8
	b:"""
# Innan du går vidare med p5Dojo bör du gå
# igenom lektionerna A0, A1 och A2 i p5Assert
"""
	a:"""
fc()
sc 1,0,0
sw 20
angleMode DEGREES
arc 100,70, 100,100, -90,0
sc 1,1,0
strokeCap SQUARE
arc 100,120, 100,100, 0, -90
"""

ID_TwoDiceHistogram =
	v:'2017-04-29'
	k:'bg fc sc range int random text if for operators rect []'
	l:22
	b:"""
# OBS: På grund av random blir bitmapparna inte likadana
"""
	a:"""
counts = Array(11).fill 0
dice = -> int 6 * random()
textAlign CENTER,CENTER
for i in range 1000
	counts[dice() + dice()]++
h = int 200/11
bg 0
for count,i in counts
	y = h*i
	fc 1,1,0,0.5
	sc 1,1,0
	rect 0,y,count,h-3
	fc 1,1,0
	sc()
	textAlign LEFT,CENTER
	text i+2, 5,y+h/2
	if count < 100
		textAlign LEFT,CENTER
		text count, count+5,y+h/2
	else
		textAlign RIGHT,CENTER
		text count, count-5,y+h/2
"""
	e:
		Animering : "https://www.openprocessing.org/sketch/124236"

ID_TwoDiscsA =
	v:'2017-04-29'
	k:'circle fc'
	l:4
	b:""
	a:"""
fc 1,0,0
circle 80,100,40
fc 0,1,0
circle 100,120,50
"""

ID_TwoDiscsB =
	v:'2017-04-29'
	k:'circle fc'
	l:4
	b:""
	a:"""
fc 1,0,0
circle 80,100,40
fc 0,1,0, 0.5
circle 120,100,50
"""

