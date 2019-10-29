<script>
	import store  from './store.js'
	import State from './State.svelte'
	export let states
	export let touch
</script>

<!-- <button on:click={touch}>Time Machine</button> -->
<div>
	{#each states as state}
		<State on:fixstate state={state}/>
	{/each}
</div>
