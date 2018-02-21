ID_SevenSegment =
	v:'2017-04-29'
	k:'bg sc fc rect rectMode if operators [] class'
	l:31
	b : """
class Digit extends Application
	reset : ->
		super
	draw  : ->
	up    : ->
	down  : ->
app = new Digit
			"""
	a:"""
class Digit extends Application
	reset : ->
		super
		@PATTERN = [63,6,91,79,102,109,125,7,127,111]
		@X=100
		@Y=100
		@W=80
		@H=18
		@d=0
	draw : ->
		bg 0.5
		sc()
		fc 1,0,0
		rectMode CENTER
		p = @PATTERN[@d]
		w0 = @W-20
		if p & 1 then fc 1,0,0 else fc 0.3,0,0
		rect @X,@Y-@W,w0,@H
		if p & 2 then fc 1,0,0 else fc 0.3,0,0
		rect @X+@W/2,@Y-@W/2,@H,w0
		if p & 4 then fc 1,0,0 else fc 0.3,0,0
		rect @X+@W/2,@Y+@W/2,@H,w0
		if p & 8 then fc 1,0,0 else fc 0.3,0,0
		rect @X,@Y+@W,w0,@H
		if p & 16 then fc 1,0,0 else fc 0.3,0,0
		rect @X-@W/2,@Y+@W/2,@H,w0
		if p & 32 then fc 1,0,0 else fc 0.3,0,0
		rect @X-@W/2,@Y-@W/2,@H,w0
		if p & 64 then fc 1,0,0 else fc 0.3,0,0
		rect @X,@Y,w0,@H
	mousePressed : (mx,my) -> @d = constrain @d + (if my<100 then 1 else -1), 0, 9

app = new Digit "a"
"""
	c:
		app : "reset()"
	d: "reset()|mousePressed 50,50|mousePressed 50,50|mousePressed 50,50|mousePressed 50,50"
	e:
		"7 segment" : "https://www.google.se/search?q=7+segment&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjg_5n55OrSAhWpZpoKHQP8DxoQ_AUIBigB&biw=1310&bih=945"

ID_Shortcut =
	v:'2017-04-29'
	k:'bg fc sc range operators [] text for if return {} constrain class'
	l:65
	b:"""
class Shortcut extends Application
	reset : ->
		super
	draw : ->
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	mousePressed : (mx,my) ->
app = new Shortcut
"""
	a:"""
class Shortcut extends Application
	reset : ->
		super
		@W = 33
		@H = 25
		@seed = 0
		@level = 1
		@buttons = [[50,50,0],[150,50,0],[33,125,'/2'],[100,125,'+2'],[167,125,'*2'], [33,175,'undo'],[100,175,1],[167,175,'new']]
		@createGame()
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	draw : ->
		@buttons[0][2] = @a
		@buttons[1][2] = @b
		@buttons[6][2] = @level - @history.length
		bg 0.5
		textAlign CENTER,CENTER
		textSize 30
		sc()
		for [x,y,txt],i in @buttons
			if i in [0,1,6] then fc 0 else fc 1,1,0
			text txt,x,y
	newGame : ->
		if @level >= @history.length and @a == @b then d=1 else d=-1
		@level = constrain @level+d,1,16
		@createGame()
	createGame : ->
		@history = []
		@a = 1 + @randint 20
		q1 = [@a]
		q2 = []
		visited = {}
		visited[@a] = true
		expand = (n) ->
			if visited[n] then return
			visited[n] = true
			q2.push n
		for level in range @level
			for nr in q1
				expand nr+2
				expand nr*2
				expand nr/2 if nr%2==0
			q1 = q2
			q2 = []
		@b = @selectTarget q1 #[@randint(q1.length)]
	selectTarget : (lst) -> # within 1..1000, if possible
		bs = (x for x in lst when 1 <= x <= 1000)
		return bs[@randint(bs.length)] if bs.length > 0
		_.min lst
	undo : ->
		if @history.length == 0 then return
		@a = @history.pop()
	mousePressed : (mx,my) ->
		index = -1
		for [x,y,txt],i in @buttons
			if x-@W < mx < x+@W and  y-@H < my < y+@H
				index = i
		a = -1
		if index == 2 and @a % 2 == 0 then a = @a / 2
		if index == 3 then a = @a + 2
		if index == 4 then a = @a * 2
		if index == 5 then @undo()
		if index == 7 then @newGame()
		if a != -1
			@history.push @a
			@a = a

app = new Shortcut "a"

"""
	c:
		app : "reset()"
	d: "reset()|mousePressed 160,120|mousePressed 180,180|mousePressed 100,120|mousePressed 160,120|mousePressed 180,180"

