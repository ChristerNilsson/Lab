KEY = '008B'

memory = {}
page = null

setup = ->

	memory = fetchData()

	page = new Page 0, ->
		@table.innerHTML = "" 
		@addRow enter = makeTextArea 40,10
		enter.focus()
		enter.value = memory
		for line in memory.split "\n"
			arr = line.split '='
			if arr.length == 2
				[key,expr] = arr
				try
					value = eval 'window.'+key+'='+expr
				catch
					value = 'error'
				b = makeSpan key
				@addRow b, makeSpan JSON.stringify value

		enter.addEventListener "keyup", (event) ->
			memory = enter.value
			storeData memory

	page.addAction 'Run', -> storeAndGoto memory,page
	page.addAction 'Clear', -> 
		memory = ''
		storeAndGoto memory,page

	page.display()
