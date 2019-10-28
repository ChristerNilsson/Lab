<script>	
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'
	import TimeMachine from './TimeMachine.svelte'

	let a = null
	let b = null
	let hist = []

	const ADD = 'ADD'
	const MUL = 'MUL'
	const DIV = 'DIV'
	const NEW = 'NEW'
	const UNDO = 'UNDO'
	const states = []

	const op = (action) => {
		if (states.length > 0) {
			let state = states[states.length-1]
			a = state.a
			b = state.b
			hist = state.hist.slice()

		}
		if (action == ADD) {
			hist.push(a)
			hist=hist
			a += 2
		}
		if (action == MUL) {
			hist.push(a)
			hist=hist
			a *= 2
		}
		if (action == DIV) {
			hist.push(a)
			hist=hist
			a /= 2
		}
		if (action == NEW) {
			a = random(1,20)
			b = random(1,20)
			hist = []
		}
		if (action == UNDO) {
			a = hist.pop()
			hist = hist 
		}
		let state = {action:action,a:a,b:b,hist:hist.slice()}
		states.push(state)
		states = states
	}

	const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

	op(NEW)

	const fixState = (event) => {
		console.log('fixState',event.detail)
		a = event.detail.a
		b = event.detail.b
		hist = event.detail.hist
	}

</script> 
 
<style>
	h1 {
		font-size: 30px;
		text-align: center;
	}
</style>

<h1 class={col2} style='font-size: 60px; color:red;'>{a}</h1>
<h1 class={col2} style='font-size: 60px; color:green;'>{b}</h1>
<Button klass={col3} title='+2'   click = {() => op(ADD)}  disabled = {a==b} />
<Button klass={col3} title='*2'   click = {() => op(MUL)}  disabled = {a==b} />
<Button klass={col3} title='/2'   click = {() => op(DIV)}  disabled = {a==b} />
<Button klass={col2} title='New'  click = {() => op(NEW)}  disabled = {a!=b} />
<Button klass={col2} title='Undo' click = {() => op(UNDO)} disabled = {hist.length==0} /> 

<TimeMachine on:fixstate = {fixState} states={states} />
