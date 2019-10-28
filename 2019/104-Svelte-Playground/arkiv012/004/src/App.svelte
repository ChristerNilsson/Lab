<script>
	import Game from './game.js'
	let game = new Game(2)
	const onkeyup = (e) => {
		if (e.key != 'Enter') return
		game.action(e.target.value)
		game = game // touch game
		e.target.value = ''
	}
</script> 

<h2>Level: {game.level}</h2>
<h2>Interval: {game.low} - {game.high}</h2>
<input on:keyup = {onkeyup}>
