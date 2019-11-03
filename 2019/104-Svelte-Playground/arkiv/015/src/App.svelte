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
				UNDO @ {"a":17,"b":1,"hist":[99]}
	# a solution from 17 to 1 in eleven steps
	MUL ADD DIV ADD DIV ADD DIV ADD DIV DIV DIV @a @b
`
const editor = CodeMirror(document.body, {
	lineNumbers: true, 
	tabSize:2,
	indentWithTabs: true,
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
viewer.setSize(1000,400)

const reducer = testReducer(reducers, stack) 
viewer.setValue(reducer.run(editor.getValue()).join('\n'))

</script> 

<style>
div {
	float: left; 
	width: 100%;  
}
li {
	font-family: monospace
}
</style>

<div style='position:absolute; left:1050px; top:10px; width:40%'>
	<h2>Reducer Based Testing</h2>
	<div>This is a compact format for testing <a href='https://redux.js.org/basics/reducers'>Reducers</a> and an alternative to:</div>
	<div>&nbsp;</div>
	<ul>
		<li>test('adds 1 + 2 to equal 3', () => {'{'}</li>
  	<li>&nbsp;&nbsp;expect(sum(1, 2)).toBe(3);</li>
		<li>{'}'});</li>
	</ul>
	<div>&nbsp;</div>
	<div>Reducer: State + Action => State</div>
	<div>&nbsp;</div>
	<div>Each line contains zero or more actions</div>
	<div>Each line contains zero or more <a href='https://en.wikipedia.org/wiki/Assertion_(software_development)'>assertions</a></div>
	<div>&nbsp;</div>
	<div>Lines with no indentation contains initial states</div>
	<div>Indented lines are based on previous states</div>
	<div>Alternative actions have the same indentation</div>
	<div>&nbsp;</div>
	<div><a href='https://en.wikipedia.org/wiki/JSON'>JSON</a> is used to describe states</div>
	<div><a href='https://en.wikipedia.org/wiki/Reverse_Polish_notation'>RPN</a> is used for actions and getters</div>
	<div>&nbsp;</div>
	<div>Implicit assertion uses ==</div>
	<div>== deeply compares top two stack elements</div>
	<div>Implicit assertions repeats until the stack is empty</div>
	<div>Alternative assertions might be defined</div>
	<div>Actions may consume parameters</div>
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
		<li>@ : The State</li>
		<li>@a : The number to be changed</li>
		<li>@b : Target number</li>
		<li>@hist : List for Undo</li>
	</ul>
	<div>&nbsp;</div>
	Known bugs:
	<ul>
		<li>Spaces are not allowed in expressions</li>
		<li>Tabs must be used for indentation</li>
	</ul>
</div>

<div style='position:absolute; left:10px; top:1015px; width:80%'>
	<div>Chess example (<a href='https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation'>Forsyth–Edwards Notation</a>)</div>
	<ul>
		<li>{'{'}{'"board"'}:{'"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"'}{'}'}</li>
		<li>&nbsp;&nbsp;e2e4 MOVE @board rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR</li>
		<li>&nbsp;&nbsp;&nbsp;&nbsp;e7e5 MOVE @board rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR</li>
	</ul>
</div>

