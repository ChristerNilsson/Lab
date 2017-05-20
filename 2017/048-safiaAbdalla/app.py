import math

# https://www.youtube.com/watch?v=h_jsjPyNu9o&t=243s
# Safia Abdalla gor det krångligare an nodvandigt.

#def euclDist(first,second):
#	return math.sqrt(sum(map(lambda (pair) : (pair[1]-pair[0])**2, zip(second,first))))

def euclDist((x1,y1),(x2,y2)):
	dx,dy = x1-x2,y1-y2
	return math.sqrt(dx*dx+dy*dy)

print euclDist((1,2),(3,4))

# Coffeescript
# sum = ([a,b]) -> a+b
# assert 5, sum [2,3]
# assert [[1,3],[2,4]], _.zip [1,2],[3,4]
# euclDist = (first,second) -> sqrt sum _.map _.zip(second,first), (pair) -> (pair[1]-pair[0])**2
# print euclDist [1,2],[3,4]
#
# euclDist = ([x1,y1],[x2,y2]) ->
# 	[dx,dy] = [x1-x2,y1-y2]
# 	sqrt dx*dx+dy*dy
#
# print euclDist [1,2],[3,4]
