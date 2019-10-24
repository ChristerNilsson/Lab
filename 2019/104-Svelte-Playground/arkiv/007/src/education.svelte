<script>
	export let title
	export let subTitle
	export let text
	export let href
</script>

<div class="col-sm-6">
	<div class="card">	
		<div class="card-body">
			<h5 class="card-title">{title}</h5>
			<h5 class="card-subtitle mb-2 text-muted">{subTitle}</h5>
			<p class="card-text">{text}</p>
			<a href="{href}" class="btn btn-primary">read about this</a>
		</div>
	</div>
</div>
