stack = []
page = null
enter = null

goto = (p) -> 
	storeData stack
	p.display()

op0 = (f) ->
	f()
	goto page

op1 = (f) ->
	stack.push f stack.pop()
	goto page

op2 = (f) ->
	x = stack.pop()
	y = stack.pop()
	stack.push f y,x
	goto page

setup = ->
	stack = fetchData()

	page = new Page 10, ->
		for item in stack
			@addRow makeDiv item
		@addRow enter = makeInput {title:'enter'}, => @action 'Enter'
		enter.focus()

	page.addAction 'Enter', -> op0 -> stack.push parseFloat enter.value
	page.addAction '+',   -> op2 (y,x) -> y+x
	page.addAction '-',   -> op2 (y,x) -> y-x
	page.addAction '*',   -> op2 (y,x) -> y*x
	page.addAction '/',   -> op2 (y,x) -> y/x
	page.addAction '%',   -> op2 (y,x) -> y%x
	page.addAction 'clr', -> op0 -> stack = [] 
	page.addAction 'chs', -> op1 (x) -> -x 
	page.addAction '1/x', -> op1 (x) -> 1/x 
	page.addAction 'drp', -> op0 -> stack.pop() 
	page.addAction 'swp', -> op0 ->
		[a,b] = stack.splice -2,2
		stack = stack.concat [b,a] 
	page.addAction 'sin', -> op1 (x) -> sin x 
	page.addAction 'pi', -> op0 -> stack.push PI 

	goto page
