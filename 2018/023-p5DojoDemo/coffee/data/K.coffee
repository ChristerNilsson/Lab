ID_Kalkylator =
	v:'2017-04-29'
	k:'bg sc fc range readText operators {} [] text for sqrt PI parseFloat "" class'
	l:46
	b:"""
# TIPS! Börja med de fyra räknesätten.
#       @words ska kunna utökas med ":". T ex ": sq dup *"
#       Definiera t ex invers, distans och parallella motstånd

class Kalkylator extends Application
	reset : ->
		super
	draw  : ->
	chs   : -> # ( n -- n )
	swap  : -> # ( a b -- b a )
	drop  : -> # ( n -- )
	dup   : -> # ( n -- n n )
	sqrt  : -> # ( n -- n )
	clr   : -> # ( a b -- )
	pi    : -> # ( -- n)
	enter : -> # inmatning från textrutan under kommandolistan.
app = new Kalkylator
"""
	a:"""
class Kalkylator extends Application
	reset : ->
		super
		@stack = [0,1,2,3]
		@words = {"sq":["dup","*"]}
	draw : ->
		bg 0
		sc()
		textSize 32
		textAlign RIGHT, BOTTOM
		fc 1,0,0
		for value,i in _.first @stack,5
			s = "" + value
			text s[0..9],190, 200 - i*40

	shift : -> @stack.shift()
	over : -> @stack.splice(1,1)[0]
	unshift : (item) -> @stack.unshift item
	chs : -> @unshift -@shift()
	swap : -> [@stack[0],@stack[1]] = [@stack[1],@stack[0]]
	drop : -> @shift()
	dup : -> @unshift @stack[0]
	sqrt : -> @unshift Math.sqrt @shift()
	clr : -> @stack = []
	pi : -> @unshift Math.PI

	execute : (arr) ->
		for cmd in arr
			if cmd=="" then continue
			if cmd=='+' then @unshift @shift() + @shift()
			else if cmd=='*' then @unshift @shift() * @shift()
			else if cmd=='/' then @unshift @over() / @shift()
			else if cmd=='-' then @unshift @over() - @shift()
			else if cmd=='chs' then @chs()
			else if cmd=='swap' then @swap()
			else if cmd=='drop' then @drop()
			else if cmd=='dup' then @dup()
			else if cmd=='sqrt' then @sqrt()
			else if cmd=='clr' then @clr()
			else if cmd=='pi' then @pi()
			else if cmd of @words then @execute @words[cmd]
			else @stack.unshift eval cmd

	enter : (s='') ->
		commands = s
		if s=='' then commands = @readText()
		if commands=="" then return
		arr = commands.split ' '
		if arr[0]==':' then @words[arr[1]] = arr[2..]
		else @execute arr

app = new Kalkylator "a"
"""
	c:
		app : "reset()|chs()|swap()|drop()|dup()|sqrt()|clr()|pi()|enter()"
	d : "reset()|clr()|enter '3'|enter '4'|enter '*'|enter '13'|swap()|dup()|sqrt()|drop()|clr()|pi()"
	e:
		parseInt : "https://www.w3schools.com/jsref/jsref_parseint.asp"
		stack : "https://sv.wikipedia.org/wiki/Stack_(datastruktur)"
		split : "https://coffeescript-cookbook.github.io/chapters/strings/splitting-a-string"
		"Omvänd Polsk Notation" : "https://sv.wikipedia.org/wiki/Omv%C3%A4nd_polsk_notation"
		RPN : "https://en.wikipedia.org/wiki/Reverse_Polish_notation"
		"HP-35" : "https://neil.fraser.name/software/hp-35"
		"Forth Haiku" : "http://forthsalon.appspot.com/word-list"

