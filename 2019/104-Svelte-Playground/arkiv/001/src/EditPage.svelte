<script>
	export let lines
	export let click
</script>

<style>
	textarea,button {
		font-size: 30px;
		line-height: 1.2;
	}
</style>

<button on:click={()=>click(lines)}>Save</button>
<textarea rows=70 bind:value={lines}></textarea>
