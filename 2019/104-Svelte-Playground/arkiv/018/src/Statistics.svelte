<script>
	export let score=0
	export let undos=0
	export let ready=0
	export let start=0
	export let stopp=0
	export let optimum = 0
</script>

<style>
	.w100 {width:200px}
	.fs {font-size:20px}
	.marg {margin: 1px}
	.br {border-radius:5px}
</style>

<div class="w100 fs marg br row left green center-align" >
	<div>Score: {score}</div>
	<div>Optimum: {optimum}</div>
	<div>Ready: {ready}</div>
	<div>Undos: {undos}</div>
	<div>	Time: {(stopp - start)/1000}</div>
</div>
