KEY = '008B'

memory = null
page = null

assert = (a, b) ->
	try
		chai.assert.deepEqual a, b
		''
	catch
		'*** ASSERT FAILED ***'

makeAnswer = ->
	answers = []
	res = ''
	cs = ''
	js = ''
	for line in memory.split "\n"
		cs = line.trim() 
		if cs=='' or cs[0]=='#'
			js += transpile 'answers.push ""' + "\n"
		else
			try
				js += transpile 'answers.push ' + cs + "\n"
			catch e
				js += transpile "answers.push 'ERROR: " + e.message + "'\n"
			
	try
		eval js
	catch e 
		return 'ERROR: ' + e.message

	res = ""
	for answer in answers
		if 'function' == typeof answer
			res += 'function defined' + "\n" 
		else if 'object' == typeof answer
			res += JSON.stringify(answer) + "\n" 
		else
			res += answer + "\n"
	res

setup = ->

	memory = fetchData()

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
				storeData memory

	page.addAction 'Hide', -> 
		page.display()

	page.addAction 'Clear', -> 
		memory = ""
		storeAndGoto memory,page

	page.addAction 'Samples', ->
		memory = """
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
2018 == c.getFullYear()
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
		storeAndGoto memory,page

	page.addAction 'Reference', -> window.open "https://www.w3schools.com/jsref/default.asp"

	page.display()
