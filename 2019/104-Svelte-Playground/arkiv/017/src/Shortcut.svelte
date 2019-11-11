<script>
	import Navigation from 	'./Navigation.svelte'
	import Commands from 	'./Commands.svelte'
	import Statistics from 	'./Statistics.svelte'
	import Indicator from 	'./Indicator.svelte'

	export let index
	export let score
	export let undos
	export let stopp
	export let a
	export let b
	export let start
	export let optimum
	export let cand
	export let undo
	export let op

	$: hist = cand[index].hist
	$: bgcolor = a==b ? 'green' : 'grey'
</script>

<style>
	.w {width:100%}
	.fs {font-size:1.5em}
	.fs2 {font-size:2em}
	.marg {margin: 0px}
	.br {border-radius:5px}
</style>

<div class="w row s12 br fs marg {bgcolor} lighten-1 black-text center-align" >

	<Navigation {cand} bind:index={index} />
	<Commands {cand} {index} {undo} {op} />
	<Statistics {score} {undos} {start} {stopp} {optimum} />
	<Indicator {cand} {index} />

</div>


