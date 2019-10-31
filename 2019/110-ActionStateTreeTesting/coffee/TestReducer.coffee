assert = chai.assert.deepEqual

testReducer = (script,reducer,stack) ->

	states = []

	run = ->
		for line,nr in script.split '\n'
			runTest line,nr

	runTest = (line,nr) ->
		index = countTabs line
		if index == 0 then return states = [JSON.parse line]
		line = line.trim()
		stack.length = 0
		arr = line.split ' '
		state = states[index-1] 
		for cmd in arr	
			state = rpn cmd,state,nr 
		states[index] = state 
		while stack.length >= 2
			rpn '==',state,nr
		if stack.length == 1 then console.log "Orphan in line #{nr+1}"

	rpn = (cmd,state,nr) ->
		if cmd == 'STATE'
			stack.push state
			return state
		if cmd.toLowerCase() of state 
			stack.push state[cmd.toLowerCase()]
			return state
		if cmd of reducers then return state = reducers[cmd] state
		if cmd == '==' 
			try
				x = stack.pop()
				y = stack.pop()
				assert x, y
			catch
				console.log 'Assert failure in line ' + (nr + 1)
				console.log '  Expect', JSON.stringify x
				console.log '  Actual', JSON.stringify y
			return state
		try
			stack.push JSON.parse cmd
		catch
			console.log 'JSON.parse failure in line ' + (nr + 1)
			console.log '  ',cmd
		return state

	countTabs = (line) ->
		result = 0
		for ch in line
			if ch != '\t' then return result
			result++
		result

	{run}