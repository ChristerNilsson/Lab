<script>	
	import store from './store.js'
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'
	//import TimeMachine from './TimeMachine.svelte'

	// const USE_TIME_MACHINE = false

	// let a = null
	// let b = null
	// let hist = []

	const ADD = 'ADD'
	const MUL = 'MUL'
	const DIV = 'DIV'
	const NEW = 'NEW'
	const UNDO = 'UNDO'
	
	// let states = []

	// const resetState = () => {
	// 	if (USE_TIME_MACHINE && states.length > 0) {
	// 		let state = states[states.length-1]
	// 		a = state.a
	// 		b = state.b
	// 		hist = state.hist.slice()
	// 	}
	// }

	// const saveState = (action) => {
	// 	if (USE_TIME_MACHINE) {
	// 		let state = {action,a,b,hist:hist.slice()}
	// 		states.push(state)
	// 		states = states
	// 	}
	// }

	store.op(NEW)
	
	console.log(store)

	// const fixState = (event) => {
	// 	console.log('fixState',event.detail)
	// 	a = event.detail.a
	// 	b = event.detail.b
	// 	hist = event.detail.hist.slice()
	// }

</script> 
 
<style>
	h1 {
		font-size: 30px;
		text-align: center;
	}
</style>

<h1 class={col2} style='font-size: 60px; color:red;'>{$store.a}</h1>
<h1 class={col2} style='font-size: 60px; color:green;'>{$store.b}</h1>
<Button klass={col3} title='+2'   click = {() => store.op(ADD)}  disabled = {$store.a==$store.b} />
<Button klass={col3} title='*2'   click = {() => store.op(MUL)}  disabled = {$store.a==$store.b} />
<Button klass={col3} title='/2'   click = {() => store.op(DIV)}  disabled = {$store.a==$store.b} />
<Button klass={col2} title='New'  click = {() => store.op(NEW)}  disabled = {$store.a!=$store.b} />
<Button klass={col2} title='Undo' click = {() => store.op(UNDO)} disabled = {$store.hist.length==0} /> 

<!-- {#if USE_TIME_MACHINE}
	<TimeMachine on:fixstate = {fixState} states={states} />
{/if} -->
