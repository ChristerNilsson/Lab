gcd = (a,b) -> if b==0 then a else gcd b, a%%b
assert 2, gcd 10,8

class Ratio
	constructor : (@a=0,@b=1) ->
		n = gcd @a,@b
		@a /= n
		@b /= n
	mul : (other) -> new Ratio @a*other.a, @b*other.b
	add : (other) -> new Ratio other.b*@a + other.a*@b, @b*other.b
	neg : -> new Ratio -@a,@b
	tos : -> "#{@a}/#{@b}"

a = new Ratio 10,20
b = new Ratio 6,8
assert "1/2", a.tos()
assert "3/4", b.tos()
assert "5/4", a.add(b).tos()
assert "3/8", a.mul(b).tos()
assert "-1/2", a.neg(b).tos()

cache = {}
bernoulli = (n) ->
	if n of cache then return cache[n]
	if n % 2 == 0 then return new Ratio()
	sum = new Ratio(-1, 2).mul new Ratio n, n + 2
	count = (n - 1) / 2
	for i in range count 
		index = 2 * i + 1
		value = polynomialTerm index, count+1
		temp = bernoulli index
		sum = sum.add temp.mul value
	cache[n] = sum.neg()

polynomialTerm = (degree, n) ->
	a = 1
	b = 1
	for i in range degree
		a *= 2 * n - i
		b *= 2 + i  
	new Ratio a, b

assert "0/1", bernoulli(0).tos()
assert "1/6", bernoulli(1).tos()
assert "-1/30", bernoulli(3).tos()
assert "1/42", bernoulli(5).tos()
assert "-1/30", bernoulli(7).tos()
assert "5/66", bernoulli(9).tos()
assert "-691/2730", bernoulli(11).tos()
assert "7/6", bernoulli(13).tos()
assert "-3617/510", bernoulli(15).tos()
assert "43867/798", bernoulli(17).tos()
assert "-174611/330", bernoulli(19).tos()
print 'Ready!'
