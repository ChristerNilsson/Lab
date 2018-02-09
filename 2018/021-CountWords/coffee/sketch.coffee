s1 = 'hate love peace love peace hate love peace love peace'.split ' '
s2 = 'Om Om Shankar Tripathi Tom Jerry Jerry'.split ' '

calc = (words) ->
	m = {}
	for word in words
		if word of m then m[word]++ else m[word]=1
	res = 0
	for word,count of m
		if count==2 then res++
	res

assert 1, calc s1
assert 2, calc s2
