<script>	 
	import testReducer from './testReducer.js'

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
{"a":18,"b":17,"hist":[]}
	ADD STATE {"a":20,"b":17,"hist":[18]}
	MUL STATE {"a":36,"b":17,"hist":[18]}
	DIV STATE {"a":9,"b":17,"hist":[18]}
	17 1 NEW A 17 B 1 HIST []
{"a":17,"b":1,"hist":[]}
	MUL ADD DIV STATE {"a":18,"b":1,"hist":[17,34,36]}
		UNDO STATE {"a":36,"b":1,"hist":[17,34]}
			UNDO STATE {"a":34,"b":1,"hist":[17]}
				UNDO STATE {"a":17,"b":1,"hist":[99]}
	MUL ADD DIV ADD DIV ADD DIV ADD DIV DIV DIV A 1
`
	let temp = ''
	
	const editor = CodeMirror(document.body, {
		lineNumbers: true, 
		tabSize:2,
		theme : 'dracula'
	}); 
	editor.setSize(1000,600)
	editor.setValue(script.trim())
	editor.on("change", () => {
		viewer.setValue(reducer.run(editor.getValue()).join('\n'))
	})

	const viewer = CodeMirror(document.body, {
		readOnly:true,
		tabSize:2,
	});
	viewer.setSize(1000,200)

	const reducer = testReducer(reducers, stack) 
	viewer.setValue(reducer.run(editor.getValue()).join('\n'))
	
</script> 

<style>
div {
	float: left; 
	width: 100%;  
}
</style>

<div style='position:absolute; left:1050px; top:10px;'>
	<h2>Action State Tree Testing</h2>
	<div>This is a compact format for making tests</div>
	<div>Each line contains zero or more actions</div>
	<div>Each line contains zero or more tests</div>
	<div>&nbsp;</div>
	<div>Lines are based on less indented lines</div>
	<div>Alternative actions have the same indentation</div>
	<div>Lines with no indentation contains initial states.</div>
	<div>&nbsp;</div>
	<div>JSON is used to describe states</div>
	<div>RPN is used for actions and getters</div>
	<div>&nbsp;</div>

	Actions:
	<ul>
 		<li>ADD : a = a + 2</li>
		<li>MUL : a = a * 2</li>
		<li>DIV : a = a / 2</li>
		<li>NEW</li>
		<li>UNDO</li>
	</ul>
	
	Getters: 
	<ul>
		<li>STATE : The State</li>
		<li>A : The number to be changed</li>
		<li>B : Target number</li>
		<li>HIST : List for Undo</li>
	</ul>
	<div>Assertions are done by taking two items </div>
	<div>from the stack at a time and comparing deeply.</div>
	<div>&nbsp;</div>
	Line 5 contains three assertions:
	<ul>
		<li>A == 17</li>
		<li>B == 1</li>
		<li>HIST == []</li>
	</ul>
	<div>Actions may consume parameters. E.g. NEW</div>
	<div>&nbsp;</div>
	Known quirks:
	<ul>
		<li>Spaces are not allowed in expressions</li>
		<li>Very sensitive to editing</li>
	</ul>
</div>
