<script>
	import Button from './Button.svelte'
	let value = ''
	let values = []
	const showValues = (e) => {
		values.push(value)
		values = values 
	}
</script> 

<div>{value}</div>
<div>{values.join('-')}</div>
<input bind:value={value}/>
<Button click = {showValues } title='Show Values'></Button>
