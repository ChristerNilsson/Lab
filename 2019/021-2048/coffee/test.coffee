test = ->
	assert [0,0,0,2], move [1,0,0,1]
	assert [0,0,2,1], move [0,2,0,1]
	assert [1,2,3,4], move [1,2,3,4]
	assert [0,1,3,1], move [1,2,2,1]
	assert [0,0,2,2], move [1,1,1,1]
	assert [0,0,2,2], move [0,2,1,1]
	assert [0,0,0,2], move [1,1,0,0]
	assert [0,0,0,2], move [0,1,1,0]