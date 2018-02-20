ID_Five =
	v:'2017-04-29'
	k:'bg circle fc sc'
	l:12
	b: """
# LÄXA: Hela uppgiften utom vitt.
"""
	a: """
bg 0.5
sc()
fc 1
circle 100,100,20
fc 1,0,0
circle 40,40,20
fc 1,1,0
circle 40,160,20
fc 0,1,0
circle 160,160,20
fc 0,0,1
circle 160,40,20
"""

ID_ForthHaiku =
	v:'2017-04-29'
	k:'fc range if [] _.last rect for parseFloat class'
	l:45
	b:"""
# Lös först exemplen mha länken nedan!

class ForthHaiku extends Application
	reset : ->
		super
	resolution : (@n,@size) ->
	nextExample : ->
	prevExample : ->
app = new ForthHaiku
"""
	a:"""
class ForthHaiku extends Application
	draw : ->
		bg 0.5
		digit = (bool) -> if bool then 1 else 0
		stack = []
		dict = {}
		dict['x'] = => stack.push x / @n
		dict['y'] = => stack.push y / @n
		dict['<'] = -> stack.push(digit stack.pop() > stack.pop())
		dict['>'] = -> stack.push(digit(stack.pop() < stack.pop()))
		dict['+'] = -> stack.push stack.pop() + stack.pop()
		dict['-'] = -> stack.push -stack.pop() + stack.pop()
		dict['*'] = -> stack.push stack.pop() * stack.pop()
		dict['sq'] = ->
			temp = stack.pop()
			stack.push temp * temp
		dict['%'] = ->
			a = stack.pop()
			b = stack.pop()
			stack.push b % a
		dict['floor'] = -> stack.push floor stack.pop()
		dict['and'] = -> #  pga kortslutning
			a = stack.pop() != 0
			b = stack.pop() != 0
			stack.push digit a and b
		arr = @example.split ' '
		sc()
		for x in range @n
		  for y in range @n
		    stack = []
		    for cmd in arr
		      if dict[cmd] then dict[cmd]()
		      else stack.push parseFloat cmd
		    stack.push 0 for i in range 3-stack.length
		    fc stack[0], stack[1], stack[2]
		    rect @size * x, @size * y, @size, @size
	reset : ->
		super
		@resolution()
		@select 0
	resolution : (@n=10,@size=20) ->
	nextExample : -> @select @index+1
	prevExample : -> @select @index-1
	select : (n) ->
		examples = '1|1 1|0 1|0.25 0.25 0.25|1 1 1|x|x y|x y >|x 0.5 >|x 0.5 - sq y 0.5 - sq + 0.25 <|x 8 * floor y 8 * floor + 2 %|x 0.5 < y 0.5 <|x 0.5 < y 0.5 < and'
		examples = examples.split '|'
		@index = constrain n,0,examples.length-1
		@example = examples[@index]

app = new ForthHaiku "a"
"""
	c:
		app : "reset()|resolution 10,20|resolution 20,10|resolution 50,4|resolution 100,2|resolution 200,1|nextExample()|prevExample()"
	e:
		"ForthHaiku" : "http://forthsalon.appspot.com"

