<script>

	const points = [
		{ subject: 'HTML', value: 100 },
		{ subject: 'CSS', value: 70 },
		{ subject: 'GIT', value: 60 },
		{ subject: 'Java', value: 50 },
		{ subject: 'Javascript', value: 45 },
		{ subject: 'Database', value: 40 },
		{ subject: 'React', value: 100 },
		{ subject: 'Node', value: 70 },
		{ subject: 'Agile', value: 60 },
		{ subject: 'API', value: 50 },
		{ subject: 'Electric Engineer', value: 45 },
	];

	const yTicks = [0, 20, 40, 60, 80, 100]
	const padding = { top: 20, right: 15, bottom: 20, left: 25 }

	let width = window.innerWidth
	let height = 400 //window.innerHeight

	const formatMobile = (tick) => "'" + tick % 100;

	const map = (x,x0,x1,y0,y1) => y0 + (x-x0)*(y1-y0)/(x1-x0)
	$: xScale = (x) => map(x, 0, points.length, padding.left, width - padding.right)
	$: yScale = (x) => map(x ,0, 100, height - padding.bottom, padding.top)

	$: innerWidth = width - (padding.left + padding.right);
	$: barWidth = innerWidth / points.length;
</script>

<style>
	h2 {
		text-align: center;
	}

	.chart {
		width: 100%;
		max-width: innerWidth;
		margin: 0 auto;
	}

	svg {
		position: relative;
		width: 100%;
		height: 400px;
	}

	.tick {
		font-family: Helvetica, Arial;
		font-size: .725em;
		font-weight: 200;
	}

	.tick line {
		stroke: #e2e2e2;
		stroke-dasharray: 2;
	}

	.tick text {
		fill: #ccc;
		text-anchor: start;
	}

	.tick.tick-0 line {
		stroke-dasharray: 0;
	}

	.x-axis .tick text {
		text-anchor: middle;
	}

	.bars rect {
		fill: #a11;
		stroke: none;
		opacity: 0.65;
	}
</style>

<h2>Skills</h2>

<div class="chart" bind:clientWidth={width} bind:clientHeight={height}>
	<svg>
		<!-- y axis -->
		<g class="axis y-axis" transform="translate(0,{padding.top})">
			{#each yTicks as tick}
				<g class="tick tick-{tick}" transform="translate(0, {yScale(tick) - padding.bottom})">
					<line x2="100%"></line>
					<text y="-4">{tick} {tick === 20 ? ' ' : ''}</text>
				</g>
			{/each}
		</g>

		<!-- x axis -->
		<g class="axis x-axis">
			{#each points as point, i}
				<g class="tick" transform="translate({xScale(i)},{height})">
					<text x="{barWidth/2}" y="-4">{width > 380 ? point.subject : formatMobile(point.subject)}</text>
				</g>
			{/each}
		</g>

		<g class='bars'>
			{#each points as point, i}
				<rect
					x={xScale(i) + 2}
					y={yScale(point.value)}
					width={barWidth - 4}
					height={height - padding.bottom - yScale(point.value)}
				></rect>
			{/each}
		</g>
	</svg>
</div>
