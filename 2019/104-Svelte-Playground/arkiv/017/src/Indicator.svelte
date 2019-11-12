<script>
	import range from 'lodash.range'
	export let data,index
</script>

<svg viewBox='-50 -2 100 4' style='width:{100}%; height:{100}%;' >
	{#each range(data.N) as i}
		<circle on:mousemove={(evt) => data.mm('circle',i)} on:click={()=>data.click(i)} cx={100/data.N*(i-data.N/2+0.5)} cy=0 r=1.5 fill={i==index ? 'white' : (data.cand[i].a==data.cand[i].b ? 'green' : 'black')}/>
	{/each}
</svg>