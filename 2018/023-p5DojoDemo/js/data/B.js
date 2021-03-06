'use strict';

// Generated by CoffeeScript 2.0.3
var ID_Background1, ID_Background2, ID_Background3, ID_Background4, ID_BeeHaiku3D, ID_BlackBox2D, ID_Blank, ID_BoardGame, ID_BouncingBalls, ID_Braid, ID_Braider;

ID_Background1 = {
  v: '2018-01-25',
  k: 'bg',
  l: 1,
  b: "# Första bilden ska du efterlikna.\n# Andra bilden skapas av din kod.\n# Tredje bilden visar skillnaden mellan de två andra. Ska bli svart när du är klar.\n\n# Tryck på PgDn för att komma till sista raden.\n# Skriv in följande kommando: bg 1\n# Kontrollera att de två första bilderna nu är lika, och att den tredje är helt svart.\n\n# Öppna nästa övning genom att klicka på den svarta knappen Background2.\n# Stäng dock först denna övning genom att klicka på den vita knappen Background1.\n",
  a: "bg 1"
};

ID_Background2 = {
  v: '2018-01-25',
  k: 'bg',
  l: 1,
  b: "# Listan med gul text på svart bakgrund innehåller kommandon som du behöver.\n# Klicka på dem för att läsa om dem.\n# Listan med svart text på grön bakgrund innehåller länkar med bakgrundsinformation.",
  a: "bg 0.5"
};

ID_Background3 = {
  v: '2017-04-29',
  k: 'bg',
  l: 1,
  b: "",
  a: "bg 1,0,0"
};

ID_Background4 = {
  v: '2017-04-29',
  k: 'bg',
  l: 1,
  b: "",
  a: "bg 1,1,0"
};

ID_BeeHaiku3D = {
  v: '2017-05-29',
  k: 'bg sc fc range for if quad line operators class []',
  l: 81,
  b: "# . rita/rita ej\n# 123456789 förflyttning\n# i pos i-axel\n# I neg i-axel\n# j pos j-axel\n# J neg J-axel\n# k pos k-axel\n# K neg k-axel\n# Exempel: .9j9I9J9\n\nclass BeeHaiku3D extends Application\n	reset : (n,dx,dy)->\n		super\n	draw : ->\n	enter : ->\n	mousePressed : ->\napp = new BeeHaiku3D",
  a: "class BeeHaiku3D extends Application\n	reset : (n,dx,dy)->\n		super\n		@SHADE = [0.5,0.75,1]\n		@N = n\n		@DX = dx\n		@DY = dy\n		@showGrid = true\n		@clear()\n	clear : -> @blocks = Array(@N*@N*@N).fill 0\n	add : (i,j,k) -> @blocks[@N*@N*k+@N*j+i] = 1\n	draw : ->\n		bg 0.5\n		if @showGrid then @grid()\n		sc()\n		@drawBlock index for index in range @N*@N*@N\n	drawBlock : (index) ->\n		f = (i,j,k) => [100+(@N-i)*2*@DY-2*(@N-j)*@DY, 200-(@N-j)*@DY-(@N-i)*@DY - k*2*@DY]\n		q = (a,b,c,d) -> quad a[0],a[1], b[0],b[1], c[0],c[1], d[0],d[1]\n		ix=index\n		i = ix % @N; ix //= @N\n		j = ix % @N; ix //= @N\n		k = ix\n		block = @blocks[index]\n		if not block? or block==0 then return\n		[r,g,b] = [i/(@N-1),j/(@N-1),k/(@N-1)] # borde vara i,j,k\n		p0 = f i,  j,  k # egentligen osynlig\n		p1 = f i+1,j,  k\n		p2 = f i,  j+1,k\n		p3 = f i+1,j+1,k\n		p4 = f i  ,j,  k+1\n		p5 = f i+1,j,  k+1\n		p6 = f i  ,j+1,k+1\n		p7 = f i+1,j+1,k+1\n		[si,sj,sk] = @SHADE\n		fc r*sj,g*sj,b*sj\n		q p2,p6,p7,p3 # left\n		fc r*si,g*si,b*si\n		q p1,p3,p7,p5 # right\n		fc r*sk,g*sk,b*sk\n		q p4,p5,p7,p6 # roof\n	grid : ->\n		sc 0.75\n		[h2,h3,h4] = [200-2*@N*@DY, 200-@N*@DY, 200]\n		[w2,w3,w4] = [100-@N*@DX,   100,        100+@N*@DX]\n		for i in range @N+1\n			line w3+@DX*i, h4-@DY*i, w2+@DX*i, h3-@DY*i\n			line w2+@DX*i, h3+@DY*i, w3+@DX*i, h2+@DY*i\n	mousePressed : ->\n		@showGrid = not @showGrid\n		@enter()\n	enter : (q='') ->\n		@trace = ''\n		move = (di,dj,dk,steps) =>\n			for n in range steps\n				if pen then @add i,j,k\n				i += di\n				j += dj\n				k += dk\n			@trace += steps + ' [' + i + ' ' + j + ' ' + k + '] '\n		i = 0\n		j = 0\n		k = 0\n		dir = 'i'\n		pen = false\n		s = q\n		if q=='' then s = @readText().trim()\n		for c in s\n			if c in 'iIjJkK'\n				dir=c\n				@trace += c\n			else if c=='.' then	pen = not pen\n			else if c==' '\n			else\n				steps = parseInt c\n				if dir=='i' then move 1,0,0,steps\n				else if dir=='I' then move -1,0,0,steps\n				else if dir=='j' then move 0,1,0,steps\n				else if dir=='J' then move 0,-1,0,steps\n				else if dir=='k' then move 0,0,1,steps\n				else if dir=='K' then move 0,0,-1,steps\napp = new BeeHaiku3D \"a\"\n",
  c: {
    app: "reset 2,50,25|reset 10,10,5|reset 17,6,3|enter()"
  },
  d: "reset 10,10,5|enter '.9j9I9J9'",
  e: {
    ForthHaiku: "http://forthsalon.appspot.com/haiku-editor",
    Exempel: 'ForthHaiku3D.html',
    "Beck & Jung": 'https://www.google.se/search?q=beck+jung&tbm=isch&imgil=fTDB34quIvQVtM%253A%253BujSokE1Q4La-QM%253Bhttp%25253A%25252F%25252Fonline.auktionsverket.se%25252F1111%25252F109534-beck-jung-computer-ink-plot&source=iu&pf=m&fir=fTDB34quIvQVtM%253A%252CujSokE1Q4La-QM%252C_&usg=__eBA4v2Ol5RdVComTBJqPkozH59s%3D&biw=1920&bih=1108&dpr=1&ved=0ahUKEwiH0qmqzInUAhVmDZoKHTcYD7wQyjcIQw&ei=hQsmWcf7EOaa6AS3sLzgCw#imgrc=fTDB34quIvQVtM:'
  }
};

