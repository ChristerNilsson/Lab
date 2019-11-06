<script>
	import Shortcut from './Shortcut.svelte'
	import Statistics from './Statistics.svelte'
	import range from 'lodash.range'
	import shuffle from 'lodash.shuffle'
	const N = 24

	const score = range(N).map(() => 0)
	const undos = range(N).map(() => 0)
	const ready = range(N).map(() => 0)
	const start = new Date()
	let stopp = new Date()

	let cand = []
	for (const j of range(20)) {
		for (const k of range(20)) {
			if (j != k) cand.push([j+1,k+1])
		}
	}
	cand = shuffle(cand)
</script>

{#each range(N) as i}
	<Shortcut
	bind:ready = {ready[i]}
	bind:stopp = {stopp}
	pair = {cand[i]}
	bind:score = {score[i]}
	bind:undos = {undos[i]}/>
{/each}

<Statistics
	ready = {ready.reduce((a,b) => a+b)}
	start = {start}
	stopp = {stopp}
	score = {score.reduce((a,b) => a+b)}
	undos = {undos.reduce((a,b) => a+b)}/>
