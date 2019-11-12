<script>
	export let data
</script>

<style>
	.fs {font-size:1.5em}
	.marg {margin: 0px}
</style>

<div class="row s12" >
	<div on:mousemove={() => data.mm('score')} class="left col s6 fs marg green yellow-text left-align">{data.score}</div>
	<div on:mousemove={() => data.mm('undos')} class="left col s6 fs marg green right-align">{data.undos} undos</div>

	<div on:mousemove={() => data.mm('optimum')} class="left col s6 fs marg green left-align">{data.optimum}</div>
	<div on:mousemove={() => data.mm('time')} class="left col s6 fs marg green right-align">{(data.stopp - data.start)/1000}</div>
</div>
