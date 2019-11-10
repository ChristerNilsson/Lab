<script>
	import range from 'lodash.range'
	import Clock from './Clock.svelte'
	import { onMount } from 'svelte'
	let h=0,m=0,s=0
	let cities = [{name:'New York',offset:-6}, {name:'Bagarmossen',offset:0}, {name:'Tokyo',offset:8}]
	
	setInterval(() => {
		const time = new Date()
		h = time.getHours()
		m = time.getMinutes()
		s = time.getSeconds() + time.getMilliseconds()/1000
		}, 50)
</script>

{#each cities as city}
	<Clock N={cities.length} {city} h={h+city.offset} {m} {s} /> 
{/each}	