ID_BlackBox2D = {
  v: '2017-04-29',
  k: 'bg sc fc range line [] operators int for if text class',
  l: 33,
  b: "class BlackBox2D extends Application\n	reset : ->\n		super\n		@N = 10\n		@SIZE = 20\n		@index = 0\n	up   : -> @index = (@index+1) %% 36\n	down : -> @index = (@index-1) %% 36\n	draw : ->\napp = new BlackBox2D",
  a: "class BlackBox2D extends Application\n	reset : () ->\n		super\n		@N = 10\n		@SIZE = 20\n		@index = 0\n	up   : -> @index = (@index+1) %% 36\n	down : -> @index = (@index-1) %% 36\n	paint : (r,g,b,x,y,txt) ->\n		fc r,g,b\n		if txt? then text txt,x,y else circle x,y,5\n	draw : ->\n		sc()\n		textSize 14\n		textAlign CENTER,CENTER\n		for i in range @N\n			for j in range @N\n				x = @SIZE/2 + @SIZE*i\n				y = @SIZE/2 + @SIZE*j + 1\n				res = @calc i,j\n				if res == true       then @paint 0,1,0,x,y\n				else if res == false then @paint 1,0,0,x,y\n				else if res == 'NaN' then @paint 1,1,0,x,y,'?'\n				else if res >= 100   then @paint 0,1,0,x,y,'..'\n				else if res <= -100  then @paint 1,0,0,x,y,'..'\n				else if res < 0      then @paint 1,0,0,x,y,-res\n				else if res > 0      then @paint 0,1,0,x,y,res\n				else                      @paint 1,1,0,x,y,res\n	fix : (i,j) -> if j == 0 then ['NaN','NaN'] else [i//j, i%j]\n	calc : (i,j) ->\n		n = @N\n		[a,b] = @fix i,j\n		[i, i+j, i-j, i-5, j-6, j*n+i, i*n+j, (n-1-i)*n+n-1-j, (n-1-j)*n+n-1-i, (i-4)*(j-4), i*j, i*i+j*j, i**j, a, b, i%2, (i+j)%2, j&i, i|j, i^j, ~i, i<<j, j>>i, j&(2**i), i==j, i-j==1, i+j==9, i!=j, i>5, i<j, i<=j, i==3 and j==6, i==3 or j==6, (2<i<7) and (1<j<7), 4 <= dist(4.5,4.5,i,j) < 5, (i+j)%2==1][@index]\n\napp = new BlackBox2D \"a\"",
  c: {
    app: "reset()|up()|down()"
  },
  d: "reset()|down()|down()|down()|down()|down()|down()|down()|down()|down()|down()",
  e: {
    Operatorer: "https://www.w3schools.com/jsref/jsref_operators.asp",
    BlackBox: "https://en.wikipedia.org/wiki/Black_box"
  }
};