ID_ForthHaiku3D =
	v:'2017-05-30'
	k:'bg sc fc range for if quad line operators class []'
	l:138
	b:"""
# Stack-1 : < > == <= >= != + - * / // % %% and or xor & | ^ bit
# Stack   : abs not swp rot ~ biti bitj bitk
# Stack+1 : i j k t dup bitij bitik bitjk
# Stack+2 : bitijk

# false      <=> 0
#  true      <=> 1
# i b bit    <=> b >> i & 1
# b biti     <=> b >> i & 1
# b bitij    <=> i b bit j b bit
# b bitijk   <=> i b bit j b bit k b bit
# Exempel: t 10 % k ==

class ForthHaiku3D extends Application
	reset : (n,dx,dy)->
		super
	draw : ->
	enter : ->
	tick : ->
	mousePressed : ->
app = new ForthHaiku3D
"""
	a:"""
class ForthHaiku3D extends Application
	reset : (n,dx,dy)->
		super
		@SHADE = [0.5,0.75,1]
		@N = n
		@DX = dx
		@DY = dy
		@showGrid = true
		@clear()
		@t = 0
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
	tick : ->
		@t = @t + 1
		@enter()
	enter : ->
		digit = (bool) -> if bool then 1 else 0
		@clear()
		s = @readText().trim()
		if s=='' then s='k t ' + @N + ' % =='
		arr = s.split ' '
		@words = arr.length
		@trace = ''
		@count = 0
		for i in range @N
			for j in range @N
				for k in range @N
					stack = []
					for cmd in arr
						if cmd == 'dup' then stack.push _.last stack
						else if cmd == 'swp'
							n = stack.length - 1
							[stack[n-1],stack[n]] = [stack[n],stack[n-1]]
						else if cmd == 'rot' then stack.push stack.shift()
						else if cmd == 'i'  then stack.push i
						else if cmd == 'j'  then stack.push j
						else if cmd == 'k'  then stack.push k
						else if cmd == 't'  then stack.push @t
						else if cmd == '<'  then stack.push digit stack.pop() > stack.pop()
						else if cmd == '>'  then stack.push digit stack.pop() < stack.pop()
						else if cmd == '==' then stack.push digit stack.pop() == stack.pop()
						else if cmd == '<=' then stack.push digit stack.pop() >= stack.pop()
						else if cmd == '>=' then stack.push digit stack.pop() <= stack.pop()
						else if cmd == '!=' then stack.push digit stack.pop() != stack.pop()
						else if cmd == '+'  then stack.push stack.pop() + stack.pop()
						else if cmd == '-'  then stack.push -stack.pop() + stack.pop()
						else if cmd == '*'  then stack.push stack.pop() * stack.pop()
						else if cmd == '/'
							a = stack.pop()
							stack.push stack.pop() / a
						else if cmd == '//'
							a = stack.pop()
							stack.push stack.pop() // a
						else if cmd == '%'
							a = stack.pop()
							stack.push stack.pop() % a
						else if cmd == '%%'
							a = stack.pop()
							stack.push stack.pop() %% a
						else if cmd == 'bit' then stack.push stack.pop() >> stack.pop() & 1
						else if cmd == 'biti' then stack.push stack.pop() >> i & 1
						else if cmd == 'bitj' then stack.push stack.pop() >> j & 1
						else if cmd == 'bitk' then stack.push stack.pop() >> k & 1
						else if cmd == 'bitij'
							bits = stack.pop()
							stack = stack.concat [bits >> i & 1, bits >> j & 1]
						else if cmd == 'bitik'
							bits = stack.pop()
							stack = stack.concat [bits >> i & 1, bits >> k & 1]
						else if cmd == 'bitjk'
							bits = stack.pop()
							stack = stack.concat [bits >> j & 1, bits >> k & 1]
						else if cmd == 'bitijk'
							bits = stack.pop()
							stack = stack.concat [bits >> i & 1, bits >> j & 1, bits >> k & 1]
						else if cmd == '&' then stack.push stack.pop() & stack.pop()
						else if cmd == '|' then stack.push stack.pop() | stack.pop()
						else if cmd == '^' then stack.push stack.pop() ^ stack.pop()
						else if cmd == '~' then stack.push ~stack.pop()
						else if cmd == 'and'
							[a,b] = [stack.pop(),stack.pop()]
							stack.push digit a!=0 and b!=0
						else if cmd == 'or'
							[a,b] = [stack.pop(),stack.pop()]
							stack.push digit a!=0 or b!=0
						else if cmd == 'xor'
							a = digit stack.pop() != 0
							b = digit stack.pop() != 0
							stack.push digit a+b == 1
						else if cmd == 'not' then stack.push digit stack.pop() == 0
						else if cmd == 'abs' then stack.push abs stack.pop()
						else stack.push parseFloat cmd
						if i==@N-1 and j==@N-1 and k==@N-1 then @trace += cmd + ' [' + stack.join(',') + '] '
					if stack.pop() != 0
						@count++
						@add i,j,k
		@trace = @trace.trim()
app = new ForthHaiku3D "a"

"""
	c:
		app : "reset 2,50,25|reset 10,10,5|reset 17,6,3|enter()|tick()"
	e:
		ForthHaiku : "http://forthsalon.appspot.com/haiku-editor"
		Exempel : 'ForthHaiku3D.html'
		"Beck & Jung" : 'https://www.google.se/search?q=beck+jung&tbm=isch&imgil=fTDB34quIvQVtM%253A%253BujSokE1Q4La-QM%253Bhttp%25253A%25252F%25252Fonline.auktionsverket.se%25252F1111%25252F109534-beck-jung-computer-ink-plot&source=iu&pf=m&fir=fTDB34quIvQVtM%253A%252CujSokE1Q4La-QM%252C_&usg=__eBA4v2Ol5RdVComTBJqPkozH59s%3D&biw=1920&bih=1108&dpr=1&ved=0ahUKEwiH0qmqzInUAhVmDZoKHTcYD7wQyjcIQw&ei=hQsmWcf7EOaa6AS3sLzgCw#imgrc=fTDB34quIvQVtM:'
