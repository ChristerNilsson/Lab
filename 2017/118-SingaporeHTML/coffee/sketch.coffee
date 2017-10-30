setup = ->
	ny()

mult = (a,b,c) -> a.innerHTML = parseInt(b.innerHTML) * parseInt(c.innerHTML)
add  = (a,b,c) -> a.innerHTML = parseInt(b.innerHTML) + parseInt(c.innerHTML)

kalkylera = ->

	mult f,e,b
	mult g,e,c
	mult j,b,i
	mult k,i,c

	add h,f,g
	add l,j,k
	add n,f,j
	add o,g,k
	add p,n,o

ny = ->
	for x in [f,g,h,j,k,l,n,o,p]
		x.innerHTML = ''

	b.innerHTML = random range 10,100,10
	c.innerHTML = random range 10
	e.innerHTML = random range 10,100,10
	i.innerHTML = random range 10
