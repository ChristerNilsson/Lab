<script>
	document.title = 'Player Scoreboard'
	import Navbar from './Navbar.svelte'
	import Player from './Player.svelte'
	import AddPlayer from './AddPlayer.svelte'

	let players = [
		{name:'Christer',points: 100}, 
		{name:'Numa',points: 200},
	]

	const deletePlayer = (e) => {
		players = players.filter( (player) => player.name!=e.detail)
	}
</script>

<Navbar/>
<div class="container">
	<AddPlayer on:addplayer={(e) => players = [...players, e.detail]}/>
	{#each players as player}
		<Player name={player.name} points={player.points}
		on:deleteplayer={deletePlayer} 
		/>
	{/each}
</div>
