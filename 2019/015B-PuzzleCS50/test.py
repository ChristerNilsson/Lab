from Board import Board,manhattan

def testManhattan():
	assert 0 == manhattan(0, 0)
	assert 3 == manhattan(0, 3)
	assert 1 == manhattan(0, 1)
	assert 1 == manhattan(0, 4)
	assert 3 == manhattan(0, 9)
	assert 5 == manhattan(0, 14)
	assert 6 == manhattan(0, 15)
	assert 3 == manhattan(1, 10)
	assert 3 == manhattan(2, 4)
	assert 2 == manhattan(2, 5)
	assert 1 == manhattan(2, 6)
	assert 2 == manhattan(2, 7)
	assert 5 == manhattan(2, 12)
	assert 5 == manhattan(3, 13)

def testBoard():
	b = Board([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,0],15)
	assert 0 == b.value()

	b.move(0)
	assert 1+1 == b.value()
	b.move(0)
	assert 2+2 == b.value()
	b.move(0)
	assert 3+3 == b.value()

	b.move(3)
	assert 4+4 == b.value()
	b.move(3)
	assert 5+5 == b.value()
	b.move(3)
	assert 6+6 == b.value()

	b.move(2)
	assert 7+7 == b.value()
	b.move(2)
	assert 8+8 == b.value()
	b.move(2)
	assert 9+9 == b.value()

	b.move(1)
	print(b.value())
	assert 10+10 == b.value()
	b.move(1)
	assert 11+11 == b.value()
	b.move(1)
	assert 12+12 == b.value()

	b.move(0)
	assert 13+13 == b.value()
	b.move(0)
	assert 14+14 == b.value()
	b.move(0)
	assert 15+15 == b.value()

	print(b)

testManhattan()
testBoard()