ID_Shortcut2 =
	v:'2017-05-04'
	k:'bg fc sc range operators [] for if return _.min text dist int {} constrain class'
	l:126
	b:"""
class Shortcut2 extends Application
	reset : ->
		super
	draw : ->
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	mousePressed : (mx,my) ->
app = new Shortcut2

"""
	a:"""
operNames = '+ - * / % %% ** // & | ^ ~ << >>'.split ' '
operMin =   [1,1,2,2,2,2, 2, 2, 1,1,1,0,1, 1]
opers = [
	(a,b) -> a+b
	(a,b) -> a-b
	(a,b) -> a*b
	(a,b) -> if a%b==0 then a/b else null
	(a,b) -> a%b
	(a,b) -> a%%b
	(a,b) -> a**b
	(a,b) -> a//b
	(a,b) -> a&b
	(a,b) -> a|b
	(a,b) -> a^b
	(a,b) -> ~a
	(a,b) -> a<<b
	(a,b) -> a>>b
]

class Shortcut2 extends Application
	reset : ->
		super
		@seed = 0
		@level = 1
		@page = 1
		@state = 0
		@b0 = []
		@b0 = @b0.concat [[40,40,'+2'],[40,100,'*2'],[40,160,'/2']]
		@b0 = @b0.concat [[140,40,'+'],[180,80,'n'],[140,120,'-'],[100,80,'p']]
		@b0 = @b0.concat [[175,175,'ok']]
		@keys = [0,2,2,2,3,2]
		@b1 = [[50,50,0],[150,50,0],[33,125,''],[100,125,''],[167,125,''], [33,175,'setup'],[100,175,1],[167,175,'new']]
		@createGame()
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	operate : (a,op,b) -> opers[op](a,b)
	name : (a,b) -> if operNames[@keys[a]]=='~' then '~' else operNames[@keys[a]] + @keys[b]
	draw0 : ->
		textAlign CENTER,CENTER
		textSize 28
		textFont 'monospace'
		bg 0.5
		sc()
		sw 2
		for i in range 3
			@b0[i][2] = @name 2*i,2*i+1
		for [x,y,txt],index in @b0
			fc 0
			sc 1
			circle x,y,25
			sc()
			if @state==index then fc 1,0,0 else fc 1
			text txt,x,y
	draw1 : ->
		textAlign CENTER,CENTER
		textSize 20
		textFont 'monospace'
		@b1[0][2] = @a
		@b1[1][2] = @b
		@b1[2][2] = @name 0,1
		@b1[3][2] = @name 2,3
		@b1[4][2] = @name 4,5
		@b1[6][2] = @level - @history.length
		bg 0.5
		sc()
		for [x,y,txt],i in @b1
			if i in [0,1] then fc 0 else fc 1,1,0
			if i in [5,6,7] then textSize 24 else textSize 30
			text txt,x,y
	draw : -> if @page==0 then @draw0() else @draw1()
	newGame : ->
		if @level >= @history.length and @a == @b then d=1 else d=-1
		@level = constrain @level+d,1,16
		@createGame()
	createGame : ->
		@history = []
		@a = 1 + @randint 20
		q1 = [@a]
		q2 = []
		visited = {}
		visited[@a] = true
		expand = (n) ->
			if n==null then return
			if visited[n] then return
			visited[n] = true
			q2.push n
		for level in range @level
			for nr in q1
				expand opers[@keys[0]] nr,@keys[1]
				expand opers[@keys[2]] nr,@keys[3]
				expand opers[@keys[4]] nr,@keys[5]
			q1 = q2
			q2 = []
		@b = @selectTarget q1
	selectTarget : (lst) ->
		bs = (x for x in lst when -1000 <= x <= 1000)
		return bs[@randint(bs.length)] if bs.length > 0
		_.min lst
	undo : ->
		if @history.length == 0 then return
		@a = @history.pop()
	mousePressed0 : (mx,my) ->
		for [x,y,txt],index in @b0
			if dist(mx,my,x,y) < 25
				if index < 3 then @state = index
				if txt=='ok'
					@page = 1
					@level = 0
					@newGame()
				else if index == 3 then @keys[@state*2+1]++
				else if index == 4 then @keys[@state*2]++
				else if index == 5 then @keys[@state*2+1]--
				else if index == 6 then @keys[@state*2]--
				@keys[@state*2]   = constrain @keys[@state*2], 0, 13
				@keys[@state*2+1] = constrain @keys[@state*2+1], operMin[@keys[@state*2]], 9
				return
	mousePressed1 : (mx,my) ->
		index = -1
		for [x,y,txt],i in @b1
			if dist(mx,my,x,y) < 20 then index = i
		a = null
		if index == 2 then a = @operate @a,@keys[0],@keys[1]
		if index == 3 then a = @operate @a,@keys[2],@keys[3]
		if index == 4 then a = @operate @a,@keys[4],@keys[5]
		if index == 5
			@page=0
			@state=0
		if index == 6 then @undo()
		if index == 7 then @newGame()
		if a != null
			@history.push @a
			@a = a
	mousePressed : (mx,my) -> if @page==0 then @mousePressed0 mx,my else @mousePressed1 mx,my

app = new Shortcut2 "a"

"""
	c:
		app : "reset()"
	d : "reset()|mousePressed 33,175"

