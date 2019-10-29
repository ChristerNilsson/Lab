<script>
	import {createEventDispatcher} from 'svelte'
	const dispatch = createEventDispatcher()
	export let text
	export let done
</script>
 
<style>
	.done-true {
		color: gray;
		text-decoration: line-through;
	}
	li {
		margin-top: 5px;
	}
</style>
 
<li>
	<input
		type="checkbox"
		checked={done}
		on:change={() => dispatch('toggleDone')}
	/>
	<span class={'done-' + done}>{text}</span>
	<button on:click={() => dispatch('delete')}>Delete</button>
</li>