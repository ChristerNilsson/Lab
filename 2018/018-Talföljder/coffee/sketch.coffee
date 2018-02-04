talföljd = null
formel   = null
resultat = null

calc = (formel,talföljd) ->
	res = 0
	n = talföljd.length
	for term,i in formel
		if i==0 then res += term
		else res += term * talföljd[n-i]
	res

readList = (input) ->
	if input.value == '' then return [] 
	parseInt item for item in input.value.split ' '

doit = ->
	t = readList talföljd
	f = readList formel
	u = t.slice()
	for i in range 10
		u.push calc f,u
	s = u.join ' '
	if -1 == s.indexOf 'NaN'  
		resultat.innerHTML = s
	else
		resultat.innerHTML = 'K + Aa + Bb + ...'

setup = ->
	talföljd = document.getElementById 'talföljd'
	formel   = document.getElementById 'formel'
	resultat = document.getElementById 'resultat'
	doit()
