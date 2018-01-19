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
			span.appendChild makeButton title, @actions.length, f

		elem.appendChild span

		# init page
		hideCanvas()
		@table.innerHTML = ""
		@init()
				
	addRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr
