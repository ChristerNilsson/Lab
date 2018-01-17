# https://github.com/wesbos/JavaScript30/tree/master/15%20-%20LocalStorage

todos = []
pages = {}

class Page

	constructor : (@init) -> 
		@table = document.getElementById "table"
		@actions = []

	addAction : (title, f) -> @actions.push [title,f] 

	display : ->
		# actions
		elem = document.getElementById 'myActions'
		elem.innerHTML = ""
		span = document.createElement "span"
		for [title,f] in @actions
			do (f) =>
				span.appendChild makeButton title, @actions.length, ->
					f()
					storeData()
					pages.List.display()
		elem.appendChild span

		@table.innerHTML = ""
		@init()
				
	addRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr

storeData = -> localStorage["006"] = JSON.stringify todos
fetchData = -> 
	data = localStorage["006"] 
	if data then todos = JSON.parse data  

setup = ->
	fetchData()

	pages.List = new Page ->
		@addRow makeInput 'todo'
		for todo in todos
			do (todo) => 
				@addRow makeButton "#{todo.name} #{todo.done}", 1, =>
					todo.done = not todo.done
					storeData()
					pages.List.display()

	pages.List.addAction 'Add', -> todos.push {name:document.getElementById("todo").value, done:false}
	pages.List.addAction 'ClearAll', -> todos = []
	pages.List.addAction 'Clear', -> todos = todos.filter (e) -> not e.done

	pages.List.display()
