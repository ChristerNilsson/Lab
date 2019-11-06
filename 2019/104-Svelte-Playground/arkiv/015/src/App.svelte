<script>
import testReducer from './testReducer.js'
import Info from './Info.svelte'

const stack = []

const op = (state,value) => {
	const hist = [...state.hist, state.a]
	return {...state, a:value, hist}
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
{"a":18,"b":17,"hist":[]} # initial state
	@a 18 ==                # assert @a deeply equals 18
	@b 17                   # implicit == assertion
	ADD @a 20               # based on line 1
	MUL @a 36 @hist [18]    # also based on line 1
	DIV @ {"a":9,"b":17,"hist":[18]} # @ is the state
	3 4 NEW @a 3 @b 4 @hist [] # NEW takes two parameters
{"a":17,"b":1,"hist":[]}  # another initial state
	MUL ADD DIV @ {"a":18,"b":1,"hist":[17,34,36]}
		UNDO @ {"a":36,"b":1,"hist":[17,34]} # based on 9
			UNDO @ {"a":34,"b":1,"hist":[17]}  # based on 10
				UNDO @ {"a":17,"b":1,"hist":[]}
	# a solution from 17 to 1 in eleven steps
	MUL ADD DIV ADD DIV ADD DIV ADD DIV DIV DIV @a @b
`
const editor = CodeMirror(document.body, {
	lineNumbers: true,
	tabSize:2,
	indentWithTabs: true,
	theme : 'dracula'
})
editor.setSize(1000,600)
editor.setValue(script.trim())
editor.on("change", () => {
	viewer.setValue(reducer.run(editor.getValue()).join('\n'))
})

const viewer = CodeMirror(document.body, {
	readOnly:true,
	tabSize:2,
})
viewer.setSize(1000,300)

const reducer = testReducer(reducers, stack)
viewer.setValue(reducer.run(editor.getValue()).join('\n'))

</script>

<Info />
