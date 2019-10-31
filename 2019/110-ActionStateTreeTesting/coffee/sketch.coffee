assert = chai.assert.deepEqual

stack = []
states = []

script = """
0 17 1 INIT A 17 B 1
	1 ADD STATE {"a":19,"b":1,"hist":[17]}
	1 ADD A 19
	1 ADD B 1
	1 ADD HIST [17] 
	1 ADD A 19 B 1
	1 ADD A 19 B 1 HIST [17]
	1 MUL STATE {"a":34,"b":1,"hist":[17]}
		2 ADD STATE {"a":36,"b":1,"hist":[17,34]}
			3 UNDO STATE {"a":34,"b":1,"hist":[17]}
	1 MUL ADD DIV A 18
		2 17 1 INIT STATE {"a":17,"b":1,"hist":[]}
"""

class Shortcut
	constructor: () -> @state = {a:17,b:1,hist:[]}
	init : (b,a) ->
		hist = []
		@state = {a,b,hist}
	op : (value) ->
		@state.hist.push @state.a
		@state.a = value
	add: -> @op @state.a + 2
	mul: -> @op @state.a * 2
	div: -> @op @state.a / 2
	undo: -> @state.a = @state.hist.pop()

rpn = (cmd,nr) ->
	state = shortcut.state
	if cmd == 'INIT'  then return shortcut.init(stack.pop(),stack.pop())
	if cmd == 'STATE' then return stack.push state
	if cmd == 'A'     then return stack.push state.a
	if cmd == 'B'     then return stack.push state.b
	if cmd == 'HIST'  then return stack.push state.hist
	if cmd == 'ADD'   then return shortcut.add()
	if cmd == 'MUL'   then return shortcut.mul()
	if cmd == 'DIV'   then return shortcut.div()
	if cmd == 'UNDO'  then return shortcut.undo()
	if cmd == '==' 
		try
			x = stack.pop()
			y = stack.pop()
			assert x, y
		catch
			console.log 'Assert failure in line ' + (nr + 1)
			console.log '  Expect', JSON.stringify x
			console.log '  Actual', JSON.stringify y
		return 
	try
		stack.push JSON.parse cmd
	catch
		console.log 'JSON.parse failure in line ' + (nr + 1)
		console.log '  ',cmd

shortcut = new Shortcut()

runAllTests = (script) ->
	for line,nr in script.split '\n'
		runTest line.trim(),nr+1

runTest = (line,nr) ->
	stack = []
	[index, ...arr] = line.split ' '
	index = parseInt index
	if index == 0 
		shortcut.init()
	else 
		shortcut.state = JSON.parse states[index-1]
	for cmd in arr	
		rpn cmd,nr 
	states[index] = JSON.stringify(shortcut.state)
	while stack.length >= 2
		rpn '==',nr
	if stack.length==1 then console.log "Orphan in line #{nr+1}"

runAllTests script

console.log 'Ready!'