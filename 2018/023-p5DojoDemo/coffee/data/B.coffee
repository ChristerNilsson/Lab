ID_Background1 =
	v:'2018-01-25'
	k:'bg'
	l:1
	b: """
# Första bilden ska du efterlikna.
# Andra bilden skapas av din kod.
# Tredje bilden visar skillnaden mellan de två andra. Ska bli svart när du är klar.

# Tryck på PgDn för att komma till sista raden.
# Skriv in följande kommando: bg 1
# Kontrollera att de två första bilderna nu är lika, och att den tredje är helt svart.

# Öppna nästa övning genom att klicka på den svarta knappen Background2.
# Stäng dock först denna övning genom att klicka på den vita knappen Background1.

"""
	a: "bg 1"

ID_Background2 =
	v:'2018-01-25'
	k:'bg'
	l:1
	b: """
# Listan med gul text på svart bakgrund innehåller kommandon som du behöver.
# Klicka på dem för att läsa om dem.
# Listan med svart text på grön bakgrund innehåller länkar med bakgrundsinformation.
	"""
	a: "bg 0.5"

ID_Background3 =
	v:'2017-04-29'
	k:'bg'
	l:1
	b: ""
	a: "bg 1,0,0"

ID_Background4 =
	v:'2017-04-29'
	k:'bg'
	l:1
	b: ""
	a: "bg 1,1,0"

ID_BeeHaiku3D =
	v:'2017-05-29'
	k:'bg sc fc range for if quad line operators class []'
	l:81
	b:"""
# . rita/rita ej
# 123456789 förflyttning
# i pos i-axel
# I neg i-axel
# j pos j-axel
# J neg J-axel
# k pos k-axel
# K neg k-axel
# Exempel: .9j9I9J9

class BeeHaiku3D extends Application
	reset : (n,dx,dy)->
		super
	draw : ->
	enter : ->
	mousePressed : ->
app = new BeeHaiku3D
"""
	a:"""
class BeeHaiku3D extends Application
	reset : (n,dx,dy)->
		super
		@SHADE = [0.5,0.75,1]
		@N = n
		@DX = dx
		@DY = dy
		@showGrid = true
		@clear()
	clear : -> @blocks = Array(@N*@N*@N).fill 0
	add : (i,j,k) -> @blocks[@N*@N*k+@N*j+i] = 1
	draw : ->
		bg 0.5
		if @showGrid then @grid()
		sc()
		@drawBlock index for index in range @N*@N*@N
	drawBlock : (index) ->
		f = (i,j,k) => [100+(@N-i)*2*@DY-2*(@N-j)*@DY, 200-(@N-j)*@DY-(@N-i)*@DY - k*2*@DY]
		q = (a,b,c,d) -> quad a[0],a[1], b[0],b[1], c[0],c[1], d[0],d[1]
		ix=index
		i = ix % @N; ix //= @N
		j = ix % @N; ix //= @N
		k = ix
		block = @blocks[index]
		if not block? or block==0 then return
		[r,g,b] = [i/(@N-1),j/(@N-1),k/(@N-1)] # borde vara i,j,k
		p0 = f i,  j,  k # egentligen osynlig
		p1 = f i+1,j,  k
		p2 = f i,  j+1,k
		p3 = f i+1,j+1,k
		p4 = f i  ,j,  k+1
		p5 = f i+1,j,  k+1
		p6 = f i  ,j+1,k+1
		p7 = f i+1,j+1,k+1
		[si,sj,sk] = @SHADE
		fc r*sj,g*sj,b*sj
		q p2,p6,p7,p3 # left
		fc r*si,g*si,b*si
		q p1,p3,p7,p5 # right
		fc r*sk,g*sk,b*sk
		q p4,p5,p7,p6 # roof
	grid : ->
		sc 0.75
		[h2,h3,h4] = [200-2*@N*@DY, 200-@N*@DY, 200]
		[w2,w3,w4] = [100-@N*@DX,   100,        100+@N*@DX]
		for i in range @N+1
			line w3+@DX*i, h4-@DY*i, w2+@DX*i, h3-@DY*i
			line w2+@DX*i, h3+@DY*i, w3+@DX*i, h2+@DY*i
	mousePressed : ->
		@showGrid = not @showGrid
		@enter()
	enter : (q='') ->
		@trace = ''
		move = (di,dj,dk,steps) =>
			for n in range steps
				if pen then @add i,j,k
				i += di
				j += dj
				k += dk
			@trace += steps + ' [' + i + ' ' + j + ' ' + k + '] '
		i = 0
		j = 0
		k = 0
		dir = 'i'
		pen = false
		s = q
		if q=='' then s = @readText().trim()
		for c in s
			if c in 'iIjJkK'
				dir=c
				@trace += c
			else if c=='.' then	pen = not pen
			else if c==' '
			else
				steps = parseInt c
				if dir=='i' then move 1,0,0,steps
				else if dir=='I' then move -1,0,0,steps
				else if dir=='j' then move 0,1,0,steps
				else if dir=='J' then move 0,-1,0,steps
				else if dir=='k' then move 0,0,1,steps
				else if dir=='K' then move 0,0,-1,steps
app = new BeeHaiku3D "a"

"""
	c:
		app : "reset 2,50,25|reset 10,10,5|reset 17,6,3|enter()"
	d : "reset 10,10,5|enter '.9j9I9J9'"
	e:
		ForthHaiku : "http://forthsalon.appspot.com/haiku-editor"
		Exempel : 'ForthHaiku3D.html'
		"Beck & Jung" : 'https://www.google.se/search?q=beck+jung&tbm=isch&imgil=fTDB34quIvQVtM%253A%253BujSokE1Q4La-QM%253Bhttp%25253A%25252F%25252Fonline.auktionsverket.se%25252F1111%25252F109534-beck-jung-computer-ink-plot&source=iu&pf=m&fir=fTDB34quIvQVtM%253A%252CujSokE1Q4La-QM%252C_&usg=__eBA4v2Ol5RdVComTBJqPkozH59s%3D&biw=1920&bih=1108&dpr=1&ved=0ahUKEwiH0qmqzInUAhVmDZoKHTcYD7wQyjcIQw&ei=hQsmWcf7EOaa6AS3sLzgCw#imgrc=fTDB34quIvQVtM:'

