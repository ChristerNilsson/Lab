class Calculator
	constructor : -> @stack = []
	p : ->
		x = @stack.pop()
		y = @stack.pop()
		@stack.push x*y/(x+y)
	calc : (opers) ->
		if opers.length==0 then return ""
		for oper in opers.split ' '
			switch oper
				when '+' then @stack.push @stack.pop() + @stack.pop()
				when 'p' then @p()
				when ''
				else @stack.push parseFloat oper
		if @stack.length>0 then @stack.pop() else ""
calculator = new Calculator()

assert 30, calculator.calc '10 20 +'
assert 15, calculator.calc '30 30 p'
assert 16.04364406779661, calculator.calc '10 4.7 + 8.9 p 0.5 + 10 +'
assert 10, calculator.calc '10 2 + 6 p 8 + 6 p 4 + 8 p 4 + 8 p 6 +'

txt = '10 20 + 30 p'

setup = ->
	createCanvas 891,45
	textSize 40

draw = ->
	bg 0.5
	text calculator.calc(txt),10,40

execute = (control) ->
	txt = control.value.trim()
