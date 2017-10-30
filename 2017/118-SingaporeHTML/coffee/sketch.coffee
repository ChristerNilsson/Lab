setup = -> calc()

mulValue = (a,b,c) -> a.innerHTML = parseFloat(b.value)     * parseFloat(c.value)
addInner = (a,b,c) -> a.innerHTML = parseFloat(b.innerHTML) + parseFloat(c.innerHTML)
addValue = (a,b,c) -> a.innerHTML = parseFloat(b.value)     + parseFloat(c.value)

calc = -> 

	addValue d,b,c
	addValue m,i,e

	mulValue f,e,b
	mulValue g,e,c
	mulValue j,b,i
	mulValue k,i,c

	addInner h,f,g
	addInner l,j,k
	addInner n,f,j
	addInner o,g,k
	addInner p,n,o