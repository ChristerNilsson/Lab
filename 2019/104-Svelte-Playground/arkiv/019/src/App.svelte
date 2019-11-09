<script>
	
	const colors = 'red pink purple deep-purple indigo blue light-blue cyan teal green light-green lime yellow amber orange deep-orange brown grey blue-grey black white transparent'.split(' ')
	const palettes = 'lighten-5 lighten-4 lighten-3 lighten-2 lighten-1 darken-1 darken-2 darken-3 darken-4 accent-1 accent-2 accent-3 accent-4'.split(' ')
	
	let color='blue'
	let palette='lighten-1'
	let colorText='yellow-text'
	let textPalette='text-lighten-1'

	$: class1 = `${color} ${colorText}`
	$: class2 = `${color} ${palette} ${colorText} ${textPalette}`
	
	// Makes Materialize handle select
	document.addEventListener('DOMContentLoaded', function() {
		const elems = document.querySelectorAll('select')
		const instances = M.FormSelect.init(elems, {})
	})

	const combinations = colors.length * (palettes.length+1) * colors.length * (palettes.length+1)

</script> 

<style>
	.width {width:200px}
</style>

Materialize: {combinations} color combinations

<div class="row">
	<div class={class1}>{class1}</div>
	<div class={class2}>{class2}</div>
</div>

<div class='row col left'>

	<div class="input-field col s6">
		<select bind:value={color}>
			{#each colors as color}
				<option value={color}>{color}</option>
			{/each}
		</select>
	</div>

	<div class="input-field col s6">
		<select bind:value={palette}>
			{#each palettes as palette}
				<option value={palette}>{palette}</option>
			{/each}
		</select>
	</div>

	<div class="input-field col s6">
		<select bind:value={colorText}>
			{#each colors as color}
				<option value="{color}-text">{color}-text</option>
			{/each}
		</select>
	</div>

	<div class="input-field col s6">
		<select bind:value={textPalette}>
			{#each palettes as palette}
				<option value="text-{palette}">text-{palette}</option>
			{/each}
		</select>
	</div>

</div>

