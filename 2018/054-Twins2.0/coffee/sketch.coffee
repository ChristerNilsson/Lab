# fungerar för nämnare <= 10

b = null
level = 0
Size = null

selected = null # innehåller [i,j]
msg = null  # innehåller [i,j]

msg2 = null # innehåller [n,d]
mode = 4
sums = []

f = (n,a,b,base=10) -> g n,(a/b).toString base
g = (n,s) ->
	if s.length < n then return [s,'']
	s = s.slice 0,s.length-1
	if '.' not in s then return [s,'']  
	[integer,mantissa] = s.split '.'
	res = integer + '.'

	for i in range s.length
		p = pattern mantissa.slice i
		if p.length>0 then return [res+mantissa.slice(0,i), p]
	[res,mantissa]

gcd = (x, y) -> if y == 0 then x else gcd y, x % y

pattern = (s) ->
	for antal in range 1,13
		ok = true
		p = s.slice 0,antal
		if 2*antal > s.length then ok = false 
		for j in range s.length // antal
			q = s.slice j*antal,(j+1)*antal 
			if p != q then ok = false
		if ok then return p
	''

makeGame = (delta=0) ->
	level += delta
	level = constrain level,0,7
	mode = [0,0,1,1,2,2,3,4][level]

	Size = 3+level 

	candidates = []
	b = new Array Size
	for i in range Size
		b[i] = new Array Size
		for j in range Size
			if i==j
				b[i][j] = null
			else
				b[i][j] = [i+1,j+1]
				candidates.push [i+1,j+1]

	for c1,i in candidates
		[n1,d1] = c1
		for c2,j in candidates
			[n2,d2] = c2
			if i>j 
				d = d1*d2
				n = n1*d2+n2*d1
				e = gcd n,d
				n //= e
				d //= e
				#print n1,d1,n2,d2,n,d
				#print "#{n}/#{d}" #f(13,n,d,10), f(50,n,d,2)

	candidates = _.shuffle candidates
	sums = []
	for i in range candidates.length//2
		[n1,d1] = candidates.pop()
		[n2,d2] = candidates.pop()
		d = d1*d2
		n = n1*d2+n2*d1
		e = gcd n,d
		n //= e
		d //= e
		sums.push [n,d]
		#print n1,d1,n2,d2,n,d
		#print f 13,n,d,10
		#print f 50,n,d,2

	#milliseconds0 = millis()
	#state = 'running'

findSum = ->
	lst = []
	for i in range Size
		for j in range Size
			if b[i][j] then lst.push [i,j]
	if lst.length==0 
		makeGame 1
		for i in range Size
			for j in range Size
				if b[i][j] then lst.push [i,j]

	index1 = [-1,-1]
	index2 = [-1,-1]
	while index1[0]==index2[0] and index1[1]==index2[1]		
		index1 = _.sample lst
		index2 = _.sample lst
	[n1,d1] = fetchCell index1
	[n2,d2] = fetchCell index2
	d = d1*d2
	n = n1*d2+n2*d1
	e = gcd n,d
	n //= e
	d //= e
	[n,d]

display = (m,n,d,x,y) ->
	if m==0
		if d==1 then text "#{n}",x,y
		else text "#{n}/#{d}",x,y
	if m==1 then text "DEC #{n/d}",x,y
	if m==2 
		[s,t] = f 13,n,d,10
		text "DEC #{[s,t].join ''}",x,y
		x0 = x+4+4*37+37*s.length
		if t != "" then line x0,y+2,x0+37*t.length,y+2
	if m==3 then	text "BIN #{(n/d).toString(2)}",20,y
	if m==4 
		[s,t] = f 50,n,d,2
		text "BIN #{[s,t].join ''}",20,y
		x0 = x+4+4*37+37*s.length
		if t != "" then line x0,y+2,x0+37*t.length,y+2

setup = ->
	createCanvas 1900,800
	rectMode CENTER
	textAlign CENTER,CENTER
	makeGame()
	msg2 = findSum()
	xdraw()
	printHelp()

xdraw = ->
	bg 0.5
	textFont 'Courier'
	push()
	textSize 20
	textAlign CENTER,CENTER
	sw 1

	translate 100,100
	for i in range Size
		for j in range Size
			sw 1
			rect 40*i,40*j,40,40
			if b[j][i] 
				[n,d] = b[j][i] 
				e = gcd n,d
				n //= e
				d //= e
				if d==1 
					text n,40*i,40*j
				else
					text n,40*i,40*j-10+2
					sw 1
					line 40*i-10,40*j,40*i+10,40*j
					text d,40*i,40*j+10+2
	pop()

	textSize 64
	textAlign LEFT,TOP
	sw 1

	if selected
		[j,i] = selected
		push()
		fc 1,1,0,0.5
		circle 100+40*i,100+40*j,19
		pop()

	if msg
		[n,d] = fetchCell msg
		if n != d then display mode,n,d,20,18
	[n,d] = msg2
	display mode,n,d,20,480
	# display 1,n,d,20,540
	# display 2,n,d,20,600
	# display 3,n,d,20,660
	# display 4,n,d,20,720

within = (i,j) -> 0 <= i < Size and 0 <= j < Size and i!=j

fetchCell = (pair) -> b[pair[0]][pair[1]]
clearCell = (pair) -> b[pair[0]][pair[1]] = null

mousePressed = ->
	j = (mouseX-80)//40
	i = (mouseY-80)//40	
	msg = if within i,j then [i,j] else null
	if not selected # first selection
		selected = msg
	else if msg # second selection
		[n1,d1] = fetchCell selected
		[n2,d2] = fetchCell msg
		d = d1*d2
		n = n1*d2+n2*d1
		e = gcd n,d
		n //= e
		d //= e
		if n==msg2[0] and d==msg2[1] # correct sum
			clearCell selected
			clearCell msg
			msg2 = findSum()
		selected = null 
		msg = null
	xdraw()

bredd = (nr,digits) ->
	s = nr.toString()
	'      '.slice(0,digits-s.length) + s

printHelp = ->
	m = 2
	res = ''
	for n in range 3,11
		digits = [0,0,0,2,2,3,3,4,4,5,5][n]
		m *= n / gcd m,n
		res += "n = #{n} ############ #{m}-delar\n"
		for i in range 1,n+1
			s = ''
			for j in range 1,n+1
				if i==j then s += "      ".slice(0,digits) + 'x'
				else s += ' ' + bredd m*i/j, digits
			res += s+"\n"
		res += "\n"
	print res 
