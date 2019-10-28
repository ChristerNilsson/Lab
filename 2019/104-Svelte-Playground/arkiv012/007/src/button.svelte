<style>
	* {box-sizing: border-box}
	button {margin: 5px}
</style>

<script>
	export let nr
	export let page
	export let title
	$: selected = page==nr ? '' : 'btn-primary'
</script>

<button class='btn {selected}' style="width:100%" on:click={() => {page=nr}}>{title}</button>
