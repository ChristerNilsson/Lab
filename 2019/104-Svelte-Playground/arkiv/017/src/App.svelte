<script> 
	import Shortcut from './Shortcut.svelte'
	import range from 'lodash.range'
	import random from 'lodash.random'
	import sample from 'lodash.sample'
	import shuffle from 'lodash.shuffle'
	import {solve} from './solve.js' 

	const M = 3 // MAX Level
	const N = 24

	let score = 0
	let undos = 0
	let index = 0

	const start = new Date()
	let stopp = new Date()

	let optimum = 0 

	const createCandidates = (n) => {
		const a = random(1,20)

		let cands0 = [a]
		const visited = {}
		const memory = {}
		visited[a.toString()] = 0
		memory[a.toString()] = a

		for (const lvl of range(n)) {
			const cands1 = [] 
			const op = (p) => {
				if (p <= 40) {
					const key = p.toString()
					if (!(key in memory)) {
						cands1.push(p)
						visited[key] = lvl+1
						memory[key] = p
					}
				}
			}
			for (const cand of cands0) {
				op(cand + 2)
				op(cand * 2)
				if (cand%2==0) op(cand / 2)
			}
			cands0 = cands1
		}
		if (cands0.length > 0) {
			const target = sample(cands0)
			const key = target.toString()
			optimum += visited[key]
			return {a:a, b:target, hist:[], orig:a}
		} else {
			const key = sample(Object.keys(visited))
			optimum += visited[key]
			return {a:a, b:memory[key], hist:[], orig:a}
		}
	}

	let candidates = []
	for (const level of range(M)) {
		for (const j of range(24/M)) {
			candidates.push(createCandidates(level+1))
		}
	}
	let cand = shuffle(candidates)

	$: a = cand[index].a
	$: b = cand[index].b
	$: hist = cand[index].hist

	const op = (value) => {
		hist.push(a)
		index=index
		hist=hist
		cand=cand
		cand[index].a = value
		score++
		stopp = new Date()
	}
	const undo = () => {
		score--
		undos++
		cand[index].a=hist.pop()
		hist=hist
	}

	const handleKeyDown = (event) => {
		event.preventDefault()
		if (event.key=='ArrowLeft' && index > 0) index--
		if (event.key=='ArrowRight' && index < 23) index++
		if (event.key==' ') index = (index+1) % 24
		if (event.key=='Home') index=0
		if (event.key=='End') index=23
		if (event.key=='a' && a!=b) op(a+2)
		if (event.key=='s' && a!=b) op(a*2)
		if (event.key=='d' && a!=b && a%2==0) op(a/2)
		if (event.key=='z' && hist.length > 0) undo()
		if (event.key=='?') alert(" a = +2\n s = *2\n d = /2\n z = undo\n space = next\n left = prev\n right = next\n home = #0\n end = #23")
	}

</script>

<svelte:window on:keydown={handleKeyDown} />

<div style="width:90%; margin:auto">
	<Shortcut
	bind:index = {index}
	bind:score = {score}
	bind:undos = {undos}
	bind:stopp = {stopp}
	bind:a = {cand[index].a}
	bind:b = {cand[index].b}
	start = {start}
	optimum = {optimum}
	cand = {cand}
	op = {op}
	undo = {undo}
	/>
</div>

