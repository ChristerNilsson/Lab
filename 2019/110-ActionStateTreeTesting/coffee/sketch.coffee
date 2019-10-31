mystack = []

reducers = 
	ADD: (state) -> op state, state.a+2
	MUL: (state) -> op state, state.a*2
	DIV: (state) -> op state, state.a/2
	NEW: (state) -> {b:mystack.pop(), a:mystack.pop(), hist:[]}
	UNDO:(state) ->
		[...hist,a] = state.hist
		{...state, a, hist}

op = (state, value) ->
	hist = [...state.hist, state.a]
	a = value
	{...state, a, hist}

script = """
{"a":17,"b":1,"hist":[]}
	A 17 B 1 
	ADD 
		STATE {"a":19,"b":1,"hist":[17]}
		A 19
		B 1
		HIST [17]
		A 19 B 1
		A 19 B 1 HIST [17]
	MUL STATE {"a":34,"b":1,"hist":[17]}
		ADD STATE {"a":36,"b":1,"hist":[17,34]}
			UNDO STATE {"a":34,"b":1,"hist":[17]}
	MUL ADD DIV A 18
		17 1 NEW STATE {"a":17,"b":1,"hist":[]}
{"a":9,"b":8,"hist":[18]}
	A 9 B 8
"""

tester = testReducer script,reducers,mystack
tester.run()

console.log 'Ready!'