<script>
	export let click
	export let disabled
	export let title
</script>

<style>
	button {
		font-size: 30px;
		font-family: 'Courier New', Courier, monospace;
	}
</style>

<button on:click={click} disabled={disabled}>{title}</button>