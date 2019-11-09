<script>
	import {getStyler} from '../styles.js'

	const MARGPX = 1
	const widths = [50,60,100,120,150,200,300,600]
	let w = 300

	const MARGPROC = 0.1
	const ss = 's:1 s:2 s:3 s:4 s:5 s:6 s:7 s:8 s:9 s:10 s:11 s:12'.split(' ')
	let s = 's:2'

	$: style = getStyler({
		'margpx': `margin ${MARGPX}px`,
		'width': `width ${w-2*MARGPX}px`,
		'margproc': `margin ${MARGPROC}%`,
		's' : `width ${MARGPROC} $1 calcS`,
	})

</script>

<div>
	<select bind:value={w}>
		{#each widths as width}
			<option value={width}>{width}</option>
		{/each}
	</select>
</div>

<div>
	<select bind:value={s}>
		{#each ss as t}
			<option value={t}>{t}</option>
		{/each}
	</select>
</div>

<div style={style("clear:left")}>
	{#each [0,1,2,3,4,5,6,7,8,9,10,11] as i} 
		<div style={style('width margpx fs:20px br:5px float:left bg:red tc:black align:center')}>
			{w}
		</div>
	{/each}
</div>

<div style={style("clear:left")}>
	{#each [0,1,2,3,4,5,6,7,8,9,10,11] as i}
		<div style={style(s + ' margproc fs:20px br:5px float:left bg:green tc:white align:center')}>
			{s}
		</div>
	{/each}
</div>

<pre style={style("fs:20px clear:left")}>
Challenge!
* Use a margin
* Fixed width (red)
* Fixed column count (green)
</pre>
