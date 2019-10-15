<script>
	import {createEventDispatcher} from 'svelte'
	const dispatch = createEventDispatcher()

	export let lines

	const save = () => dispatch('changepage',lines)

</script>

<style>
	textarea,button {
		font-size: 30px;
		line-height: 1.2;
	}
</style>

<button on:click={save}>Save</button>
<textarea rows=70 bind:value={lines}></textarea>
