<script>
	document.title = 'RPN Calculator'

	let stack = []
	let history = []
	let commands = ''

	const par0 = {}
	const par1 = {}
	const par2 = {}

	par0['drop'] = () => stack.pop()
	par0['pi']   = () => stack.push(Math.PI)
	par0['e']    = () => stack.push(Math.E)
	par0['swap'] = () => stack.push(stack.pop(), stack.pop() )
	par0['clr']  = () => stack = []
	
	par1['x^2']  = x => x * x
	par1['sqrt'] = x => Math.sqrt(x)
	par1['chs']  = x => -x
	par1['1/x']  = x => 1/x
	par1['abs']  = x => Math.abs(x)
	par1['10^x'] = x => 10 ** x
	par1['log']  = x => Math.log10(x)
	par1['exp']  = x => Math.exp(x)
	par1['ln']   = x => Math.log(x)
	par1['sin']  = x => Math.sin(x / 180 * Math.PI)
	par1['cos']  = x => Math.cos(x / 180 * Math.PI)
	par1['tan']  = x => Math.tan(x / 180 * Math.PI)
	par1['asin'] = x => Math.asin(x) * 180 / Math.PI
	par1['acos'] = x => Math.acos(x) * 180 / Math.PI 
	par1['atan'] = x => Math.atan(x) * 180  / Math.PI

	par2['+']    = (x,y) => y + x
	par2['*']    = (x,y) => y * x
	par2['-']    = (x,y) => y - x
	par2['/']    = (x,y) => y / x
	par2['y^x']  = (x,y) => y ** x
	par2['atan2']= (x,y) => Math.atan2(y,x) * 180 / Math.PI
	par2['hypot']= (x,y) => Math.sqrt(x * x + y * y)
	par2['s']    = (x,y) => y + x
	par2['p']    = (x,y) => x*y/(x+y)  // parallel resistors

	const calc = (cmd) => {
		if (cmd in par0) par0[cmd]()
		else if (cmd in par1) stack.push(par1[cmd](stack.pop()))
		else if (cmd in par2) stack.push(par2[cmd](stack.pop(), stack.pop()))
		else if (!isNaN(parseFloat(cmd))) stack.push(parseFloat(cmd))
	}

	function showHistory(delta) {
		if (history.length==0) return
		else if (delta==-1) history.push(history.shift())
		else history.unshift(history.pop())
		commands = history[0]
	}

	function onkeyup (event) {
		if (event.key == 'Escape') commands = ''
		else if (event.key=='ArrowUp') showHistory(-1)
		else if (event.key=='ArrowDown') showHistory(1)
		else if (event.key == 'Enter') {
			commands.split(' ').map( (cmd) => { calc(cmd) })
			if (!history.includes(commands)) history.push(commands)
			commands = ''
			stack=stack
		}
	}

</script> 

<style>
	input,div {
		font-size: 30px;
		font-family: 'Courier New', Courier, monospace
	}
</style>

<div>{document.title}</div>
{#each [par0,par1,par2] as par}
	<div>{Object.keys(par).join(' ')}</div>
{/each}
{#each stack as item}
	<div>{item}</div>
{/each}
<input on:keyup = {onkeyup} type="text" bind:value = {commands} placeholder='Enter commands separated with spaces'>
