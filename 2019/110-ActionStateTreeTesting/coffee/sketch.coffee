assert = chai.assert.deepEqual

stack = []
states = []

script = """
{"a":17,"b":1,"hist":[]}
0 A 17 B 1
0 ADD 
	1 STATE {"a":19,"b":1,"hist":[17]}
	1 A 19
	1 B 1
	1 HIST [17] 
	1 A 19 B 1
	1 A 19 B 1 HIST [17]
0 MUL STATE {"a":34,"b":1,"hist":[17]}
	1 ADD STATE {"a":36,"b":1,"hist":[17,34]}
		2 UNDO STATE {"a":34,"b":1,"hist":[17]}
0 MUL ADD DIV A 18
	1 17 1 NEW STATE {"a":17,"b":1,"hist":[]}
"""

op = (state, value) ->
	hist = [...state.hist, state.a]
	a = value
	{...state, a, hist}

reducers = 
	ADD: (state) -> op state, state.a+2
	MUL: (state) -> op state, state.a*2
	DIV: (state) -> op state, state.a/2
	NEW: (state) -> {b:stack.pop(), a:stack.pop(), hist:[]}
	UNDO:(state) ->
		[...hist,a] = state.hist
		{...state, a, hist}	

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

runAllTests = (script) ->
	for line,nr in script.split '\n'
		if nr == 0 then states = [JSON.parse line]
		else runTest line.trim(),nr

runTest = (line,nr) ->
	stack = []
	[index, ...arr] = line.split ' '
	index = parseInt index
	state = states[index] 
	for cmd in arr	
		state = rpn cmd,state,nr 
	states[index+1] = state 
	while stack.length >= 2
		rpn '==',state,nr
	if stack.length == 1 then console.log "Orphan in line #{nr+1}"

runAllTests script

console.log 'Readyz!'