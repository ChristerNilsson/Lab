<script>
	import range from 'lodash.range'
	export let N
	export let city,h,m,s
	console.log(city,h,m,s)
	$: halfday  = (6 <= h && h <= 17) ? 'day' : 'night'
	$: textfill = (6 <= h && h <= 17) ? 'black' : 'white'
</script>

<style>
	svg    { background-color: gray }
	.day   {stroke:black; fill: white}
	.night {stroke:white; fill: black}
	.minor {stroke-width: 1}
	.major {stroke-width: 2}
	
	.hour   {stroke-width: 4}
	.minute {stroke-width: 3}
	.second {stroke: #c00; fill: #c00; stroke-width:1.5}
	.city { font: 8px sans-serif; text-anchor:middle }
	
</style>

<svg viewBox='-50 -50 100 100' style='width:{100/N}%; height:{100/N}%;' >
	<circle class={halfday} r=48 />

	{#each range(0,60,5) as minute}
		<line class='{halfday} major' y1=35 y2=45 transform=rotate({30 * minute}) />
		{#each range(1,5) as offset}
			<line class='{halfday} minor' y1=42 y2=45 transform=rotate({6 * (minute + offset)}) />
		{/each}
	{/each}

	<text style='fill:{textfill}' class=city y=25>{city.name}</text>
	<line class='{halfday} hour'   y1=6 y2=-32 transform = rotate({30 * (h + m / 60)}) />
	<line class='{halfday} minute' y1=6 y2=-45 transform = rotate({6 * m}) />
	<line class=second y1=10 y2=-34 transform = rotate({6 * s}) />
	<g transform = rotate({6 * s})>
		<circle class=second x=0 y=0 r=3 transform = translate(0,-34) />
	</g>
</svg>