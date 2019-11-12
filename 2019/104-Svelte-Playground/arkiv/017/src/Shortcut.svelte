<script>
	import Navigation from 	'./Navigation.svelte'
	import Commands from 	'./Commands.svelte'
	import Statistics from 	'./Statistics.svelte'
	import Indicator from 	'./Indicator.svelte'

	export let data,curr,index

	$: bgcolor = curr.a==curr.b ? 'green' : 'grey'

</script>

<style>
	.w {width:100%}
	.fs {font-size:1.5em}
	.fs2 {font-size:2em}
	.marg {margin: 0px}
	.br {border-radius:5px}
</style>

<div class="w row s12 br fs marg {bgcolor} lighten-1 black-text center-align" >
	<Navigation bind:data={data} bind:curr={curr} bind:index={index} />
	<Commands   bind:data={data} bind:curr={curr} />
	<Statistics bind:data={data} />
	<Indicator  bind:data={data} bind:index={index} />
</div>
