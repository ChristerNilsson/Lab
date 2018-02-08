KEY = '008B'

memory = null
page = null

makeAnswer = ->
	res = ''
	cs = ''
	for line in memory.split "\n"
		cs += line + "\n"
		js = transpile cs
		message = ''
		value = undefined 
		try
			value = eval js
		catch e 
			message = 'ERROR: ' + e.message
		if message=='' and value != undefined and not _.isFunction(value)
			if line!='' and line[0]!='#' then res += JSON.stringify value
		else 
			res += message
		res += "\n"
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
