<script>	 
	import store  from './store.js'
	import {get} from 'svelte/store'
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'
	import TimeMachine from './TimeMachine.svelte'

	const USE_TIME_MACHINE = true

	let states = []

	const ADD = 'ADD'
	const MUL = 'MUL' 
	const DIV = 'DIV'
	const NEW = 'NEW'
	const UNDO = 'UNDO'

	$: done = $store.a == $store.b
	
	const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

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

	const operation = (st,action) => {
		let a = st.a
		let b = st.b
		let hist = st.hist

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
		store.set({a:a, b:b, hist:hist.slice()})
		saveState(action)
		return {a:a, b:b, hist:hist}
	} 

	const op = (action) => {
		resetState()
		store.update(st => operation(st,action) )
	}

	op(NEW)

</script> 
 
<style>
	h1 {
		font-size: 30px;
		text-align: center;
	}
</style>

<h1 class={col2} style='font-size: 60px; color:red;'>{$store.a}</h1>
<h1 class={col2} style='font-size: 60px; color:green;'>{$store.b}</h1>
<Button klass={col3} title='+2'   click = {() => op(ADD)}  disabled = {done} />
<Button klass={col3} title='*2'   click = {() => op(MUL)}  disabled = {done} />
<Button klass={col3} title='/2'   click = {() => op(DIV)}  disabled = {done} />
<Button klass={col2} title='New'  click = {() => op(NEW)}  disabled = {!done} />
<Button klass={col2} title='Undo' click = {() => op(UNDO)} disabled = {$store.hist.length==0} />

{#if USE_TIME_MACHINE}
	<TimeMachine states={states} />
{/if}
