<script>
	import {writable} from 'svelte/store'
	export let index
	const storage = localStorage['Shortcut'+index]
	let a = 17
	let b = 1
	let hist = []
	if (storage) ({a,b,hist} = JSON.parse(storage))
	const storeA = writable(a)
	const storeB = writable(b)
	const storeHist = writable(hist)
	
	$: {
		const data = JSON.stringify({a:$storeA, b:$storeB, hist:$storeHist})
		console.log(index, data)
		localStorage['Shortcut'+index] = data
	}
</script>

<div>
{$storeA} to {$storeB}
<button on:click={()=> $storeA+=2}>Add</button>
<button on:click={()=> $storeA*=2}>Mul</button>
<button on:click={()=> $storeA/=2}>Div</button>
</div>
