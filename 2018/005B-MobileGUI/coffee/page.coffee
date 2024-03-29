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
		span.style.width = '100%'
		for [title,f] in @actions
			span.appendChild b = makeButton title, @actions.length, f
			b.style.fontSize = '90%'
			b.style.color = "yellow"
			b.style.backgroundColor = "black"
		elem.appendChild span

		# init page
		hideCanvas()
		@table.innerHTML = ""
		@init()
				
	addRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr
