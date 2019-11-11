<script>
	export let ADD
	export let MUL
	export let DIV
	export let SUB
	export let cand
	export let index
	export let undo
	export let op
	export let mm

	$: a = cand[index].a
	$: b = cand[index].b
	$: done = a==b
	$: hist = cand[index].hist

</script>

<style>
	.fs {font-size:1.5em}
	.marg {margin: 0px}
	.br {border-radius:5px}
</style>

<div class="row">

	{#if done}
		<div class="left col s12 fs marg center-align">{hist.length} steps</div>
	{:else}
		<div class="left col s3 fs marg center-align"></div>
		<div class="left col s6 fs marg center-align">
			{#if (ADD!=0)}
				<button on:mousemove={(evt) => mm('add')} class=br on:click={() => op(a+ADD)} disabled={done}>add {ADD}</button>
			{/if}
			{#if (SUB!=0)}
				<button on:mousemove={(evt) => mm('sub')} class=br on:click={() => op(a-SUB)} disabled={done}>sub {SUB}</button>
			{/if}
			{#if (MUL!=1)}
				<button on:mousemove={(evt) => mm('mul')} class=br on:click={() => op(a*MUL)} disabled={done}>mul {MUL}</button>
			{/if}
			{#if (DIV!=1)}
				<button on:mousemove={(evt) => mm('div')} class=br on:click={() => op(a/DIV)} disabled={done || a%DIV!=0}>div {DIV}</button>
			{/if}
		</div>
		<div class="left col s3 fs marg right-align">
			<button on:mousemove={(evt) => mm('undo')} on:click={undo} disabled={hist.length==0}>Undo</button>
		</div>
	{/if}
</div>