ID_ShrinkingCircles =
	v:'2017-10-31'
	k:'range fc circle for lerp'
	l:5
	b:""
	a:"""
for i in range 10,0,-1
	fc i/10.0,0,0
	r = 10 * i
	circle 100,100, r
"""

ID_SingaporeMult =
	v:'2017-10-23'
	k:'bg fc sc rect for class readText parseFloat [] split text'
	l:40
	b: """
class SingaporeMult extends Application
	reset : ->
		super
	first : -> 
	second : ->
	more : ->
	less : ->
	bigger : ->
	smaller : ->
	draw : ->
app = new SingaporeMult
"""
	a:"""
class SingaporeMult extends Application
	reset : ->
		super
		@str1 = '40 6'
		@str2 = '90 7'
		@fontSize = 16
		@decimals = 0	

	first   : -> @str1 = @readText()
	second  : -> @str2 = @readText()
	more    : -> @decimals++
	less    : -> @decimals--
	bigger  : -> @fontSize++
	smaller : -> @fontSize--

	nf : (a,b,c) ->
		a = a * 10 ** c
		a = round a
		a = a * 10 ** -c
		nf a,b,c

	sum : (lst) -> lst.reduce (res, item) -> res+item

	calc : () ->
		@lst1 = (parseFloat item for item in @str1.split ' ')
		@lst2 = (parseFloat item for item in @str2.split ' ')
		@lst1.push @sum @lst1 
		@lst2.push @sum @lst2
		@w = 200 / (@lst1.length+1)
		@h = 25

	draw : ->
		bg 0.5
		textAlign RIGHT,TOP
		textSize @fontSize

		@calc()
		rect @w+2, @h-5, @w*(@lst1.length-1), @h*(@lst2.length-1)

		fc 1
		sc()
		for b,j in @lst2
			text b, @w, @h+@h*j
		for a,i in @lst1 
			text a, @w*(i+2), 0
			for b,j in @lst2
				text @nf(a*b,1, @decimals), @w*(i+2),@h*(j+1)

app = new SingaporeMult "a"
"""
	c:
		app : "reset()|first()|second()|more()|less()|bigger()|smaller()"
	d : "reset()|more()|less()|bigger()|smaller()"
	e:
		'46x97' : "https://youtu.be/3EIBMzDdCd0?t=4m45s"

ID_SingaporeMultComplex =
	v:'2017-10-22'
	k:'bg fc sc rect for class readText parseFloat [] split text'
	l:53
	b: """
# 3 1 innebär det komplexa talet 3+i
class SingaporeMultComplex extends Application
	reset : ->
		super
	first : -> 
	second : ->
	bigger : ->
	smaller : ->
	draw : ->
app = new SingaporeMultComplex
"""
	a:"""
class SingaporeMultComplex extends Application
	reset : ->
		super
		@str1 = '3 1'
		@str2 = '1 2'
		@fontSize = 18
		# assert [[3,0],[0,1],[3,1]], @add [3,1]
		# assert [10,10], @mul [3,1],[4,2]
		# assert ['3', '2i'], @display [3,2]
		# assert ['3', 'i'], @display [3,1]
		# assert ['2i'], @display [0,2]

	first   : -> @str1 = @readText()
	second  : -> @str2 = @readText()
	bigger  : -> @fontSize++
	smaller : -> @fontSize--

	calc : () ->
		@lst1 = (parseFloat item for item in @str1.split ' ')
		@lst2 = (parseFloat item for item in @str2.split ' ')
		@lst1 = @add @lst1
		@lst2 = @add @lst2
		@w = 200 / (@lst1.length+1)
		@h = 25

	add : (lst) ->
		[x,y] = lst
		[[x,0],[0,y],[x,y]]

	mul : (a,b) ->
		[x1,y1] = a
		[x2,y2] = b
		[x1*x2 - y1*y2, x1*y2 + x2*y1]

	display : (a) -> # a is a polynom
		res = []
		for f,i in a
			if f == 0
				# nothing
			else if f==1
				if i==0 then res.push '1'
				if i==1 then res.push 'i'
				if i>=2 then res.push 'i'+i	
			else 
				if i==0 then res.push f
				if i==1 then res.push f + 'i'
				if i>=2 then res.push f + 'i' + i	
		res 

	draw : ->
		bg 0.5
		textAlign LEFT,TOP
		textSize @fontSize

		@calc()
		rect @w-2, @h-5, @w*(@lst1.length-1), @h*(@lst2.length-1)

		fc 1
		sc()
		for b,j in @lst2
			text @display(b).join(' '), 0*@w, @h+@h*j
		for a,i in @lst1 
			text @display(a).join(' '), @w*(i+1), 0

		for b,j in @lst2
			for a,i in @lst1
				if j<@lst2.length-1 or (j==@lst2.length-1 and i==@lst1.length-1) 
					text @display(@mul(a,b)).join(' '), @w*(i+1), @h*(j+1)

app = new SingaporeMultComplex "a"
"""
	c:
		app : "reset()|first()|second()|bigger()|smaller()"
	d : "reset()|bigger()|smaller()"
	e:
		complex : "https://www.youtube.com/watch?v=xtKEvZr3zJQ"

