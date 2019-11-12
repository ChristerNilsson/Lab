<script>
	export let id,product,add
</script>

<div>
	<button on:click={()=>add(id)}>Add</button>
	{id} <b>{product.title}</b> ${product.price}
</div>
