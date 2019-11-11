<script> 
	import Shortcut from './Shortcut.svelte'
	import range from 'lodash.range'
	import random from 'lodash.random'
	import sample from 'lodash.sample'
	import shuffle from 'lodash.shuffle'
	import {solve} from './solve.js' 

	const url = new URL(window.location.href)
	const getParam = (name,value) => parseInt(url.searchParams.get(name) || value)

	const M = getParam('M',3) // MAX level
	const N = getParam('N',24) // exercises
	const MAX = getParam('MAX',20) // MAX number
	const SHUFFLE = getParam('SHUFFLE',1) 
	const ADD = getParam('ADD',2)
	const MUL = getParam('MUL',2)
	const DIV = getParam('DIV',2)
	const SUB = getParam('SUB',0)

	console.log(M,N,MAX,SHUFFLE)

	let score = 0
	let undos = 0
	let index = 0

	let start = new Date()
	let stopp = new Date()

	let optimum = 0 

	const createCandidates = (n) => {
		const a = random(1,MAX)

		let cands0 = [a]
		const visited = {}
		const memory = {}
		visited[a.toString()] = 0
		memory[a.toString()] = a

		for (const lvl of range(n)) {
			const cands1 = [] 
			const op = (p) => {
				if (p <= MUL*MAX) {
					const key = p.toString()
					if (!(key in memory)) {
						cands1.push(p)
						visited[key] = lvl+1
						memory[key] = p
					}
				}
			}
			for (const cand of cands0) {
				op(cand + ADD)
				op(cand * MUL)
				if (cand % DIV==0) op(cand / DIV)
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
		for (const j of range(N/M)) {
			candidates.push(createCandidates(level+1))
		}
	}

	let cand = SHUFFLE==1 ? shuffle(candidates) : candidates

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

	const reset = () => {
		start = new Date()
		stopp = new Date()
		score = 0
		undos = 0
		index = 0

		for (const c of cand) {
			c.a = c.orig
			c.hist = []
		}
	}

	const handleKeyDown = (event) => {
		event.preventDefault()
		if (event.key=='ArrowLeft' && index > 0) index--
		if (event.key=='ArrowRight' && index < N-1) index++
		if (event.key==' ') index = (index+1) % N
		if (event.key=='Home') index=0
		if (event.key=='End') index=(N-1)
		if (event.key=='a' && a!=b) op(a + ADD)
		if (event.key=='s' && a!=b) op(a - SUB)
		if ((event.key=='m' || event.key=='w') && a!=b) op(a * MUL)
		if (event.key=='d' && a!=b && a % DIV==0) op(a / DIV)
		if (event.key=='z' && hist.length > 0) undo()
		if (event.key=='r') reset()
		if (event.key=='?') alert(` a = ADD {ADD}\n s = SUB {SUB}\n w = MUL {MUL}\n d = DIV {DIV}\n z = undo\n space = next\n left = prev\n right = next\n home = #0\n end = #${N-1}`)
	}

	let message = ''

	$: mm = (name,detail='') => {
		if (name=='score') message = 'number of operations you have used. Minimize!'
		if (name=='optimum') message = 'the minimum number of operations necessary'
		if (name=='undos') message = 'number of undoes. Minimize'
		if (name=='time') message = 'number of seconds you have used. Minimize'
		if (name=='left') message = 'make this number equal to the target number'
		if (name=='right') message = 'this is the target number'
		if (name=='prev') message = 'previous exercise. Key=leftArrow'
		if (name=='next') message = 'next exercise. Key=rightArrow or space'
		if (name=='add') message = 'addition operation on left number. Key=a'
		if (name=='mul') message = 'multiplication operation on left number. Key=w or m'
		if (name=='sub') message = 'subtraction operation on left number. Key=s'
		if (name=='div') message = 'division operation on left number. Key=d'
		if (name=='undo') message = 'last operation is undone. Key=z'
		if (name=='circle') message = 'jump to exercise #' + detail
	}

</script>

<style>
	.w {width:100%}
</style>

<svelte:window on:keydown={handleKeyDown} />
<h3 class='center-align'>Shortcut</h3>
<div style="width:90%; margin:auto">
	<Shortcut
	bind:index = {index}
	bind:score = {score}
	bind:undos = {undos}
	bind:stopp = {stopp}
	bind:a = {cand[index].a}
	bind:b = {cand[index].b}
	{start} {optimum} {cand} {op} {undo} {mm} {N} {ADD} {MUL} {DIV} {SUB}
	/>
</div>
<div class='w center-align'>{message}</div>

