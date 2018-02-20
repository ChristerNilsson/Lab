ID_Nand2TetrisALU =
	v:'2017-04-29'
	k:'sc fc sw range text class point quad dist for if operators'
	l:63
	b: """
# Se länken Nand2Tetris, sidan 36, för mer information!

class ALU extends Application
	reset : ->
		super
	draw  : ->
	mousePressed : (mx,my) ->
app = new ALU
"""
	a:"""
class ALU extends Application
	reset : ->
		super
		@x = 3
		@y = 5
		@flags = 0
		@BUTTONS = [[5,1],[7,1],[9,1],[11,1],[13,1],[15,1],[3,3],[5,3],[15,3],[17,3]]

	draw1 : (value,x0,y0) ->
		sc()
		fc 1,1,0
		text value, x0,y0
		for i in range 16
			if (value & 1<<(15-i)) != 0 then fc 1 else fc 0.75
			if (value & 1<<(15-i)) != 0 then r=2.5 else r=1
			circle x0-40+3+5*i,y0+20,r

	draw : ->
		textAlign CENTER,CENTER
		fc 1,1,0
		quad 0,80, 200,80, 140,120, 60,120
		[z,zr,ng] = @calc()
		@draw1 @x,40,50
		@draw1 @y,160,50
		@draw1  z,100,130
		flags = "zx nx zy ny f no".split " "
		sc()
		textSize 16
		for i in range 6
			[x,y] = @BUTTONS[i]
			fc 1,0,0
			circle 10*x,10*y,10
			if @flags & 1<<i then fc 1 else fc 0.5
			text flags[i],10*x,10*y
		for ch,i in "-+-+"
			[x,y] = @BUTTONS[6+i]
			fc 1,0,0
			circle 10*x,10*y,10
			fc 1
			text ch, 10*x,10*y
		if zr==1 then fc 1 else fc 0.5
		text "zr",90,170
		if ng==1 then fc 1 else fc 0.5
		text "ng",110,170

	mousePressed : (mx,my) ->
		index = -1
		for button,i in @BUTTONS
			if dist(10*button[0],10*button[1],mx,my) < 10 then index = i
		if 0 <= index <= 5 then @flags ^= 1<<index
		if index == 6 then @x--
		if index == 7 then @x++
		if index == 8 then @y--
		if index == 9 then @y++

	calc : ->
		x=@x
		if @flags & 1 then x=0
		if @flags & 2 then x=~x
		y=@y
		if @flags & 4 then y=0
		if @flags & 8 then y=~y
		if @flags & 16 then out = x+y else out = x&y
		if @flags & 32 then out = ~out
		if out==0 then zr=1 else zr=0
		if out<0 then ng=1 else ng=0
		[out,zr,ng]

app = new ALU "a"
"""
	c:
		app : "reset()"
	d : "reset()|mousePressed 130,10|mousePressed 50,30|mousePressed 50,30|mousePressed 50,30"
	e:
		Nand2Tetris : "http://www.nand2tetris.org/chapters/chapter%2002.pdf"

ID_Nian =
	v:'2017-04-29'
	k:'bg fc sc [] "" reduce operators text for {} _.countBy if class'
	l:35
	b:"""
# Bilda ord med fyra till nio bokstäver. Använd variabeln ordlista.
# Den mittersta bokstaven måste ingå. Prova med "aaefkrrtu"

class Nian extends Application
	reset : ->
		super
	draw  : ->
	enter : ->

app = new Nian
"""
	a:"""
class Nian extends Application
	reset : ->
		super
		@found = ""
	draw : ->
		n = 15
		bg 0
		textAlign LEFT,TOP
		textSize 12
		fc 1,1,0
		sc()
		for word,i in @found.split " "
			x = int i / n
			y = i % n
			text word,5+200/4*x,200*y/n
	bits : (word) -> word.split("").reduce ((acc,ch) -> acc|(2 ** "abcdefghijklmnopqrstuvwxyzåäö".indexOf ch)), 0
	ok : (f1,f2) ->
		for ch, f of f2
			if f > f1[ch] then return false
		true
	enter : (letters='') ->
		words = ordlista.split " "
		patterns = (@bits word for word in words)
		if letters=='' then @letters = @readText() else @letters = letters
		mandatory = @letters[4]
		@found = []
		p = @bits @letters
		letters1 = @letters.split ""
		freq1 = _.countBy letters1
		for pattern,i in patterns
			if (p & pattern) == pattern
				letters2 = words[i].split ""
				freq2 = _.countBy letters2
				if @ok(freq1,freq2) and mandatory in letters2 then @found.push words[i]
		@found = @found.join " "

app = new Nian "a"
"""
	c:
		app : "reset()|enter()"
	d : "reset()|enter 'aaefkrrtu'"

	e:
		Nian : "http://svenska-apps.se/iphone-ipad/underhallning/svd-nian-babqpg.html"
		'_.countBy' : "http://underscorejs.org/#countBy"
		reduce : "https://coffeescript-cookbook.github.io/chapters/arrays/reducing-arrays"

