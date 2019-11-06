<script> 
	import Shortcut from './Shortcut.svelte'
	import Statistics from './Statistics.svelte'
	import range from 'lodash.range'
	import shuffle from 'lodash.shuffle'
	import {solve} from './solve.js' 

	const N = 24

	let score = 0
	let undos = 0
	let ready = 0

	const start = new Date()
	let stopp = new Date()

	let cand = []
	for (const j of range(20)) {
		for (const k of range(20)) {
			if (j != k) cand.push([j+1,k+1])
		}
	}
	cand = shuffle(cand)

	let optimum = 0
	for (const i in range(N)) {
		const pair = cand[i]
		optimum += solve(pair[0], pair[1])
	}

</script>

{#each range(N) as i}
	<Shortcut
	bind:score = {score}
	bind:undos = {undos}
	bind:ready = {ready}
	bind:stopp = {stopp}
	pair = {cand[i]}
	/>
{/each}

<Statistics
	score = {score}
	undos = {undos}
	ready = {ready}
	start = {start}
	stopp = {stopp}
	optimum = {optimum}
/>
