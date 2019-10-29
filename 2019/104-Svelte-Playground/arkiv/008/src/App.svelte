<script>
	import Chart from './chart.svelte'
	let page = 2
</script>

<Chart hidden = {page!=0}/>

{#if page == 1}
	<div class="row">
		{#each [1,2,3,4,5,6,7,8,9,10,11] as i}
		<div class="col-sm-4" style="background-color:red">
			<h3>Column {i}</h3>
			<p>Lorem ipsum dolor..</p>
		</div>
		{/each}
	</div>
{/if}

{#if page == 2}
	<div class="container-fluid">
		<div class="row">
			{#each [1,2,3,4,5,6,7,8,9,10,11] as i}
			<div class="col-sm-4" style="background-color:red">
				<h3>Column {i}</h3>
				<p>Lorem ipsum dolor..</p>
			</div>
			{/each}
		</div>
	</div>
{/if}