ID_Klocka =
	v:'2017-09-30'
	k:'fc sc circle range angleMode rotate point rect rectMode for if translate push pop class Date'
	l:49
	b: """
class Klocka extends Application
	reset  : ->
		super
	draw   : ->
	hour   : (h) ->
	minute : (m) ->
	second : (s) ->
	now 	 : ->
app = new Klocka
			"""
	a: """
class Klocka extends Application
	reset : ->
		super
		@h=10
		@m=9
		@s=30
	draw : ->
		bg 0.5
		rectMode CENTER
		angleMode DEGREES
		translate 100,100
		@urtavla()
		@visare (@h+@m/60.0)*30, 7,60,1,0,0
		@visare (@m+@s/60.0)*6,5,80,0,1,0
		@visare @s*6,2,80,1,1,0
	hour   : (h) -> @adjust h,0,0
	minute : (m) -> @adjust 0,m,0
	second : (s) -> @adjust 0,0,s
	now    : ->
		d = new Date()
		@h = d.getHours()
		@m = d.getMinutes()
		@s = d.getSeconds()
	adjust : (h,m,s) ->
		@h+=h
		@m+=m
		@s+=s
		t = 3600 * @h + 60 * @m + @s
		@s = t %% 60
		t = (t - @s) / 60
		@m = t %% 60
		t = (t - @m) / 60
		@h = t %% 24
	visare : (v,w,l,r,g,b) ->
		push()
		rotate v-90
		translate l/2,0
		fc r,g,b
		rect 0,0,l,w
		pop()
	urtavla : ->
		fc 0
		sc 1
		sw 2
		circle 0,0,90
		fc 1
		sc()
		for i in range 60
			circle 85,0, if i%5==0 then 3 else 2
			rotate 6

app = new Klocka "a"
"""
	c:
		app : "reset()|hour -1|hour +1|minute -1|minute +1|second -1|second +1|now()"
	d : "reset()|hour -1|hour +1|minute -1|minute +1|second -1|second +1|now()"

ID_Korg =
	v:'2017-04-29'
	k:'bg fc sc sw rect for if class'
	l:27
	b:"""
class Korg extends Application
	reset   : ->
		super
	draw    : ->
	more    : ->
	less    : ->
	thinner : ->
	thicker : ->
app = new Korg
"""
	a: """
class Korg extends Application
	reset : ->
		super
		@n = 1
		@w = 5

	draw : ->
		c1 = co 1,0,0
		c2 = co 1,1,0
		bg 0
		sw @w
		fill c1
		stroke c2
		q = 2*@n+1
		d = 200.0/q
		for i in range @n
			rect d+i*2*d,0,d,200
		for j in range @n
			rect 0,d+j*2*d,200,d
		for i in range @n
			for j in range @n
				if (i+j) % 2 == 1
					rect i*2*d,d+j*2*d,3*d,d
				else
					rect d+i*2*d,j*2*d,d,3*d
	more : -> @n = constrain @n+1,1,10
	less : -> @n = constrain @n-1,1,10
	thinner : -> @w = constrain @w-1,0,10
	thicker : -> @w = constrain @w+1,0,10

app = new Korg "a"
"""
	c:
		app : "reset()|more()|less()|thinner()|thicker()"
	d : "reset()|more()|less()|thinner()|thicker()"

ID_Korsord =
	v:'2017-04-29'
	k:'bg fc sc readText operators text if for "" class []'
	l:27
	b: """
# Mata in t ex b..l och få ut bill samt boll. Använd variabeln ordlista.

class Korsord extends Application
	reset : ->
		super
	draw  : ->
	enter : ->
app = new Korsord
"""
	a:"""
class Korsord extends Application
	reset : ->
		super
		@found = ""
		@pattern = ''
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
	match : (word,pattern) ->
		for letter,i in pattern
			if letter != '.' and letter != word[i] then	return false
		true
	enter : ->
		words = ordlista.split " "
		@pattern = @readText()
		@found = []
		for w in words
			if w.length == @pattern.length and @match w,@pattern then @found.push w
		@found = @found.join " "

app = new Korsord "a"
"""
	c:
		app : "reset()|enter()"
	d : "reset()"