ID_Blank = {
  v: '2017-05-12',
  k: '',
  b: "# Här kan du laborera med egna idéer!",
  a: "a=null"
};

ID_BoardGame = {
  v: '2017-04-29',
  k: 'bg fc sc circle range for ->',
  l: 21,
  b: "class Board extends Application\n	reset : ->\n		super\n	draw  : ->\n	r     : (d) ->\n	d     : (d) ->\n	n     : (d) ->\napp = new Board",
  a: "\nclass Board extends Application\n	reset : ->\n		super\n		@_X = 100\n		@_Y = 100\n		@_d = 18\n		@_r = 7\n		@_n = 5\n	draw : ->\n		bg 1\n		fc 0\n		sc()\n		@one @_d,@_r,@_X-@_n*@_d, @_Y-@_d,2*@_n+1,3\n		@one @_d,@_r,@_X-@_d, @_Y-@_n*@_d,3,2*@_n+1\n	one : (d,r,x0,y0,m,n) ->\n		for i in range m\n			for j in range n\n				circle x0+d*i,y0+d*j,r\n	r : (d) -> @_r += d\n	d : (d) -> @_d += d\n	n : (d) -> @_n += d\n\napp = new Board \"a\"",
  c: {
    app: "reset()|r -1|r +1|d -1|d +1|n -1|n +1"
  }
};

ID_BouncingBalls = {
  v: '2017-04-29',
  k: 'fc sw sc circle operators [] if for class',
  l: 43,
  b: "class Ball\n	constructor : ->\n	update      : (grav) ->\n	render      : (sel) ->\n\nclass BouncingBalls extends Application\n	classes : -> [Ball]\n	reset   : ->\n		super\n	draw    : ->\n	update  : ->\n	add     : ->\n	delete  : ->\n	selNext : ->\n	selPrev : ->\n	grow    : ->\n	shrink  : ->\n	nextCol : ->\n	prevCol : ->\n	gravity : ->\napp = new BouncingBalls",
  a: "class Ball\n	constructor : ->\n		@x = 100\n		@y = 10\n		@r = 10\n		@c = 1\n		@dx = 10\n		@dy = 5\n	update : (grav) ->\n		@x += @dx\n		@y += @dy\n		if not (@r < @x < 200-@r) then @dx = - @dx\n		if not (@r < @y < 200-@r) then @dy = - @dy\n		if grav and @y < 200-@r then @dy += 5\n	render : (sel) ->\n		fill cc @c\n		sw 2\n		if sel then stroke cct @c else sc()\n		circle @x,@y,@r\n\nclass BouncingBalls extends Application\n	classes : -> [Ball]\n	reset : ->\n		super\n		@balls = []\n		@sel = -1\n		@grav = false\n	draw : ->\n		for ball,i in @balls\n			ball.render i==@sel, @grav\n	update : ->\n		for ball in @balls\n			ball.update(@grav)\n\n	add : ->\n		@balls.push new Ball\n		@sel = @balls.length - 1\n\n	delete :->\n		@balls.splice @sel, 1\n		if @sel >= @balls.length then @sel = @balls.length - 1\n	selNext : -> @sel = (@sel + 1) %% @balls.length\n	selPrev : -> @sel = (@sel - 1) %% @balls.length\n	grow : ->    @balls[@sel].r++\n	shrink : ->  @balls[@sel].r--\n	nextCol : -> @balls[@sel].c = (@balls[@sel].c+1) %% 32\n	prevCol : -> @balls[@sel].c = (@balls[@sel].c-1) %% 32\n	gravity : -> @grav = not @grav\n\napp = new BouncingBalls \"a\"",
  c: {
    app: "reset()|update()|add()|delete()|selNext()|selPrev()|grow()|shrink()|nextCol()|prevCol()|gravity()"
  },
  d: "reset()|gravity()|add()xxxxxxxxxxxxxxxxxxxx".replace(/x/g, "|update()")
};

