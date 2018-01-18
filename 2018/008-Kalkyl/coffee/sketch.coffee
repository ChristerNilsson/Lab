KEY = '008B'

memory = null
page = null

transpile = (line) ->
	p = line.indexOf '('
	q = line.indexOf '='
	if p>=0 and p<q 
		name = line.slice 0,p
		parameters = line.slice p,q
		body = line.slice q+1
		return "#{name} = function #{parameters} {return #{body}}"
	line

makeAnswer = ->
	res = ''
	for line in memory.split "\n"
		line = transpile line
		message = ''
		value = undefined 
		try
			try
				value = eval 'window.'+line
			catch
				value = eval line
		catch e 
			message = 'ERROR: ' + e.message
		if message=='' and value != undefined and not _.isFunction(value) then res += JSON.stringify value
		else res += message
		res += "\n"
	res

setup = ->

	memory = fetchData()

	page = new Page 0, ->
		@table.innerHTML = "" 

		enter = makeTextArea 40,100
		enter.focus()
		enter.value = memory

		answer = makeTextArea 40,100
		answer.setAttribute "readonly", true
		answer.value = makeAnswer()

		@addRow enter,answer

		enter.addEventListener "keyup", (event) ->
			memory = enter.value
			answer.value = makeAnswer()
			storeData memory

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

// String
a = "Volvo" 
5 == a.length
'l' == a[2]

// Math
5 == sqrt(25) 

// Date
c = new Date() 
2018 == c.getFullYear()

// Array
numbers = [1,2,3] 
2 == numbers[1]

// Object
person = {fnamn:'David', enamn:'Larsson'}
'David' == person['fnamn']
'Larsson' == person.enamn

// functions
kvadrat(x)=x*x
25 == kvadrat(5)

serial(a,b) = a+b
2 == serial(1,1)
5 == serial(2,3)

parallel(a,b) = a*b/(a+b)
0.5 == parallel(1,1)
1.2 == parallel(2,3)

fak(x) = x==0 ? 1 : x * fak(x-1)
3628800 == fak(10)

fib(x) = x<=0 ? 1 : fib(x-1)+fib(x-2) 
1 == fib(0)
2 == fib(1)
5 == fib(3)
8 == fib(4)
13 == fib(5)
21 == fib(6)
"""
		storeAndGoto memory,page

	page.addAction 'Reference', -> window.open "https://www.w3schools.com/jsref/default.asp"

	page.display()
