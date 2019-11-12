<script>
	export let data,curr
	$: done = curr.a == curr.b
</script>

<style>
	.fs {font-size:1.5em}
	.marg {margin: 0px}
	.br {border-radius:5px}
</style>

<div class="row">

	{#if done}
		<div class="left col s12 fs marg center-align">{curr.hist.length} steps</div>
	{:else}
		<div class="left col s3 fs marg center-align"></div>
		<div class="left col s6 fs marg center-align">
			{#if (data.ADD!=0)}
				<button on:mousemove={(evt) => data.mm('add')} class=br on:click={() => data.op(curr.a+data.ADD)} disabled={done}>add {data.ADD}</button>
			{/if}
			{#if (data.SUB!=0)}
				<button on:mousemove={(evt) => data.mm('sub')} class=br on:click={() => data.op(curr.a-data.SUB)} disabled={done}>sub {data.SUB}</button>
			{/if}
			{#if (data.MUL!=1)}
				<button on:mousemove={(evt) => data.mm('mul')} class=br on:click={() => data.op(curr.a*data.MUL)} disabled={done}>mul {data.MUL}</button>
			{/if}
			{#if (data.DIV!=1)}
				<button on:mousemove={(evt) => data.mm('div')} class=br on:click={() => data.op(curr.a/data.DIV)} disabled={done || curr.a % data.DIV != 0}>div {data.DIV}</button>
			{/if}
		</div>
		<div class="left col s3 fs marg right-align">
			<button on:mousemove={(evt) => data.mm('undo')} on:click={data.undo} disabled={curr.hist.length==0}>Undo</button>
		</div>
	{/if}
</div>