ID_Nim =
	v:'2017-04-29'
	k:'bg fc sc circle operators if _.isEqual return constrain text class'
	l:62
	b:"""
class Nim extends Application
	reset : ->
		super
		@seed = 0
	draw  : ->
	newGame : ->
		[a,b,c] = [1+@randint(5),1+@randint(5),1+@randint(5)]
		@board = [a,a+b,a+b+c]
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	mousePressed : (mx,my) ->
app = new Nim
"""
	a:"""
class Nim extends Application
	reset : ->
		super
		@RADIUS = 30
		@BUTTONS = [[35,80],[100,80],[165,80], [35,150,'ok'],[100,150,'x'],[165,150,'hint']]
		@seed = 0
		@newGame()
		@init()

	init : ->
		@active = -1
		@player = 0
		@original = @board[..]

	move : (index) ->
		if @active in [index,-1]
			@active = index
			@board[@active] = constrain @board[@active]-1, 0, 99

	randint : (n) -> int n * fraction 10000 * Math.sin @seed++

	newGame : ->
		[a,b,c] = [1+@randint(5),1+@randint(5),1+@randint(5)]
		@board = [a,a+b,a+b+c]
		@init()

	ok : ->
		if @active == -1 then return
		@player = 1 - @player
		@active = -1
		@original = @board[..]

	cancel : ->
		@board = @original
		@active = -1

	draw : ->
		textAlign CENTER,CENTER
		textSize 32
		bg 0
		for [x,y,txt],i in @BUTTONS
			fc 0
			sc 1
			sw 2
			if i<=2 and @active==-1 or @active==i then circle x,y,@RADIUS
			if i in [3,4] and @active!=-1 then circle x,y,@RADIUS
			if i==5 and @active==-1 then circle x,y,@RADIUS
			fc 1
			sc()
			if i<=2 then text @board[i],x,y
			if i>=3 then text txt,x,y
		fc 1,@player,0
		circle 20 + @player * 160,20,10

	hint : ->
		if @active != -1 then return
		[a,b,c] = @board
		board = if (b^c) < a then [b^c,b,c] else if (a^c) < b then [a,a^c,c] else if (a^b) < c then [a,b,a^b] else [a,b,c]
		if not _.isEqual(board,@board)
			@board = board
			@player = 1 - @player

	mousePressed : (mx,my) ->
		index = -1
		for button,i in @BUTTONS
			if dist(button[0],button[1],mx,my) < @RADIUS then index = i
		if index <= 2 then @move index
		if index == 3 then @ok()
		if index == 4 then @cancel()
		if index == 5 then @hint()

app = new Nim "a"

"""
	c:
		app : "reset()|newGame()"
	d : "reset()|mousePressed 100,100|mousePressed 100,100|mousePressed 100,100|mousePressed 90,90|mousePressed 90,90"
	e:
		Nim : "https://en.wikipedia.org/wiki/Nim"
		xor : "https://en.wikipedia.org/wiki/Bitwise_operation#XOR"
		Nimrod : "https://en.wikipedia.org/wiki/Nimrod_(computing)"
