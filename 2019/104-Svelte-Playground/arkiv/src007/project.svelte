<script>
	export let title
	export let text
	export let href
</script>

<div class="col-sm-6 card card-body">
	<h5 class="card-title">{title}</h5>
	<p class="card-text">{text}</p>
	<a href={href} class="btn btn-primary">Visit repo</a>
</div>

