class Polynom
	constructor : (@lst) ->

	add : (other) ->
		h = []
		h[i] = (h[i] or 0) + value for value,i in @lst
		h[i] = (h[i] or 0) + value for value,i in other.lst
		new Polynom h

	mul : (other) ->
		h = (0 for i in range @lst.length + other.lst.length - 1)
		for value1,i1 in @lst
			for value2,i2 in other.lst
				i = i1+i2
				h[i] = (h[i] or 0) + value1 * value2
		new Polynom h

	power : (n) ->
		res = new Polynom [1]
		res = res.mul @ for i in range n
		res

	compose : (other)	->
		res = new Polynom []
		for value,i in @lst
			res = res.add (new Polynom [value]).mul other.power i
		res

	value : (x) ->
		res = 0
		res += value * x ** i for value,i in @lst
		res

	diff : ->
		lst = []
		for value,i in @lst
			if i != 0 then lst[i-1] = i*value
		new Polynom lst

	integ : ->
		lst = [0]
		for value,i in @lst
			i += 1
			lst[i] = value/i
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

assert p1.lst, [5,4,3]
assert p1.to_s(), "3*x^2+4*x+5"
assert p1.add(p2).to_s(), "3*x^2+7*x+9"
assert p1.mul(p2).to_s(), "9*x^3+24*x^2+31*x+20"
assert p1.value(2), 25
assert p1.diff().lst, [4,6] 
assert p1.integ().lst, [0,5,2,1] 
assert p3.to_s(), "x^2"
assert p3.integ().to_s(), "0.3333333333333333*x^3"
assert p3.integ().value(3), 9
assert p1.power(2).lst, [25,40,46,24,9] 
assert p2.power(3).lst, [64,144,108,27] 

f = new Polynom [3,2]
g = new Polynom [5,0,-1]
assert f.compose(f).lst, [9,4]
assert f.compose(g).lst, [13,0,-2]
assert g.compose(f).lst, [-4,-12,-4]
assert g.compose(g).lst, [-20,0,10,0,-1]