ID_BlackBox2D =
	v:'2017-04-29'
	k:'bg sc fc range line [] operators int for if text class'
	l:33
	b:"""
class BlackBox2D extends Application
	reset : ->
		super
		@N = 10
		@SIZE = 20
		@index = 0
	up   : -> @index = (@index+1) %% 36
	down : -> @index = (@index-1) %% 36
	draw : ->
app = new BlackBox2D
"""
	a:"""
class BlackBox2D extends Application
	reset : () ->
		super
		@N = 10
		@SIZE = 20
		@index = 0
	up   : -> @index = (@index+1) %% 36
	down : -> @index = (@index-1) %% 36
	paint : (r,g,b,x,y,txt) ->
		fc r,g,b
		if txt? then text txt,x,y else circle x,y,5
	draw : ->
		sc()
		textSize 14
		textAlign CENTER,CENTER
		for i in range @N
			for j in range @N
				x = @SIZE/2 + @SIZE*i
				y = @SIZE/2 + @SIZE*j + 1
				res = @calc i,j
				if res == true       then @paint 0,1,0,x,y
				else if res == false then @paint 1,0,0,x,y
				else if res == 'NaN' then @paint 1,1,0,x,y,'?'
				else if res >= 100   then @paint 0,1,0,x,y,'..'
				else if res <= -100  then @paint 1,0,0,x,y,'..'
				else if res < 0      then @paint 1,0,0,x,y,-res
				else if res > 0      then @paint 0,1,0,x,y,res
				else                      @paint 1,1,0,x,y,res
	fix : (i,j) -> if j == 0 then ['NaN','NaN'] else [i//j, i%j]
	calc : (i,j) ->
		n = @N
		[a,b] = @fix i,j
		[i, i+j, i-j, i-5, j-6, j*n+i, i*n+j, (n-1-i)*n+n-1-j, (n-1-j)*n+n-1-i, (i-4)*(j-4), i*j, i*i+j*j, i**j, a, b, i%2, (i+j)%2, j&i, i|j, i^j, ~i, i<<j, j>>i, j&(2**i), i==j, i-j==1, i+j==9, i!=j, i>5, i<j, i<=j, i==3 and j==6, i==3 or j==6, (2<i<7) and (1<j<7), 4 <= dist(4.5,4.5,i,j) < 5, (i+j)%2==1][@index]

app = new BlackBox2D "a"
"""
	c:
		app : "reset()|up()|down()"
	d : "reset()|up()|down()"
	e:
		Operatorer : "https://www.w3schools.com/jsref/jsref_operators.asp"
		BlackBox : "https://en.wikipedia.org/wiki/Black_box"

