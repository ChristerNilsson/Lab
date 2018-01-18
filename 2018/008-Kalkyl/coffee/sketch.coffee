KEY = '008B'

memory = {}
page = null

setup = ->

	memory = fetchData()

	page = new Page 0, ->
		@table.innerHTML = "" 
		for line in memory.split "\n"
			arr = line.split '='
			if arr.length == 2
				[key,expr] = arr
				do (key,expr) =>
					b = makeSpan key+'='+expr
					try
						value = eval 'window.'+key+'='+expr
					catch
						value = 'error'
					@addRow b, makeSpan JSON.stringify value
		@addRow enter = makeTextArea 40,5
		enter.focus()
		enter.value = memory

		enter.addEventListener "keyup", (event) ->
			memory = enter.value
			storeData memory

	page.addAction 'Run', -> storeAndGoto memory,page
	page.addAction 'Clear', -> 
		memory = ''
		storeAndGoto memory,page

	page.display()
