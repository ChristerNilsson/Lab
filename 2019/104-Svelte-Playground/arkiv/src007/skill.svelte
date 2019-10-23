<style>
	* {box-sizing: border-box}

	.container {
		width: 100%;
		background-color: #ddd;
	}

	.skills {
		text-align: right;
		color: white;
	}

	p {margin-left:10%;}

</style>

<script>
	export let title
	export let value
	export let bg
</script>

<p>{title}</p>
<div class="container skills">
	<div style='width:{value}; background-color:#{bg};'>{value}</div>
</div>		
