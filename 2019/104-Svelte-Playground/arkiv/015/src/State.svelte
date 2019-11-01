<script>
	import store from './store.js'
	import { col1 } from '../styles.js'
	export let state	
</script>

<style>
	button {text-align:left}
</style>

<button class=col1 on:click={() => store.set(state.store)}>
	{state.action} a:{state.store.a} b:{state.store.b} hist:[{state.store.hist}]
</button>
