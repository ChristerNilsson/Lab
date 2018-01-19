test_calcColor = ->
	assert [255,255,255,255], calcColor 0
	assert [128,255,128,255], calcColor 45
	assert [0,255,0,255], calcColor 90
	assert [0,128,0,255], calcColor 135
	assert [0,0,0,255], calcColor 180
	assert [255,128,128,255], calcColor -45
	assert [255,0,0,255], calcColor -90
	assert [128,0,0,255], calcColor -135
	assert [0,0,0,255], calcColor -180

	assert [255,255,0,255], calcColor -225
	assert [255,255,0,255], calcColor -270
	assert [255,255,0,255], calcColor -315
	assert [255,255,0,255], calcColor -360
	assert [255,255,0,255], calcColor 225
	assert [255,255,0,255], calcColor 270
	assert [255,255,0,255], calcColor 315
	assert [255,255,0,255], calcColor 360

test = ->
	print "test start"
	test_calcColor()
	print "test ready"