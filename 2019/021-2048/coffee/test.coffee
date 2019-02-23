test = ->
	b = new Board()
	# assert = chai.assert.deepEqual	
	# right
	assert [0,0,0,2], b.move4 [1,0,0,1] 
	assert [0,0,2,1], b.move4 [0,2,0,1]
	assert [1,2,3,4], b.move4 [1,2,3,4]
	assert [0,1,3,1], b.move4 [1,2,2,1]
	assert [0,0,2,2], b.move4 [1,1,1,1]
	assert [0,0,2,2], b.move4 [0,2,1,1]
	assert [0,0,0,2], b.move4 [1,1,0,0]
	assert [0,0,0,2], b.move4 [0,1,1,0]
	assert [0,0,4,5], b.move4 [4,4,4,0]
