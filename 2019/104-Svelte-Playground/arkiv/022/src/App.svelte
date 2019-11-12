<script>
	import Product from './Product.svelte'
	import Item from './Item.svelte'

	let page = 0
	
	const products = {}
	products['p1'] = {title: 'Gaming Mouse',        price: 29.99 }
	products['p2'] = {title: 'Harry Potter 3',      price:  9.99 }
	products['p3'] = {title: 'Used plastic bottle', price:  0.99 }
	products['p4'] = {title: 'Half-dried plant',    price:  2.99 }

	const items = {}
	items['p1'] = 2

	$: count = Object.values(items).reduce((a,b) => a+b)
	$: cost = Object.keys(items).reduce((a,key) => products[key].price * items[key] + a, 0)

	const remove = (id) => items[id]--
	const add = (id) => items[id] ?	items[id]++ :	items[id] = 1

</script> 

<button on:click={() => page=0}>Products</button>
<button on:click={() => page=1}>Carts ({count} ${Math.round(cost)}) </button>

{#if page==0}
	{#each Object.keys(products) as id}
		<Product {id} product={products[id]} {add}/>
	{/each}
{:else}
	{#each Object.keys(items) as id}
		{#if items[id] > 0}
			<Item {id} count={items[id]} {remove} product={products[id]}/>
		{/if}
	{/each}
{/if}