todos = []
page = null
todoInput = null

STATES = 'red yellow green'.split ' '

setup = ->
	todos = fetchData()

	page = new Page 0, ->
		@addRow todoInput = makeInput 'todo'
		for t in todos
			do (t) => 
				b = makeButton "#{t.name}", 1, => 
					t.state++
					t.state %= STATES.length
					storeAndGoto todos,page
				b.style.textAlign = 'left'
				b.style.backgroundColor = STATES[t.state]
				@addRow b
		null

	page.addAction 'Add', -> 
		todos.push {name:todoInput.value, state:0}
		storeAndGoto todos,page

	page.addAction 'ClearAll', -> 
		todos = []
		storeAndGoto todos,page

	page.addAction 'ClearDone', -> 
		todos = todos.filter (t) -> t.state < 2
		storeAndGoto todos,page

	page.addAction 'AllDone', ->
		todos.map (t) -> t.state = 2		
		storeAndGoto todos,page

	page.addAction 'NoneDone', ->
		todos.map (t) -> t.state = 0
		storeAndGoto todos,page

	page.display()
