<script>
	export let pattern
	export let lines 
	export let click
	export let keyup 

	$: showLines = lines.split('\n').filter((line) => line.toLowerCase().includes(pattern))	
</script> 

<style>
	ul,input,button {
		font-size: 30px;
		line-height: 1.2;
	}
</style>

<button on:click={click}>Edit</button>
<input on:keyup={()=>keyup(pattern)} type="text" placeholder='Search' bind:value={pattern}>
<ul>
	{#each showLines as line}
		<li>{line}</li>
	{/each}
</ul>