ID_Braid = {
  v: '2017-04-29',
  k: 'sc bg sw range for line class',
  l: 19,
  b: "class Cartesius\n	constructor : (@r,@g,@b, @x,@y) ->\n	go : (dx,dy) ->\n\nbraid = (n,dx,dy,width) ->\n\nbraid 5,18,18,6",
  a: "class Cartesius\n	constructor : (@r,@g,@b, @x,@y) ->\n	go : (dx,dy) ->\n		sc @r,@g,@b\n		line @x,@y,@x+dx,@y+dy\n		[@x,@y] = [@x+dx,@y+dy]\n\nbraid = (n,dx,dy,width) ->\n\n	a = new Cartesius 1,0,0, 100-dx/2,dy/3\n	b = new Cartesius 1,1,0, 100+dx/2,2*dy/3\n	c = new Cartesius 0,1,0, 100-dx/2,dy\n\n	bg 0\n	sw width\n\n	for i in range n\n		a.go dx,dy\n		b.go -dx,dy\n		c.go dx,dy\n\n		a.go -dx,dy\n		b.go dx,dy\n		c.go -dx,dy\n\nbraid 5,18,18,6",
  e: {
    braid: "https://cdn.tutsplus.com/vector/uploads/legacy/tuts/000-2011/398-hair-braid/6.jpg",
    Wikipedia: "https://en.wikipedia.org/wiki/Braid"
  }
};

ID_Braider = {
  v: '2017-04-29',
  k: 'sc bg sw range for if operators line class',
  l: 49,
  b: "class Cartesius\n	constructor : (x,y,c) ->\n	go          : (dx,dy) ->\n	down        : (d) ->\n	left        : (d) ->\n\nclass Braider extends Application\n	braid   : (type) ->\n	draw    : ->\n	forward : ->\n	back    : ->\napp = new Braider",
  a: "class Cartesius\n	constructor : (@x,@y,@c) ->\n	go : (dx,dy) ->\n		stroke cc @c\n		line @x,@y,@x+dx,@y+dy\n		[@x,@y] = [@x+dx,@y+dy]\n	down : (d) -> @go 0,d\n	left : (d) -> @go -d,0\n\nclass Braider extends Application\n\n	braid : (@type) ->\n		@n = 0\n		@forward()\n	draw : ->\n		if @type==1\n			sw 5\n			a = new Cartesius 200,20, 1 # röd\n			for i in range @n\n				a.go -20,20\n		if @type==2\n			sw 5\n			a = new Cartesius 200,20, 1 # röd\n			b = new Cartesius 190,10, 2 # grön\n			for i in range @n\n				if i%4 == 0 then b.down 20\n				if i%4 == 1 then a.left 20\n				if i%4 == 2 then a.down 20\n				if i%4 == 3 then b.left 20\n		if @type==3\n			sw 5\n			a = new Cartesius 200,30, 1\n			b = new Cartesius 190,10, 2\n			c = new Cartesius 180,20, 3\n			for i in range @n\n				if i%6 == 0 then b.down 30\n				if i%6 == 1 then a.left 30\n				if i%6 == 2 then c.down 30\n				if i%6 == 3 then b.left 30\n				if i%6 == 4 then a.down 30\n				if i%6 == 5 then c.left 30\n		if @type==4\n			sw 10\n			a = new Cartesius 150,40, 1 # röd\n			b = new Cartesius 170,20, 2 # grön\n			c = new Cartesius 160,30, 3 # gul\n			d = new Cartesius 190,50, 4 # blå\n			for i in range @n\n				if i%12 == 0 then b.down 50\n				if i%12 == 1 then c.left 30; c.down 30\n				if i%12 == 2 then d.left 50\n				if i%12 == 3 then a.down 50\n				if i%12 == 4 then b.left 50\n				if i%12 == 5 then c.down 50\n				if i%12 == 6 then d.left 30; d.down 30\n				if i%12 == 7 then a.left 50\n				if i%12 == 8 then b.left 30; b.down 30\n				if i%12 == 9 then d.down 50\n				if i%12 == 10 then c.left 50\n				if i%12 == 11 then a.left 30; a.down 30\n\n	forward : -> @n++\n	back : -> @n--\n\napp = new Braider \"a\"",
  c: {
    app: "braid 1|braid 2|braid 3|braid 4|forward()|back()"
  },
  d: "braid 3ggggggggggggggggg|braid 4gggggggggggggggggggggg".replace(/g/g, "|forward()"),
  e: {
    braid: "https://cdn.tutsplus.com/vector/uploads/legacy/tuts/000-2011/398-hair-braid/6.jpg"
  }
};
//# sourceMappingURL=B.js.map
