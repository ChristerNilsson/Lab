<script>	
	import random from 'lodash/random'
	import Button from './Button.svelte'
 
	let a 
	let b 
	let hist = []

	const operation = (newa) => {
		if (Math.ceil(newa) != newa) return
		hist.push(a)
		hist = hist
		a = newa
	}

	const newGame = () => {
		a = random(1,20)
		b = random(1,20)
		hist = []
	}

	const undo = () => {
		a = hist.pop()
		hist = hist 
	}

	newGame()

</script> 
 
<style>
	h2,div {
		font-size: 30px;
		font-family: 'Courier New', Courier, monospace;
	}
</style>

<h2>From: {a}</h2>
<h2>To: {b}</h2>
<Button title='+2'   click = {() => operation(a+2)} disabled = {a==b} />
<Button title='*2'   click = {() => operation(a*2)} disabled = {a==b} />
<Button title='/2'   click = {() => operation(a/2)} disabled = {a==b} />
<Button title='New'  click = {newGame} disabled = {a!=b} />
<Button title='Undo' click = {undo}    disabled = {hist.length==0 || a==b} />
<div>Hist:{hist}</div>
