<script>

	export let index
	export let cand
	export let N
	export let mm

	$: curr = cand[index]

</script>

<style>
	.fs {font-size:1.5em}
</style>

<div class='col s3 fs left-align' >
	<button on:mousemove={() => mm('prev')} on:click={() => index--} disabled={index==0}>Prev</button>
</div>

<div class='col s6 fs center-align' >
	{#if curr.a==curr.b}
		{curr.orig} to {curr.b}
	{:else}
		<span on:mousemove={() => mm('left')}>{curr.a}</span>
		to 
		<span on:mousemove={() => mm('right')}>{curr.b}</span>
	{/if}
</div>

<div class='col s3 fs right-align' >
	<button on:mousemove={() => mm('next')} on:click={() => index++} disabled={index==N-1}>Next</button>
</div>
