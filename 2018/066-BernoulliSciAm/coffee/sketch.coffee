class Ratio
	constructor : (@a=0,@b=1) ->
		n = @gcd @a,@b
		@a /= n
		@b /= n
	mul : (other) -> new Ratio @a*other.a, @b*other.b
	add : (other) -> new Ratio other.b*@a + other.a*@b, @b*other.b
	neg : -> new Ratio -@a,@b
	gcd : (a,b) -> if b==0 then a else @gcd b, a%%b
	toString : -> "#{@a}/#{@b}"

a = new Ratio 10,20
b = new Ratio 6,8
assert 2, a.gcd 10,8
assert 1, a.gcd 5,7
assert "1/2", "#{a}"
assert "3/4", "#{b}"
assert "5/4", "#{a.add b}"
assert "3/8", "#{a.mul b}"
assert "-1/2", "#{a.neg()}"

f = (x) -> new Ratio(-1,2).mul new Ratio 2*x-1, 2*x+1
assert "-1/6","#{f 1}"
assert "-3/10","#{f 2}"

g = (x,n) -> (new Ratio 2*x-i, i+2 for i in range 2*n-1).reduce (t,a) => t.mul a
assert "2/1", "#{g 2,1}"
assert "3/1", "#{g 3,1}"
assert "5/1", "#{g 3,2}"
assert "4/1", "#{g 4,1}"
assert "14/1","#{g 4,2}"
assert "28/3","#{g 4,3}"

B = [new Ratio 0,1]
for i in range 1,12
	res = if i==1 then B[0] else (B[j].mul g i,j for j in range 1,i).reduce (t,a) => t.add a
	res = res.add f i 
	B.push res.neg()

assert "0/1", "#{B[0]}"
assert "1/6", "#{B[1]}"
assert "-1/30", "#{B[2]}"
assert "1/42", "#{B[3]}"
assert "-1/30", "#{B[4]}"
assert "5/66", "#{B[5]}"
assert "-691/2730", "#{B[6]}"
assert "7/6", "#{B[7]}"
assert "-3617/510", "#{B[8]}"
assert "43867/798", "#{B[9]}"
assert "-174611/330", "#{B[10]}"
assert "854513/138", "#{B[11]}"

print 'Ready!'
