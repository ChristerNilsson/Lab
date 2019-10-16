<script>
	import {createEventDispatcher} from 'svelte'
	const dispatch = createEventDispatcher()

	export let name
	export let points
	let showControls = false
	const deletePlayer = () => dispatch('deleteplayer',name)

</script>

<style>
	h1 {
		color: purple
	}
</style>

<div class="card">
	<h1>
		{name}
		<button class="btn btn-sm" on:click={()=>showControls=!showControls}>
			{#if showControls}-{:else}+{/if}
		</button>
		<button on:click={deletePlayer}>x</button>
	</h1>
	<h3>Points: {points}</h3>
	{#if showControls}
		<button class="btn" on:click={()=>points+=1}>+1</button>
		<button class="btn" on:click={()=>points-=1}>-1</button>
		<input type="number" bind:value={points}>
	{/if}
</div>
