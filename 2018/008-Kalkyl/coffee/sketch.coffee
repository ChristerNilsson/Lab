KEY = '008B'

ANGLE_MODE = ['Degrees','Radians']
LANGUAGE = ['Coffeescript','Javascript']
DISPLAY_MODE = ['Fixed','Engineering']

memory = null
page = null

config =
	angleMode : 0
	language : 1
	displayMode : 0
	digits : 3

assert = (a,b,msg='') =>
	chai.assert.deepEqual a,b,msg
	'ok'

findLineNo = (e) =>
	lines = e.stack.split '\n'
	for line in lines
		if 0 <= line.indexOf '<anonymous>'
			return line.split(':')[1] - 1
	0

makeAnswer = -> 
	answers = []
	res = ''
	cs = ''
	js = []
	JS = if config.language == 0 then '' else '`' 

	angleMode [DEGREES,RADIANS][config.angleMode]

	lines = memory.split "\n"
	for line in lines
		pos = line.lastIndexOf if config.language == 0 then '#' else '//'
		if pos >=0 then line = line.slice 0,pos
		cs = line.trim() 
		if cs == ''
			js.push transpile JS + 'answers.push("")'  + JS 
		else
			try
				if cs[cs.length-1]=='=' then cs += 'undefined'
				js.push transpile JS + 'answers.push(' + cs + ")"  + JS 
			catch e
				stack = e.stack.split('\n')
				js.push transpile JS + "answers.push('" + stack[0] + "')"  + JS 

	try
		console.dir js
		eval js.join("\n")
	catch e 
		console.dir e.stack
		lineNo = findLineNo e
		pre = (range(lineNo).map (x) => '\n').join('')
		post = (range(js.length-lineNo).map (x) => '\n').join('')
		lines = e.stack.split('\n')
		return pre + lines[0] + post

	res = ""
	for answer in answers
		if 'function' == typeof answer
			res += 'function defined' + "\n" 
		else if 'object' == typeof answer
			res += JSON.stringify(answer) + "\n" 
		else if 'number' == typeof answer
			if config.displayMode == 0 then res += fixed(answer, config.digits) + "\n"
			if config.displayMode == 1 then res += engineering(answer, config.digits) + "\n"
		else
			res += answer + "\n"
	res 

encode = ->
	s = encodeURI memory
	s = s.replace /=/g,'%3D'
	s = s.replace /\?/g,'%3F'
	s = s.replace /#/g,'%23'
	window.open '?content=' + s + '&config=' + encodeURI JSON.stringify config

decode = ->
	memory = ''
	if '?' in window.location.href
		parameters = getParameters()
		if parameters.content
			memory = decodeURI parameters.content
			memory = memory.replace /%3D/g,'='
			memory = memory.replace /%3F/g,'?'
			memory = memory.replace /%23/g,'#' 
		if parameters.config
			config = JSON.parse decodeURI parameters.config

