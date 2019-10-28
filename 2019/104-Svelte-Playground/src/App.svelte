<script>	
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'
	import TimeMachine from './TimeMachine.svelte'

	const USE_TIME_MACHINE = true

	let a = null
	let b = null
	let hist = []

	const ADD = 'ADD'
	const MUL = 'MUL'
	const DIV = 'DIV'
	const NEW = 'NEW'
	const UNDO = 'UNDO'
	let states = []

	const resetState = () => {
		if (USE_TIME_MACHINE && states.length > 0) {
			let state = states[states.length-1]
			a = state.a
			b = state.b
			hist = state.hist.slice()
		}
	}

	const saveState = (action) => {
		if (USE_TIME_MACHINE) {
			let state = {action,a,b,hist:hist.slice()}
			states.push(state)
			states = states
		}
	}

	const op = (action) => {
		resetState()
		if (action == ADD) {
			hist.push(a)
			hist=hist
			a += 2
		} else if (action == MUL) {
			hist.push(a)
			hist=hist
			a *= 2
		} else if (action == DIV) {
			hist.push(a)
			hist=hist
			a /= 2
		} else if (action == NEW) {
			a = random(1,20)
			b = random(1,20)
			hist = []
		} else if (action == UNDO) {
			a = hist.pop()
			hist = hist 
		} else {
			console.log('Missing action: ' + action)
		}
		saveState(action)
	}

	const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

	op(NEW)

	const fixState = (event) => {
		console.log('fixState',event.detail)
		a = event.detail.a
		b = event.detail.b
		hist = event.detail.hist.slice()
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

{#if USE_TIME_MACHINE}
	<TimeMachine on:fixstate = {fixState} states={states} />
{/if}
