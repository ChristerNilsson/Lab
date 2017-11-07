setup = ->

	mynfs = (a,b,c) -> nfs a.toFixed(c),b,c

	for x in range -0.5,0.5,0.1
		print nfs x,1,1
	print ''

	for x in range -0.5,0.5,0.1
		print mynfs x,1,1
	arr = _.range -0.5,0.5,0.1
	assert mynfs(arr,1,1), ["-0.5", "-0.4", "-0.3", "-0.2", "-0.1", "-0.0", " 0.1", " 0.2", " 0.3", " 0.4"]