ID_SingaporeMultPolynom =
	v:'2017-10-23'
	k:'bg fc sc rect for class readText parseFloat [] split text'
	l:86
	b: """
# Endast faktorer >= 0 hanteras
# 1 3 innebär polynomet 1 + 3x
class SingaporeMultPolynom extends Application
	reset : ->
		super
	first : -> 
	second : ->
	bigger : ->
	smaller : ->
	draw : ->
app = new SingaporeMultPolynom
"""
	a:"""
class SingaporeMultPolynom extends Application
	reset : ->
		super
		@str1 = '3 1'
		@str2 = '4 2 1'
		@fontSize = 14
		# assert [[0,1],[3],[3,1]], @add [3,1]
		# assert [12,10,2], @mul [3,1],[4,2]
		# assert ['x2', '2x', '3'], @display [3,2,1]
		# assert ['x2', '3'], @display [3,0,1]
		# assert ['2x'], @display [0,2]
		# assert ['2x2'], @display [0,0,2]

	first   : -> @str1 = @readText()
	second  : -> @str2 = @readText()
	bigger  : -> @fontSize++
	smaller : -> @fontSize--

	calc : () ->
		@lst1 = (parseFloat item for item in @str1.split ' ')
		@lst2 = (parseFloat item for item in @str2.split ' ')
		@lst1 = @add @lst1
		@lst2 = @add @lst2
		@w = 200 / (@lst1.length+1)
		@h = 25

	add : (lst) ->
		n=lst.length
		res = []
		res.push lst
		for f,i in lst
			tmp = []
			for j in range i
				tmp.push 0
			tmp.push f
			res.push tmp
		res.slice().reverse()

	mul : (a,b) ->
		res = new Array(a.length+b.length-1).fill 0
		for f1,i in a
			for f2,j in b
				res[i+j] += f1 * f2
		res

	display : (a) -> # a is a polynom
		n = a.length
		res = []
		for f,i in a
			if f == 0
				# nothing
			else if f==1
				if i==0 then res.push '1'
				if i==1 then res.push 'x'
				if i>=2 then res.push 'x'+i	
			else 
				if i==0 then res.push f.toString()
				if i==1 then res.push f.toString() + 'x'
				if i>=2 then res.push f.toString() + 'x' + i.toString()	
		res.slice().reverse()

	draw : ->
		bg 0.5
		textAlign LEFT,TOP
		textSize @fontSize

		@calc()
		rect @w-2, @h-5, @w*(@lst1.length-1), @h*(@lst2.length-1)

		fc 1
		sc()
		for b,j in @lst2
			text @display(b).join('+'), 0*@w, @h+@h*j
		for a,i in @lst1 
			text @display(a).join('+'), @w*(i+1), 0

		for b,j in @lst2
			for a,i in @lst1
				if j<@lst2.length-1 or (j==@lst2.length-1 and i==@lst1.length-1) 
					if j==@lst2.length-1 and i==@lst1.length-1
						textAlign RIGHT,TOP
						text @display(@mul(a,b)).join('+'), @w*(i+2), @h*(j+1)
					else
						textAlign LEFT,TOP
						text @display(@mul(a,b)).join('+'), @w*(i+1), @h*(j+1)

app = new SingaporeMultPolynom "a"
"""
	c:
		app : "reset()|first()|second()|bigger()|smaller()"
	d : "reset()|bigger()|smaller()"
	e:
		polynom : "https://www.youtube.com/watch?v=fGy9UMSm-_M"

