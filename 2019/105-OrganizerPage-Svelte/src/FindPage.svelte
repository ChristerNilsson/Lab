<script>
	import {createEventDispatcher} from 'svelte'
	const dispatch = createEventDispatcher()

	export let pattern
	export let lines 

	$: showLines = lines.split('\n').filter((line) => line.toLowerCase().includes(pattern))	

	const edit = () => dispatch('changepage',lines)
</script> 

<style>
	ul,input,button {
		font-size: 30px;
		line-height: 1.2;
	}
</style>

<button on:click={edit}>Edit</button>
<input type="text" placeholder='Search' bind:value={pattern}>
<ul>
	{#each showLines as line}
		<li>{line}</li>
	{/each}
</ul>