ID_Blank =
	v:'2017-05-12'
	k:''
	b: """
# Här kan du laborera med egna idéer!
"""
	a: "a=null"

ID_BoardGame =
	v:'2017-04-29'
	k:'bg fc sc circle range for ->'
	l:21
	b:"""
class Board extends Application
	reset : ->
		super
	draw  : ->
	r     : (d) ->
	d     : (d) ->
	n     : (d) ->
app = new Board
"""
	a:"""

class Board extends Application
	reset : ->
		super
		@_X = 100
		@_Y = 100
		@_d = 18
		@_r = 7
		@_n = 5
	draw : ->
		bg 1
		fc 0
		sc()
		@one @_d,@_r,@_X-@_n*@_d, @_Y-@_d,2*@_n+1,3
		@one @_d,@_r,@_X-@_d, @_Y-@_n*@_d,3,2*@_n+1
	one : (d,r,x0,y0,m,n) ->
		for i in range m
			for j in range n
				circle x0+d*i,y0+d*j,r
	r : (d) -> @_r += d
	d : (d) -> @_d += d
	n : (d) -> @_n += d

app = new Board "a"
"""
	c:
		app : "reset()|r -1|r +1|d -1|d +1|n -1|n +1"

ID_BouncingBalls =
	v:'2017-04-29'
	k:'fc sw sc circle operators [] if for class'
	l:43
	b : """
class Ball
	constructor : ->
	update      : (grav) ->
	render      : (sel) ->

class BouncingBalls extends Application
	classes : -> [Ball]
	reset   : ->
		super
	draw    : ->
	update  : ->
	add     : ->
	delete  : ->
	selNext : ->
	selPrev : ->
	grow    : ->
	shrink  : ->
	nextCol : ->
	prevCol : ->
	gravity : ->
app = new BouncingBalls
"""

	a:"""
class Ball
	constructor : ->
		@x = 100
		@y = 100
		@r = 10
		@c = 1
		@dx = 3
		@dy = 4
	update : (grav) ->
		@x += @dx
		@y += @dy
		if not (@r < @x < 200-@r) then @dx = - @dx
		if not (@r < @y < 200-@r) then @dy = - @dy
		if grav and @y < 200-@r then @dy += 1
	render : (sel) ->
		fill cc @c
		sw 2
		if sel then stroke cct @c else sc()
		circle @x,@y,@r

class BouncingBalls extends Application
	classes : -> [Ball]
	reset : ->
		super
		@balls = []
		@sel = -1
		@grav = false
	draw : ->
		for ball,i in @balls
			ball.render i==@sel, @grav
	update : ->
		for ball in @balls
			ball.update(@grav)

	add : ->
		@balls.push new Ball
		@sel = @balls.length - 1

	delete :->
		@balls.splice @sel, 1
		if @sel >= @balls.length then @sel = @balls.length - 1
	selNext : -> @sel = (@sel + 1) %% @balls.length
	selPrev : -> @sel = (@sel - 1) %% @balls.length
	grow : ->    @balls[@sel].r++
	shrink : ->  @balls[@sel].r--
	nextCol : -> @balls[@sel].c = (@balls[@sel].c+1) %% 32
	prevCol : -> @balls[@sel].c = (@balls[@sel].c-1) %% 32
	gravity : -> @grav = not @grav

app = new BouncingBalls "a"
"""
	c:
		app : "reset()|update()|add()|delete()|selNext()|selPrev()|grow()|shrink()|nextCol()|prevCol()|gravity()"
	d : "reset()|gravity()|add()|update()|add()|update()|selNext()|update()|selPrev()|update()|grow()|update()|nextCol()|update()|prevCol()|shrink()|delete()"

