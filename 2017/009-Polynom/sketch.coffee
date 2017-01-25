
class Polynom
	constructor : (@lst) ->

	add : (other) ->
		lst = []
		for i in range Math.max @lst.length, other.lst.length
			lst.push (@lst[i] or 0) + (other.lst[i] or 0)
		new Polynom lst

	mul : (other) ->
		lst = (0 for [1..@lst.length + other.lst.length])
		for a,i in @lst
			for b,j in other.lst
				lst[i+j] += a*b
		new Polynom lst

	value : (x) ->
		res = 0
		for a,i in @lst
			res += a * x ** i
		res

	diff : ->
		lst = []
		for a,i in @lst
			if i > 0 then lst.push i*a
		new Polynom lst

	integ : ->
		lst = [0]
		for a,i in @lst
			lst.push a/(i+1)
		new Polynom lst

	to_s : ->
		arr = []
		for item,i in @lst
			if item == 0 then continue
			if item == 1 
				if i==0 then arr.push "1"
				else if i==1 then arr.push "x"
				else arr.push "x^#{i}"
			else				
				if i==0 then arr.push "#{item}"
				else if i==1 then arr.push "#{item}*x"
				else arr.push "#{item}*x^#{i}"
		arr.reverse()
		arr.join "+"

p1 = new Polynom [5,4,3]
p2 = new Polynom [4,3]
p3 = new Polynom [0,0,1]
assert p1.to_s(), "3*x^2+4*x+5"
assert p1.add(p2).to_s(), "3*x^2+7*x+9"
assert p1.mul(p2).to_s(), "9*x^3+24*x^2+31*x+20"
assert p1.value(2), 25
assert p1.diff().lst, [4,6] 
assert p1.integ().lst, [0,5,2,1] 
assert p3.to_s(), "x^2"
assert p3.integ().to_s(), "0.3333333333333333*x^3"
assert p3.integ().value(3), 9