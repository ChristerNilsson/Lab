<script>
	export let id,count,remove,product
</script>

<div>
	<button on:click={() => remove(id)}> Remove </button>
	{id} <b>{product.title}</b> ${product.price} {count}
</div>
