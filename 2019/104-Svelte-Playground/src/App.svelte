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
	const action = (type) => {
		if (type == ADD) {
			hist.push(a)
			hist=hist
			a += 2
		}
		if (type == MUL) {
			hist.push(a)
			hist=hist
			a *= 2
		}
		if (type == DIV) {
			hist.push(a)
			hist=hist
			a /= 2
		}
		if (type == NEW) {
			a = random(1,20)
			b = random(1,20)
			hist = []
		}
		if (type == UNDO) {
			a = hist.pop()
			hist = hist 
		}
		let state = {a:a,b:b,hist:hist.slice()}
		states.push({type, state})
		states = states
	}

	const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

	action(NEW)

	const fixState = (event) => {
		a = event.detail.state.state.a
		b = event.detail.state.state.b
		hist = event.detail.state.state.hist
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
<Button klass={col3} title='+2'   click = {() => action(ADD)}  disabled = {a==b} />
<Button klass={col3} title='*2'   click = {() => action(MUL)}  disabled = {a==b} />
<Button klass={col3} title='/2'   click = {() => action(DIV)}  disabled = {a==b} />
<Button klass={col2} title='New'  click = {() => action(NEW)}  disabled = {a!=b} />
<Button klass={col2} title='Undo' click = {() => action(UNDO)} disabled = {hist.length==0} /> 

<TimeMachine on:fixstate = {fixState} states={states} />