ID_Skislope =
	v:'2017-10-31'
	k:'bg sc range for lerp line'
	l:5
	b: ""
	a: """
bg 0
sc 1,0,0
for i in range 21
	line i*10,0, 200,i*10
"""

ID_Snake =
	v:'2017-04-29'
	k:'bg fc [] rect operators dist for if class'
	l:47
	b: """
class Snake extends Application
	reset : ->
		super
	setSize : (s) ->
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	draw : ->
	mousePressed : (mx,my) ->
app = new Snake
"""
	a:"""
class Snake extends Application
	reset : ->
		super
		@BUTTONS = [[33,167],[167,167]]
		@DIRS = [[1,0],[0,-1],[-1,0],[0,1]]
		@setSize 20
	setSize : (s) ->
		@SIZE = s
		@N = 200/@SIZE
		@seed = 0
		@segments = [[5,5]]
		@dir = 0
		@total = 2
		@cherry = [3,3]
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	update : ->
		[di,dj] = @DIRS[@dir]
		[i,j] = @segments[0]
		i = (i+di) %% @N
		j = (j+dj) %% @N
		@segments.unshift [i,j]
		if @total < @segments.length then @segments.pop()
		if i==@cherry[0] and j==@cherry[1]
			@total++
			@cherry = [@randint(@N),@randint(@N)]
	draw : ->
		bg 1,0,0
		[i,j] = @segments[0]
		for [si,sj],k in @segments
			if k>0 and i==si and j==sj then return
		bg 1
		[ci,cj] = @cherry
		fc 1,0,0
		rect @SIZE*ci,@SIZE*cj,@SIZE,@SIZE
		for [i,j],k in @segments
			if k==0 then fc 0 else fc 0.5
			rect @SIZE*i,@SIZE*j,@SIZE,@SIZE
		fc 0.9,0.9,0.9,0.3
		for [x,y] in @BUTTONS
			circle x,y,33
	mousePressed : (mx,my) ->
		index = -1
		for [x,y],i in @BUTTONS
			if dist(x,y,mx,my) < 33 then index = i
		if index == 0 then @dir = (@dir+1) %% 4
		if index == 1 then @dir = (@dir-1) %% 4
		@update()

app = new Snake "a"
"""
	c:
		app : "reset()|setSize 20|setSize 10|setSize 5|setSize 2"
	d : "reset()|mousePressed 160,160|mousePressed 160,160|mousePressed 160,160|mousePressed 160,160|mousePressed 100,100|mousePressed 100,100"
	e:
		Snake : "https://en.wikipedia.org/wiki/Snake_(video_game)"

ID_Snake4 =
	v:'2017-04-29'
	k:'bg fc [] rect operators dist for if class'
	l:43
	b: """
class Snake4 extends Application
	reset : ->
		super
	setSize : (s) ->
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	draw : ->
	mousePressed : (mx,my) ->
app = new Snake4
"""
	a:"""
class Snake4 extends Application
	reset : ->
		super
		@BUTTONS = [[167,100], [100,33], [33,100], [100,167]]
		@DIRS = [[1,0],[0,-1],[-1,0],[0,1]]
		@setSize 20
	setSize : (s) ->
		@SIZE = s
		@N = 200/@SIZE
		@seed = 0
		@segments = [[5,5]]
		@dir = 0
		@total = 2
		@cherry = [3,3]
	randint : (n) -> int n * fraction 10000 * Math.sin @seed++
	update : ->
		[di,dj] = @DIRS[@dir]
		[i,j] = @segments[0]
		i = i+di
		j = j+dj
		@segments.unshift [i,j]
		if @total < @segments.length then @segments.pop()
		if i==@cherry[0] and j==@cherry[1]
			@total++
			@cherry = [@randint(@N),@randint(@N)]
	draw : ->
		bg 1,0,0
		[i,j] = @segments[0]
		if i in [-1,@N] or j in [-1,@N] then return
		bg 1
		[ci,cj] = @cherry
		fc 1,0,0
		rect @SIZE*ci,@SIZE*cj,@SIZE,@SIZE
		for [i,j],k in @segments
			if k==0 then fc 0 else fc 0.5
			rect @SIZE*i,@SIZE*j,@SIZE,@SIZE
		fc 0.9,0.9,0.9,0.3
		for [x,y] in @BUTTONS
			circle x,y,33
	mousePressed : (mx,my) ->
		for [x,y],i in @BUTTONS
			if dist(x,y,mx,my) < 33 and abs(i-@dir)!=2 then @dir = i
		@update()

app = new Snake4 "a"
"""
	c:
		app : "reset()|setSize 20|setSize 10|setSize 5|setSize 2"
	d : "reset()|setSize 20|mousePressed 150,100|mousePressed 100,50|mousePressed 50,100"
	e:
		Play : "http://patorjk.com/games/snake"
		Source : "https://github.com/patorjk/JavaScript-Snake/blob/master/js/snake.js"
		Wikipedia : "https://en.wikipedia.org/wiki/Snake_(video_game)"

