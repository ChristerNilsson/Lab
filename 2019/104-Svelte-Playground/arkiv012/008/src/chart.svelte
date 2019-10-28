<script>

	export let hidden
	// hidden = hidden=='true'
	containerx.hidden = hidden

	if (!hidden) {
		Highcharts.chart('containerx', {
			chart: {type: 'bar'},
			title: {text: 'Skills'},
			subtitle: {text: ''},
			xAxis: {
				categories: ['HTML','CSS','Javascript','React','Database','Node.js','Git & Github','Java','Agile & Scrum','API','Electric Engineer'],
				title: {text: ''}
			},
			yAxis: {
				min: 0,
				max:100,
				title: {
					text: 'Percent',
					align: ''
				},
				labels: {overflow: 'justify'}
			},
			tooltip: {valueSuffix: '%'},
			plotOptions: {
				bar: {
					dataLabels: {enabled: true}
				}
			},
			legend: {
				layout: 'vertical',
				align: 'right',
				verticalAlign: 'top',
				x: -40,
				y: 80,
				floating: true,
				borderWidth: 1,
				backgroundColor: Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
				shadow: true
			},
			credits: {enabled: false},
			series: [{
				name: 'Skill',
				data: [80,100,65,60,70,50,80,70,90,40,75]
			}]
		});
	}
</script> 
