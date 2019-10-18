<script>
	import { col1,col2,col3 } from '../styles.js'
	export let click
	export let disabled
	export let title
	export let klass
	if (window.innerWidth < 600) klass=col1
		
</script>

<style>
	button {
		font-size: 30px;
		/* float: left; */
	}
</style>

<button class={klass} on:click={click} disabled={disabled}>{title}</button>