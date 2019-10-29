<script>	
	import { col1,col2,col3 } from '../styles.js'
	import Button from './Button.svelte'

	let a = null
	let b = null
	let hist = []

	function operation (newa) {
		if (Math.ceil(newa) != newa) return
		hist.push(a)
		hist = hist
		a = newa
	}

	const random = (a,b) => a+Math.floor((b-a+1)*Math.random())

	function newGame () {
		a = random(1,20)
		b = random(1,20)
		hist = []
	}

	function undo () {
		a = hist.pop()
		hist = hist 
	}

	newGame()

</script> 
 
<style>
	div,h1 {
		font-size: 30px;
		text-align: center;
	}
</style>

<h1 class={col2} style='font-size: 60px; color:red;'>{a}</h1>
<h1 class={col2} style='font-size: 60px; color:green;'>{b}</h1>
<Button klass={col3} title='+2'   click = {() => operation(a+2)} disabled = {a==b} />
<Button klass={col3} title='*2'   click = {() => operation(a*2)} disabled = {a==b} />
<Button klass={col3} title='/2'   click = {() => operation(a/2)} disabled = {a==b} />
<Button klass={col2} title='New'  click = {newGame} disabled = {a!=b} />
<Button klass={col2} title='Undo' click = {undo}    disabled = {hist.length==0} />  <!--|| a==b -->
<div>{hist.join(' ')}</div>
