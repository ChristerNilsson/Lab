<script>
	export let score
	export let undos

	export let optimum
	export let stopp
	export let start
	export let mm
</script>

<style>
	.fs {font-size:1.5em}
	.marg {margin: 0px}
</style>

<div class="row s12" >
	<div on:mousemove={() => mm('score')} class="left col s6 fs marg green yellow-text left-align">{score}</div>
	<div on:mousemove={() => mm('undos')} class="left col s6 fs marg green right-align">{undos} undos</div>

	<div on:mousemove={() => mm('optimum')} class="left col s6 fs marg green left-align">{optimum}</div>
	<div on:mousemove={() => mm('time')} class="left col s6 fs marg green right-align">{(stopp - start)/1000}</div>
</div>
