<script>
	import { col1,col2,col3 } from '../styles.js'
	import {createEventDispatcher} from 'svelte'
	const dispatch = createEventDispatcher()
	export let state
	const fixState = () => dispatch('fixstate',state)
</script>

<style>
</style>

<button class=col1 on:click={fixState}>
	{state.action} a:{state.a} b:{state.b} hist:[{state.hist}]
</button>