ID_SnowWhiteAndThe7Lerps =
	v:'2017-09-30'
	k:'bg fc sc range angleMode rotate rect rectMode for lerp translate push pop'
	l:17
	b:""
	a:"""
bg 1
rectMode CENTER
angleMode DEGREES
sc()
for i in range 10
	for j in range 10
		push()
		x = lerp 10,30,i
		y = lerp 10,30,j
		translate x,y
		rotate lerp 0,10,i-j
		r = lerp 0.1,0.2,i
		g = lerp 0.1,0.2,j
		fc r,g,0
		w = lerp 5,6,i
		h = lerp 5,6,j
		rect 0,0, w,h
		pop()
"""

ID_Sokoban =
	v:'2017-04-29'
	k:'bg sc fc sw range operators [] text for if rect circle dist class'
	l:94
	b: """
class Sokoban extends Application
	reset : ->
		super
	newGame : ->
	draw : ->
	mousePressed : (mx,my) ->
	undo : ->
app = new Sokoban
"""
	a: """
OK = 1
GREEN = 2
BOX = 4
class Sokoban extends Application
	reset : ->
		super
		@level = -1
		@newGame()
		@buttons = []
		@buttons.push [100,145],[120,165],[100,185],[80,165]
	newGame : ->
		@moves = 0
		@boards = []
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwweoeEwwwwwwwwwwwwwwmwwewwwwwwwwwwwwEeewweeeeewwwwwwwwewewweewwewwwwwwwweeoeeeewwewwwwwwwweeeeeeeeeewwwwwwwwwwweewewwwwwwwwwwwwweeewewwwwwwwwwwwwweeeeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwweeeeewwwwwwwwwwwwwewewewwwwwwwwwwwEeeeeoeoEeeeewwwwwewweewwwwwwwwwwwwEeoemewwwwwwwwwwwwewewwewwwwwwwwwwwweeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwweeewwwwwwwwwwwwwwwewewwwwwwwwwwwweeeeeeewwwwwwwwwwweeeeeeEwwwwwwwwwwweeeeEwewwwwwwwwwwwweeoewewwwwwwwwwwwwoweewewwwwwwwwwwwwmwOeeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwweeeewwwwwwwwwweeEeEwwewwwwwwwwwweeeeewwewwwwwwwwweoeweEwwewwwwwwwwwmoeeeoeeeeeewwwwwweewweeewwwwwwwwwwwwwwwwewwwwwwwwwwwwwwwwwewwwwwwwwwwwwwwwwwOwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwweeeeeeewwwwwwwwwwwewwewweeewwwwwwwwweEeeeeeeoewwwwwwweewweoeewemwwwwwwweEeoewwewwwwwwwwwweewwewwEwwwwwwwwwwwwwwewwewwwwwwwwwwwwwweoEewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwweewwwwwwwwwwwwwwwweeEeeEwwwwwwwwwwwwwEeeeeoEwwwwwwwwwwwewwoewwwwwwwwwwwwwewwmowwwwwwwwwwwwwewweewwwwwwwwwweeeeOeowwwwwwwwwwweeeeeeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwweewwwwwwwwwwwwwwwweomEwwwwwwwwwweeeeeEoEwwwwwwwwwwwweoewoEwwwwwwwwwwwweweweowwwwwwwwwwwweweweewwwwwwwwwwwweweeEwwwwwwwwwwwwweeeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwmwwwweewwwwwwwwwwwowwwwoewwwwwwwwweeEEeeeeewwwwwwwwweweewowwOwwwwwwwwweEeeeoEeEwwwwwwwwwwewwowwwwwwwwwwwwwweeeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwweeeeewwwwwwwwwwwwweeeeeeoMwwwwwwwwwwewewwewwwwwwwwwwwwEeeeweweoeEwwwwwwweewowoeewwOewwwwwweEeeeewewwewwwwwwwewwwwwwewwewwwwwwwewwwwwweOeewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@boards.push 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwEwwwwwwwwwwwwwwweeoeewwwwwwwwwwwwwewoeewwwwwwwwwwwwweEEOEwwwwwwwwwwwwwewwmewwwwwwwwwwwwweoeoewwwwwwwwwwwwwweweewwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		@level = (@level + 1) % @boards.length
		s = @boards[@level]
		@board = []
		for j in range 12
			@board.push []
			for i in range 18
				k = 18 * j + i
				if s[k] == 'm' then @man = [i,j]
				if s[k] == 'w' then digit = 0
				if s[k] in ['e','m'] then digit = OK
				if s[k] == 'E' then digit = OK+GREEN
				if s[k] == 'o' then digit = OK+BOX
				if s[k] == 'O' then digit = OK+BOX+GREEN
				@board[j].push digit
	draw : ->
		bg 0
		sc 0
		sw 1
		rectMode CENTER
		for j in range 12
			for i in range 18
				size = 10
				digit = @board[j][i]
				fc 0.75
				if digit == 0 then fc 1,0,0
				if (digit & GREEN) == GREEN then fc 0,1,0
				rect 15+10*i,15+10*j,size,size
				if (digit & BOX) == BOX
					fc 1,1,0
					size = 6
					rect 15+10*i,15+10*j,size,size
				if _.isEqual @man, [i,j]
					fc 0,0,1
					circle 15+10*i+0.5,15+10*j+0.5,3
		for [x,y] in @buttons
			fc 1,1,1,0.5
			circle x,y,12
		textSize 30
		textAlign CENTER,CENTER
		fc 1
		text @level,30,165
		text @moves,170,165
	move : (i,j) ->
		if dist(i,j,@man[0],@man[1]) != 1 then return
		digit = @board[j][i]
		ni = i+i-@man[0]
		nj = j+j-@man[1]
		if (digit & BOX) == BOX
		  if @board[nj][ni] in [1,3]
				@board[nj][ni] |= BOX
				@board[j][i] &= OK+GREEN
				@moves++
				if @final() then return @newGame()
				@man = [i,j]
		else if (digit & OK) == OK then	@man = [i,j]
	final : ->
		for j in range 12
			for i in range 18
				if @board[j][i] in [3,5] then return false
		true
	mousePressed : (mx,my) ->
		for [x,y],i in @buttons
			if dist(mx,my,x,y) <= 12
				[di,dj] = [[0,-1],[1,0],[0,1],[-1,0]][i]
				@move @man[0]+di,@man[1]+dj
	undo : ->
		@level--
		@newGame()

app = new Sokoban "a"
"""
	c:
		app : "reset()|undo()"
	d : "reset()|mousePressed 100,145|mousePressed 100,145|mousePressed 120,165|mousePressed 120,165|mousePressed 80,165|mousePressed 80,165|mousePressed 100,185|mousePressed 100,185|mousePressed 80,165 |mousePressed 80,165|mousePressed 100,185|mousePressed 100,185|mousePressed 100,185|mousePressed 120,165|mousePressed 120,165|mousePressed 120,165|mousePressed 100,145|mousePressed 80,165|mousePressed 80,165|mousePressed 100,185|mousePressed 80,165|mousePressed 100,145|mousePressed 100,145"
	e:
		Sokoban : "http://www.linusakesson.net/games/autosokoban/?v=1&seed=355842047&level=1"
		Wikipedia : "https://en.wikipedia.org/wiki/Sokoban"

