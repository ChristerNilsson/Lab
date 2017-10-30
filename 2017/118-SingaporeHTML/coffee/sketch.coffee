setup = ->
	clr()

mult = (a,b,c) -> a.innerHTML = parseFloat(b.value)     * parseFloat(c.value)
add  = (a,b,c) -> a.innerHTML = parseFloat(b.innerHTML) + parseFloat(c.innerHTML)

calc = ->

	mult f,e,b
	mult g,e,c
	mult j,b,i
	mult k,i,c

	add h,f,g
	add l,j,k
	add n,f,j
	add o,g,k
	add p,n,o

clr = ->
	x.innerHTML = '' for x in [f,g,h,j,k,l,n,o,p]	
	x.value = '' for x in [b,c,e,i]