<script>
	export let score
	export let undos
	export let ready
	export let stopp
	export let pair
	
	let a = pair[0]
	let b = pair[1]
	
	const orig = `${a} to ${b}`
	let hist = []
	$: done = a==b
	$: bgcolor = done ? 'green' : 'grey'
	const op = (value) => {
		hist.push(a)
		hist=hist
		a = value
		score += 1
		if (a==b) ready+=1
		stopp = new Date()
	}
	const undo = () => {
		score -= 1
		undos += 1
		a=hist.pop()
		hist=hist
	}
</script>

<style>
	.w100 {width:200px}
	.fs {font-size:20px}
	.marg {margin: 1px}
	.br {border-radius:5px}
</style>

<div class="w100 fs marg br row row left {bgcolor} lighten-1 black-text center-align" >
	{#if done}
		<div>{orig}</div>
		{hist.length} steps
	{:else}
		<div>{a} to {b}</div>
		<button on:click={() => op(a+2)} disabled={done}>Add</button>
		<button on:click={() => op(a*2)} disabled={done}>Mul</button>
		<button on:click={() => op(a/2)} disabled={done || a%2==1}>Div</button>
		<button on:click={undo} disabled={hist.length==0}>Undo</button>
	{/if}
</div>