setup = ->

	# memory = fetchData()
	decode()

	page = new Page 0, ->
		@table.innerHTML = "" 

		enter = makeTextArea()
		enter.style.left = '51%'
		enter.style.width = '48%'
		#enter.style.overflow = 'hidden'

		enter.focus()
		enter.value = memory

		answer = makeTextArea() 
		answer.style.left = '0px'
		answer.setAttribute "readonly", true
		answer.style.textAlign = 'right'
		answer.style.overflow = 'hidden'
		answer.wrap = 'off'

		answer.value = makeAnswer()

		enter.onscroll = (e) ->
			answer.scrollTop = enter.scrollTop
			answer.scrollLeft = enter.scrollLeft
		answer.onscroll = (e) -> e.preventDefault()

		@addRow enter,answer

		enter.addEventListener "keyup", (event) ->
			answer.scrollTop = enter.scrollTop
			answer.scrollLeft = enter.scrollLeft
			
			if event.keyCode not in [33..40]
				memory = enter.value
				answer.value = makeAnswer()
				# storeData memory

	page.addAction 'Clear', -> 
		memory = ""
		storeAndGoto memory,page

	page.addAction 'Samples', ->
		if config.language == 0 
			memory = """
# Coffeescript
2+3

sträcka = 150
tid = 6
tid
sträcka/tid
25 == sträcka/tid 
30 == sträcka/tid

# String
a = "Volvo" 
5 == a.length
'l' == a[2]

# Math
5 == sqrt 25 

# Date
c = new Date() 
c.getFullYear()
c.getHours()

# Array
numbers = [1,2,3] 
2 == numbers[1]
numbers.push 47
4 == numbers.length
numbers 
47 == numbers.pop()
3 == numbers.length
numbers
assert [0,1,4,9,16,25,36,49,64,81], (x*x for x in range 10)

# Object
person = {fnamn:'David', enamn:'Larsson'}
'David' == person['fnamn']
'Larsson' == person.enamn

# functions (enbart one liners tillåtna!)
kvadrat = (x) -> x*x
25 == kvadrat 5

# feluppskattning vid användande av bäring och avstånd
area = (b1,b2,r1,r2) -> (r2*r2 - r1*r1) * Math.PI * (b2-b1)/360  
17.671458676442587 == area 90,91,200,205
35.12475119638588  == area 90,91,400,405
69.81317007977317  == area 90,92,195,205
139.62634015954634 == area 90,92,395,405

serial = (a,b) -> a+b
2 == serial 1,1
5 == serial 2,3

parallel = (a,b) -> a*b/(a+b)
0.5 == parallel 1,1
1.2 == parallel 2,3

fak = (x) -> if x==0 then 1 else x * fak(x-1)
3628800 == fak 10

fib = (x) -> if x<=0 then 1 else fib(x-1) + fib(x-2) 
1 == fib 0
2 == fib 1
5 == fib 3
8 == fib 4
13 == fib 5
21 == fib 6

"""
		else # Javascript
			memory = """ 
// Javascript
2+3

distance = 150
seconds = 6
seconds
distance/seconds
25 == distance/seconds
30 == distance/seconds

// String
a = "Volvo" 
5 == a.length
'l' == a[2]

// Math
5 == sqrt(25)

// Date
c = new Date() 
c.getFullYear()
c.getHours()

// Array
numbers = [1,2,3] 
2 == numbers[1]
numbers.push(47)
4 == numbers.length
numbers 
47 == numbers.pop()
3 == numbers.length
numbers
assert([0,1,4,9,16,25,36,49,64,81], range(10).map(x => x*x))

// Object
person = {fnamn:'David', enamn:'Larsson'}
'David' == person['fnamn']
'Larsson' == person.enamn

// functions (only one liners)
kvadrat = (x) => x*x
25 == kvadrat(5)

serial = (a,b) => a+b
2 == serial(1,1)
5 == serial(2,3)

parallel = (a,b) => a*b/(a+b)
0.5 == parallel(1,1)
1.2 == parallel(2,3)

fak = (x) => (x==0 ? 1 : x * fak(x-1))
3628800 == fak(10)

fib = (x) => x<=0 ? 1 : fib(x-1) + fib(x-2)
1 == fib(0)
2 == fib(1)
5 == fib(3)
8 == fib(4)
13 == fib(5)
21 == fib(6)

"""
		# storeAndGoto memory,page
		encode()

	page.addAction 'Reference', -> window.open "https://www.w3schools.com/jsref/default.asp"

	page.addAction 'Hide', -> 
		page.display()

	page.addAction 'URL', -> 
		encode()

	page.addAction ANGLE_MODE[config.angleMode], -> 
		config.angleMode = 1 - config.angleMode
		page.actions[5][0] = ANGLE_MODE[config.angleMode]
		makeAnswer()
		storeAndGoto memory,page

	page.addAction LANGUAGE[config.language], -> 
		config.language = 1 - config.language
		page.actions[6][0] = LANGUAGE[config.language]
		storeAndGoto memory,page

	page.addAction DISPLAY_MODE[config.displayMode], ->
		config.displayMode = 1 - config.displayMode
		page.actions[7][0] = DISPLAY_MODE[config.displayMode]
		storeAndGoto memory,page

	page.addAction 'Less', -> 
		if config.digits>1 then config.digits--
		storeAndGoto memory,page

	page.addAction 'More', -> 
		if config.digits<17 then config.digits++
		storeAndGoto memory,page

	page.display()
