<script>
	import store from './store.js'
	import { col1,col2,col3 } from '../styles.js'
	import {createEventDispatcher} from 'svelte'
	const dispatch = createEventDispatcher()
	export let state
	// console.log('State',state)
	const fixState = () => dispatch('fixstate',state)
</script>

<style>
</style>

<button class=col1 on:click={fixState}>
	{state.action} a:{state.store.a} b:{state.store.b} hist:[{state.store.hist}]
</button>
