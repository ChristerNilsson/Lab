<script>	 
	import store  from './store.js'
	import {get} from 'svelte/store'
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'
	import TimeMachine from './TimeMachine.svelte'

	console.log('store',store)
	const USE_TIME_MACHINE = true

	let states = []

	const touch = () => {
		states = states
		console.log('touch',states.length)
	}

	// touch()

	// let a = null
	// let b = null
	// let hist = []

	const ADD = 'ADD'
	const MUL = 'MUL' 
	const DIV = 'DIV'
	const NEW = 'NEW'
	const UNDO = 'UNDO'
	
	const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

	const resetState = () => {
		if (USE_TIME_MACHINE && states.length > 0) {
			let state = states[states.length-1]
			console.log('reset',state.store)
			store.set(state.store) //.slice()
		}
	}

	const saveState = (action) => {
		if (USE_TIME_MACHINE) {
			const obj = Object.assign({}, get(store))
			console.log('saveState',obj,states)
			let state = {action:action,store:obj} //.slice()
			states.push(state)
			states = states
			// dispatch('fixstate')
		}
	}

	const operation = (st,action) => {
		resetState()
		console.log('operation',st)
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

	const op = (action) => store.update( st => operation(st,action) )
		
	const fixState = (event) => {
		let st = event.detail.store
		console.log('fixState',st) //.a,event.detail.b,event.detail.hist)
		store.set({a:st.a, b:st.b, hist:st.hist})
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
<Button klass={col3} title='+2'   click = {() => op(ADD)}  disabled = {$store.a==$store.b} />
<Button klass={col3} title='*2'   click = {() => op(MUL)}  disabled = {$store.a==$store.b} />
<Button klass={col3} title='/2'   click = {() => op(DIV)}  disabled = {$store.a==$store.b} />
<Button klass={col2} title='New'  click = {() => op(NEW)}  disabled = {$store.a!=$store.b} />
<Button klass={col2} title='Undo' click = {() => op(UNDO)} disabled = {$store.hist.length==0} /> 

{#if USE_TIME_MACHINE}
	<TimeMachine on:fixstate={fixState} touch={touch} states={states} />  
{/if}
