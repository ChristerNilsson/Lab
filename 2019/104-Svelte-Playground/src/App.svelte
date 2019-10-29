<script>	 
	import store  from './store.js'
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'
	import TimeMachine from './TimeMachine.svelte'

	const USE_TIME_MACHINE = false

	let states = []

	const ADD = 'ADD'
	const MUL = 'MUL' 
	const DIV = 'DIV'
	const NEW = 'NEW'
	const UNDO = 'UNDO'

	$: done = $store.a == $store.b
	
	const resetState = () => {
		if (USE_TIME_MACHINE && states.length > 0) {
			let state = states[states.length-1]
			let st = state.store
			store.set({a:st.a, b:st.b, hist:st.hist.slice()}) 
		}
	}

	const saveState = (action) => {
		if (USE_TIME_MACHINE) {
			states.push({action:action,store:$store})
			states = states
		}
	}

	const operation = (action) => {
		resetState()
		let a = $store.a
		let b = $store.b
		let hist = $store.hist

		if (action == ADD) {
			hist.push(a)
			a += 2
		} else if (action == MUL) {
			hist.push(a)
			a *= 2
		} else if (action == DIV) {
			hist.push(a)
			a /= 2
		} else if (action == NEW) {
			const random = (a,b) => a+Math.floor((b-a+1)*Math.random())
			a = random(1,20)
			b = random(1,20)
			hist = []
		} else if (action == UNDO) {
			a = hist.pop()
		} else {
			console.log('Missing action: ' + action)
		}
		store.set({a:a, b:b, hist:hist.slice()})
		saveState(action)
	} 

	operation(NEW)

</script> 
 
<style>
	h1 {
		font-size: 30px;
		text-align: center;
	}
</style>

<h1 class={col2} style='font-size: 60px; color:red;'>{$store.a}</h1>
<h1 class={col2} style='font-size: 60px; color:green;'>{$store.b}</h1>
<Button klass={col3} title='+2'   click = {() => operation(ADD)}  disabled = {done} />
<Button klass={col3} title='*2'   click = {() => operation(MUL)}  disabled = {done} />
<Button klass={col3} title='/2'   click = {() => operation(DIV)}  disabled = {done} />
<Button klass={col2} title='New'  click = {() => operation(NEW)}  disabled = {!done} />
<Button klass={col2} title='Undo' click = {() => operation(UNDO)} disabled = {$store.hist.length==0} />
<hr/>
{#if USE_TIME_MACHINE}
	<TimeMachine states={states} />
{/if}
