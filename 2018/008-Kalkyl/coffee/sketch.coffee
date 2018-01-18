KEY = '008B'

memory = {}
page = null
enter = null

setup = ->

	memory = fetchData()

	page = new Page 0, ->
		failed = true
		count = 0
		while failed and count<10
			count++
			failed = false
			@table.innerHTML = "" 
			for key,expr of memory
				try
					value = eval 'window.'+key+'='+expr
					do (key,value,expr) =>
						b = makeButton key+'='+expr,0,->
							enter.value = key+'='+expr
						@addRow b, makeSpan value
				catch
					failed=true

		@addRow enter = makeInput 'enter'
		enter.focus()
		do (enter) ->
			enter.addEventListener "keyup", (event) ->
				event.preventDefault()
				if event.keyCode == 13
					[key,expr] = enter.value.split '='
					key = key.trim()
					expr = expr.trim()
					memory[key] = expr
					storeAndGoto memory,page

	page.addAction 'Clear', -> 
		memory = {} 
		storeAndGoto memory,page

	page.display()
