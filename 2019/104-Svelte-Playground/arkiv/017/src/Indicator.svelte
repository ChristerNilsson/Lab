<script>
	import range from 'lodash.range'
	export let index
	export let cand
	export let N
	export let mm

</script>

<svg viewBox='-50 -2 100 4' style='width:{100}%; height:{100}%;' >
	{#each range(N) as i}
		<circle on:mousemove={(evt) => mm('circle',i)} on:click={()=>index=i} cx={100/N*(i-N/2+0.5)} cy=0 r=1.5 fill={i==index ? 'white' : (cand[i].a==cand[i].b ? 'green' : 'black')}/>
	{/each}
</svg>