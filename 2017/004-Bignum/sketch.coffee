# observera att reverse() vänder PÅ plats.
# clona därför med slice() i t ex to_s

reversera = (arr) ->
	arr.slice().reverse() 

class Bignum
	constructor : (s) ->
		@list = (parseInt(ch) for ch in s)
		@list.reverse()

	add : (other) ->
		if @list.length < other.list.length then return other.add @ 
		carry = 0
		res = new Bignum ""
		for d1, pos in @list
			d = d1 + (other.list[pos] || 0) + carry
			res.list.push d % 10
			carry = Math.floor d / 10
		if carry then res.list.push 1
		res

	mul : (other) ->
		res = new Bignum ""
		for digit,d in other.list.slice().reverse()
			for i in range digit
				res = res.add @
			if d < other.list.length-1 then res.list.unshift 0
		res
	
	to_s : () -> @list.slice().reverse().join("")

# class constructor new parseInt reverse length push floor slice unshift join for if

d = 12345678901234567890
assert d+1, 12345678901234567000

a = new Bignum "123"
b = new Bignum "8"
c = new Bignum "999"
d = new Bignum "456"

assert a.to_s(), "123"
assert a.add(b).to_s(), "131"
assert b.add(a).to_s(), "131"
assert a.add(c).to_s(), "1122"
assert a.add(b).add(c).to_s(), "1130"

a = new Bignum "12345678901234567890"
b = new Bignum "1"
assert a.add(b).to_s(),"12345678901234567891" 

a = new Bignum "1"
for i in range 100
	a = a.add a
assert a.to_s(), "1267650600228229401496703205376"

a = new Bignum "123"
b = new Bignum "8"
c = new Bignum "999"
d = new Bignum "456"

assert a.mul(b).to_s(), "984"
assert a.mul(c).to_s(), "122877"
assert a.mul(d).to_s(), "56088"

a = new Bignum "2"
for i in range 6
	a = a.mul a
assert a.to_s(), "18446744073709551616"