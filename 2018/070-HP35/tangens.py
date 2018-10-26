from math import atan
n = 5
xs = [10**-i for i in range(n)]
ys = [atan(x) for x in xs]

def rotate(x,y,fraction,antal):
	for i in range(antal):
		x, y = x - y * fraction, y + x * fraction
	return x,y

def tangens(vinkel):
	qs = []
	for y in ys:
		q = int(vinkel/y)
		qs.append(q)
		vinkel -= q * y

	x,y = 1,vinkel

	for i in range(len(ys)):
		x,y = rotate(x,y,xs.pop(),qs.pop())

	# Verkar kunna beräknas i båda riktningarna
	#for i in range(5):
	#	x,y = rotate(x,y,xs[i],qs[i])

	return y/x

# wolfram: tan(1.5) = 14.101419947171719387646083651987756445659543577235861

#print(tangens(1.5))
#assert 14.101419895026288 == tangens(1.5) # n=4
#assert 14.101419947171722 == tangens(1.5) # n=7
#assert 14.101419947171724 == tangens(1.5) # n=6
assert 14.101419947171067 == tangens(1.5) # n=5