ID_SpaceShip =
	v:'2017-09-30'
	k:'sc sw angleMode rotate point triangle translate cos sin push pop class'
	l:35
	b:"""
class Shot
	constructor : (@x,@y,@dir) ->
	render      : ->
	move        : ->

class Ship extends Application
	classes : -> [Shot]
	reset   : ->
		super
	draw    : ->
	left    : ->
	right   : ->
	forward : ->
	shoot   : ->

app = new Ship
"""
	a: """

class Shot
	constructor : (@x,@y,@dir) ->
	render : ->	point @x,@y
	move : ->
		@x += int 5 * cos @dir
		@y += int 5 * sin @dir

class Ship extends Application
	classes : -> [Shot]
	reset : ->
		super
		@S = 10
		@x = 100
		@y = 100
		@dir = 0
		@shots = []

	left    : -> @dir -= 5
	right   : -> @dir += 5
	forward : ->
		angleMode DEGREES
		@x += 5 * cos @dir
		@y += 5 * sin @dir

	shoot : ->
		@shots.push new Shot int(@x), int(@y), @dir

	draw : ->
		push()
		translate @x,@y
		angleMode DEGREES
		rotate @dir
		sc 1,1,0
		sw 2
		triangle 2*@S,0, -@S,@S, -@S,-@S
		sw 5
		point 0,0
		pop()
		for shot in @shots
			shot.move()
			shot.render()

app = new Ship "a"
"""
	c:
		app: "reset()|left()|right()|forward()|shoot()"
	d: "reset()|left()|right()|forward()|shoot()|right()|forward()|shoot()|right()|forward()|shoot()"

