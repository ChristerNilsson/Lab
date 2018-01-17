stack = []
page = null
enter = null
operations = {}

op0 = (f) ->
	f()
	storeAndGoto stack,page

op1 = (f) ->
	stack.push f stack.pop()
	storeAndGoto stack,page

op2 = (f) ->
	x = stack.pop()
	y = stack.pop()
	stack.push f y,x
	storeAndGoto stack,page

setup = ->
	stack = fetchData()

	page = new Page 10, ->
		for item in stack
			@addRow makeDiv item
		@addRow enter = makeInput 'enter'
		#do (enter) ->
		enter.focus()
		enter.addEventListener "keyup", (event) ->
			#event.preventDefault()
			if event.keyCode == 13
				stack.push parseFloat enter.value
				storeAndGoto stack,page

	page.addAction 'Enter', -> op0 -> stack.push parseFloat enter.value
	page.addAction '+',   -> op2 (y,x) -> y+x
	page.addAction '-',   -> op2 (y,x) -> y-x
	page.addAction '*',   -> op2 (y,x) -> y*x
	page.addAction '/',   -> op2 (y,x) -> y/x
	page.addAction '%',   -> op2 (y,x) -> y%x
	page.addAction 'clr', -> op0 -> stack = [] 
	page.addAction 'chs', -> op1 (x) -> -x 
	page.addAction 'drp', -> op0 -> stack.pop() 
	page.addAction 'swp', -> op0 -> 
		x=stack.pop() 
		y=stack.pop()
		stack.push x
		stack.push y
	page.addAction 'sin', -> op1 (x) -> Math.sin x 
	page.addAction 'pi', -> op0 -> stack.push Math.PI 

	page.display()
