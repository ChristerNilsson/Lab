# https://github.com/wesbos/JavaScript30/tree/master/15%20-%20LocalStorage

todos = []
page = null

setup = ->
	todos = fetchData()

	page = new Page ->
		@addRow makeInput 'todo'
		for t in todos
			do (t) => 
				@addRow makeButton "#{t.name} #{t.done}", 1, => 
					t.done = not t.done
					storeAndGoto todos,page

	page.addAction 'Add', -> 
		todos.push {name:getElem("todo").value, done:false}
		storeAndGoto todos,page

	page.addAction 'ClearAll', -> 
		todos = []
		storeAndGoto todos,page

	page.addAction 'Clear', -> 
		todos = todos.filter (e) -> not e.done
		storeAndGoto todos,page

	page.addAction 'AllDone', ->
		for t in todos
			t.done = true
		storeAndGoto todos,page

	page.display()