ID_Braid =
	v:'2017-04-29'
	k:'sc bg sw range for line class'
	l:19
	b : """
class Cartesius
	constructor : (@r,@g,@b, @x,@y) ->
	go : (dx,dy) ->

braid = (n,dx,dy,width) ->

braid 5,18,18,6
"""

	a:"""
class Cartesius
	constructor : (@r,@g,@b, @x,@y) ->
	go : (dx,dy) ->
		sc @r,@g,@b
		line @x,@y,@x+dx,@y+dy
		[@x,@y] = [@x+dx,@y+dy]

braid = (n,dx,dy,width) ->

	a = new Cartesius 1,0,0, 100-dx/2,dy/3
	b = new Cartesius 1,1,0, 100+dx/2,2*dy/3
	c = new Cartesius 0,1,0, 100-dx/2,dy

	bg 0
	sw width

	for i in range n
		a.go dx,dy
		b.go -dx,dy
		c.go dx,dy

		a.go -dx,dy
		b.go dx,dy
		c.go -dx,dy

braid 5,18,18,6
"""
	e:
		braid : "https://cdn.tutsplus.com/vector/uploads/legacy/tuts/000-2011/398-hair-braid/6.jpg"
		Wikipedia : "https://en.wikipedia.org/wiki/Braid"

ID_Braider =
	v:'2017-04-29'
	k:'sc bg sw range for if operators line class'
	l:49
	b: """
class Cartesius
	constructor : (x,y,c) ->
	go          : (dx,dy) ->
	down        : (d) ->
	left        : (d) ->

class Braider extends Application
	braid   : (type) ->
	draw    : ->
	forward : ->
	back    : ->
app = new Braider
"""

	a:"""
class Cartesius
	constructor : (@x,@y,@c) ->
	go : (dx,dy) ->
		stroke cc @c
		line @x,@y,@x+dx,@y+dy
		[@x,@y] = [@x+dx,@y+dy]
	down : (d) -> @go 0,d
	left : (d) -> @go -d,0

class Braider extends Application

	braid : (@type) ->
		@n = 0
		@forward()
	draw : ->
		if @type==1
			sw 5
			a = new Cartesius 200,20, 1 # röd
			for i in range @n
				a.go -20,20
		if @type==2
			sw 5
			a = new Cartesius 200,20, 1 # röd
			b = new Cartesius 190,10, 2 # grön
			for i in range @n
				if i%4 == 0 then b.down 20
				if i%4 == 1 then a.left 20
				if i%4 == 2 then a.down 20
				if i%4 == 3 then b.left 20
		if @type==3
			sw 5
			a = new Cartesius 200,30, 1
			b = new Cartesius 190,10, 2
			c = new Cartesius 180,20, 3
			for i in range @n
				if i%6 == 0 then b.down 30
				if i%6 == 1 then a.left 30
				if i%6 == 2 then c.down 30
				if i%6 == 3 then b.left 30
				if i%6 == 4 then a.down 30
				if i%6 == 5 then c.left 30
		if @type==4
			sw 10
			a = new Cartesius 150,40, 1 # röd
			b = new Cartesius 170,20, 2 # grön
			c = new Cartesius 160,30, 3 # gul
			d = new Cartesius 190,50, 4 # blå
			for i in range @n
				if i%12 == 0 then b.down 50
				if i%12 == 1 then c.left 30; c.down 30
				if i%12 == 2 then d.left 50
				if i%12 == 3 then a.down 50
				if i%12 == 4 then b.left 50
				if i%12 == 5 then c.down 50
				if i%12 == 6 then d.left 30; d.down 30
				if i%12 == 7 then a.left 50
				if i%12 == 8 then b.left 30; b.down 30
				if i%12 == 9 then d.down 50
				if i%12 == 10 then c.left 50
				if i%12 == 11 then a.left 30; a.down 30

	forward : -> @n++
	back : -> @n--

app = new Braider "a"
"""
	c:
		app : "braid 1|braid 2|braid 3|braid 4|forward()|back()"
	d : "braid 3|forward()|forward()|forward()|forward()|forward()|forward()|forward()|forward()|forward()|forward()"

	e:
		braid : "https://cdn.tutsplus.com/vector/uploads/legacy/tuts/000-2011/398-hair-braid/6.jpg"

