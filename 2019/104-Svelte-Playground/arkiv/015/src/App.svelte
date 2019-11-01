<script>	 
	import testReducer from './testReducer.js'

	const stack = []

	const op = (state,value) => {
		const hist = state.hist.slice()
		hist.push(state.a)
		const a = value
		const b = state.b
		return {a,b,hist}
	}

	const reducers = {
		ADD: (state) => op(state,state.a+2),
		MUL: (state) => op(state,state.a*2),
		DIV: (state) => op(state,state.a/2),
		NEW: (state) => ({b:stack.pop(), a:stack.pop(), hist:[]}),
		UNDO: (state) => {
			const hist = state.hist.slice()
			const a = hist.pop()
			const b = state.b
			return {a,b,hist}
		}
	}

	let script = `
{"a":18,"b":17,"hist":[]}
	ADD STATE {"a":20,"b":17,"hist":[18]}
	MUL STATE {"a":36,"b":17,"hist":[18]}
	DIV STATE {"a":9,"b":17,"hist":[18]}
	17 1 NEW A 17 B 1 HIST []
{"a":17,"b":1,"hist":[]}
	MUL ADD DIV STATE {"a":18,"b":1,"hist":[17,34,36]}
		UNDO STATE {"a":36,"b":1,"hist":[17,34]}
			UNDO STATE {"a":34,"b":1,"hist":[17]}
				UNDO STATE {"a":17,"b":1,"hist":[]}
`

	const reducer = testReducer(script.trim(), reducers, stack) 
	const lines = reducer.run()
	console.log(lines.join('\n'))

</script> 
 

<style>
</style>