ID_Square =
	v:'2017-09-30'
	k:'bg sw fc angleMode rotate rect rectMode translate operators class'
	l:22
	b: """
class Square extends Application
	reset        : ->
		super
	draw         : ->
	horisontellt : (d) ->
	vertikalt    : (d) ->
	storlek      : (d) ->
	tjocklek     : (d) ->
	rotera       : (d) ->
app = new Square
"""
	a: """
class Square extends Application
	reset : ->
		super
		@x = 100
		@y = 100
		@size = 100
		@w = 1
		@dir = 0
	draw : ->
		bg 0
		rectMode CENTER
		angleMode DEGREES
		sw @w
		fc 0.5
		translate @x,@y
		rotate @dir
		rect 0,0,@size,@size

	horisontellt : (d) -> @x += d
	vertikalt : (d) -> @y += d
	storlek : (d) -> @size += d
	tjocklek : (d) -> @w += d
	rotera : (d) -> @dir += d

app = new Square "a"
"""
	c:
		app : "reset()|horisontellt -1|horisontellt +1|vertikalt -1|vertikalt +1|storlek -1|storlek +1|tjocklek -1|tjocklek +1|rotera -1|rotera +1"
	d: "reset()|horisontellt -10|horisontellt +10|vertikalt -10|vertikalt +10|storlek -10|storlek +10|tjocklek +10|tjocklek -10|rotera -10|rotera +10"

ID_SquareHole =
	v : '2017-04-29'
	k : 'fc sc sw rect'
	l : 11
	b : ""
	a : """
fc 0,1,1
sc()
rect 60,60, 80,20
rect 60,120, 80,20
rect 60,60, 20,80
rect 120,60, 20,80
fc()
sc 1,0,0
sw 3
rect 60,60, 80,80
rect 80,80, 40,40
"""

ID_Stopwatch =
	v:'2017-04-29'
	k:'bg sc fc for [] text int millis nf class'
	l:20
	b:"""
# OBS! Tiderna kan skilja med flera millisekunder. Sorry!

class Stopwatch extends Application
	reset : ->
		super
	draw  : ->
	mousePressed : (mx,my) ->
app = new Stopwatch
"""
	a:"""
class Stopwatch extends Application
	reset : ->
		super
		@start = int millis()
		@times = []
		@count = 0
	draw : ->
		bg 0
		textFont "monospace"
		textSize 32
		textAlign RIGHT,BOTTOM
		fc 1,0,0
		sc()
		for time,i in @times
			text @count-i, 50, 202-40*i
			text nf(time/1000,1,3),195, 202-40*i
	mousePressed : (mx,my) ->
		@count++
		@times.unshift int millis()-@start
		if @times.length > 5 then @times.pop()

app = new Stopwatch "a"
"""
	c:
		app: "reset()"
	d: "reset()|mousePressed 100,100"

ID_Sunshine =
	v:'2017-04-29'
	k:'bg sc range for lerp line'
	l:9
	b: ""
	a: """
bg 0
sc 1,1,0
for i in range 10
	x1 = lerp 0,20,i
	x2 = lerp 200,180,i
	line x1,0, x2,200
	y1 = lerp 20,40,i
	y2 = lerp 180,160,i
	line 0,y1, 200,y2
"""

ID_SuperCircle =
	v:'2017-04-29'
	k:'bg range operators for line'
	l:7
	b: ""
	a: """
bg 0
for i in range 21
	ni = 5 * i
	line ni,     200,   0, 100+ni
	line ni,       0,   0, 100-ni
	line 100+ni, 200, 200, 200-ni
	line 100+ni,   0, 200, ni
"""
	e:
		PietHein : "https://sv.wikipedia.org/wiki/Piet_Hein"
		SuperEllips : "https://sv.wikipedia.org/wiki/Superellips"
		SergelsTorg : "https://www.google.se/search?q=sergels+torg&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjGpt-jmanTAhWSKCwKHSsMDcQQ_AUICCgB&biw=925&bih=919#tbm=isch&q=superellips+sergels+torg&imgrc=rK6GQHPFiDHQGM:"