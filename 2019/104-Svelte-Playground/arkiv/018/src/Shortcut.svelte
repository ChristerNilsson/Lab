<script>
	import {Complex} from './Complex.js'
	export let score
	export let undos
	export let ready
	export let stopp
	export let pair
	
	let a = pair.a
	let b = pair.b

	const origa = a.toString()
	const origb = b.toString()
	let hist = []
	$: done = a.eq(b)
	$: bgcolor = done ? 'green' : 'grey'
	const op = (action) => {
		hist.push(a)
		hist = hist
		if (action=='+1') a = a.add()
		if (action=='*2') a = a.mul()
		if (action=='*i') a = a.rot()
		if (action=='m')  a = a.mirror()
		score += 1
		if (a.eq(b)) ready += 1
		stopp = new Date()
	}
	const undo = () => {
		score -= 1
		undos += 1
		a = hist.pop()
		hist = hist
	}
</script>

<style>
	.w100 {width:200px}
	.fs {font-size:20px}
	.marg {margin: 1px}
	.br {border-radius:5px}
</style>

<div class="w100 fs marg br row left {bgcolor} lighten-1 black-text center-align" >
	{#if done}
		<div>{origa}</div>
		<div>{origb}</div>
		{hist.length} steps
	{:else}
		<div>{a}</div>
		<div>{b}</div>
		<button on:click={() => op('+1')} disabled={done}>+1</button>
		<button on:click={() => op('*2')} disabled={done}>*2</button>
		<button on:click={() => op('*i')} disabled={done}>*i</button>
		<button on:click={() => op('m')}  disabled={done}>m</button>
		<button on:click={undo} disabled={hist.length==0}>Undo</button>
	{/if}
</div>
