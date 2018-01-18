KEY = '008B'

memory = {}
page = null

transpile = (line) ->
	p = line.indexOf '('
	q = line.indexOf '='
	if p>=0 and p<q 
		name = line.slice 0,p
		parameters = line.slice p,q
		body = line.slice q+1
		return "#{name} = function #{parameters} {return #{body}}"
	line

makeAnswer = ->
	res = ''
	for line in memory.split "\n"
		line = transpile line
		message = ''
		value = undefined 
		try
			try
				value = eval 'window.'+line
			catch
				value = eval line
		catch e 
			message = 'ERROR: ' + e.message
		if message=='' and value != undefined and not _.isFunction(value) then res += JSON.stringify value
		else res += message
		res += "\n"
	res

setup = ->

	memory = fetchData()

	page = new Page 0, ->
		@table.innerHTML = "" 

		enter = makeTextArea 40,100
		enter.focus()
		enter.value = memory

		answer = makeTextArea 40,100
		answer.setAttribute "readonly", true
		answer.value = makeAnswer()

		@addRow enter,answer

		enter.addEventListener "keyup", (event) ->
			memory = enter.value
			answer.value = makeAnswer()
			storeData memory

	page.display()
