<script> 
	import {Complex} from './Complex.js'
	import Shortcut from './Shortcut.svelte'
	import Statistics from './Statistics.svelte'
	import Info from './Info.svelte'
	import range from 'lodash.range'
	import shuffle from 'lodash.shuffle'
	import sample from 'lodash.sample'

	const N = 24

	let score = 0
	let undos = 0
	let ready = 0

	const start = new Date()
	let stopp = new Date()

	let optimum = 0
	let cands = []

	const random = (a,b) => {
		const value = Math.floor(a+(b-a+1)*Math.random())
		if (value==-0) return 0 
		return value
	}

	const createCandidates = (n) => {
		const re = random(-5,5)
		const im = random(-5,5)
		const a = new Complex(re,im)
		let cands0 = [a]
		const visited = {}
		const memory = {}
		visited[a.toString()] = 0
		memory[a.toString()] = a

		for (const level of range(n)) {
			const cands1 = [] 
			const op = (a) => {
				if (Math.abs(a.re) <= 10 && Math.abs(a.im) <= 10) {
					const key = a.toString()
					if (!(key in visited)) {
						cands1.push(a)
						visited[key] = level
						memory[key] = a
					}
				}
			}
			for (const cand of cands0) {
				op(cand.add())
				op(cand.mul())
				op(cand.rot())
				op(cand.mirror())
			}
			cands0 = cands1
		}
		if (cands0.length > 0) {
			const target = sample(cands0)
			const key = target.toString()
			optimum += visited[key]
			return {a:a, b:target}
		} else {
			const key = sample(Object.keys(visited))
			optimum += visited[key]
			return {a:a, b:memory[key]}
		}
	}

	let candidates = []
	for (const i in range(6)) {
		for (const j in range(4)) {
			candidates.push(createCandidates(i+1))
		}
	}
	candidates = shuffle(candidates)

</script>

{#each range(N) as i}
	<Shortcut
	bind:score = {score}
	bind:undos = {undos}
	bind:ready = {ready}
	bind:stopp = {stopp}
	pair = {candidates[i]}
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

<Info/>