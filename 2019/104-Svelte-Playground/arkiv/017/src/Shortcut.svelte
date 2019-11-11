<script>
	import Navigation from 	'./Navigation.svelte'
	import Commands from 	'./Commands.svelte'
	import Statistics from 	'./Statistics.svelte'
	import Indicator from 	'./Indicator.svelte'

	export let ADD
	export let MUL
	export let DIV
	export let SUB
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
	export let N
	export let mm

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
	<Navigation {cand} bind:index={index} {N} {mm} />
	<Commands {cand} {ADD} {MUL} {DIV} {SUB} {index} {undo} {op} {mm} />
	<Statistics {score} {undos} {start} {stopp} {optimum} {mm} />
	<Indicator {cand} bind:index={index} {N} {mm} />
</div>


