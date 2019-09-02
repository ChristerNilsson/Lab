transpile = (code) ->	
	result = CoffeeScript.compile code, {bare: true}
	#result = result.replace ';\n\n',';'
	result.replace /\n/g,''
