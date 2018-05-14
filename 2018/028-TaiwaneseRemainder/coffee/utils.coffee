PRIMES = [2,3,5,7,11, 13,17,19,23,29, 31,37,41,43,47, 53,59,61,67,71, 73,79,83,89,97, 101,103,107,109,113] #,131,137,139,149,151,157,163,167,173]

createRests = (ticks,total) -> (total % t for t in ticks)

createProblem = (level) ->
	steps = level%5 + level//5 + 1
	antalKlockor = 2 + level//5

	antalPrimtal = int map steps,1,125,4,PRIMES.length
	antalPrimtal = constrain antalPrimtal,4,PRIMES.length
	ticks = _.sample PRIMES[..antalPrimtal], antalKlockor
	ticks.sort (a,b) -> a-b

	# första metoden ger alltför jämnt fördelade problem.
	# total = (_.sample ticks for i in range steps).reduce (a,b)->a+b 
	# Vissa totalsummor är omöjliga att uppnå. Max 50%
	solution = null
	while solution == null
		total = _.random steps * ticks[0], steps * _.last ticks
		solution = solve ticks,total,steps

	rests = createRests ticks,total
	h = window.location.href
	pathname = h.split('?')[0]

	url = pathname + '?level=' + level + '&ticks=' + ticks + '&rests=' + rests
	print url

	{level,ticks,rests,url,solution}

solve = (ticks,sum,n) ->
	tabell = new Array(sum+1).fill null
	tabell[n * ticks[0]] = new Array(ticks.length).fill 0
	tabell[n * ticks[0]][0] = n
	for i in range n,sum
		rad = tabell[i]
		if rad == null then continue # går ej att expandera
		for j in range ticks.length
			if rad[j] == 0 then continue # finns inget att flytta
			for k in range j+1,ticks.length
				index = i - ticks[j] + ticks[k]
				if index > sum then continue # utanför tabellen
				if tabell[index] == null
					tabell[index] = rad[..]
					tabell[index][j]--
					tabell[index][k]++
	tabell[sum]
assert [5,1,0,0,0,4], solve [2,3,5,7,11,13],65,10

copyToClipboard = (s) -> 
	el = document.createElement 'textarea'
	el.value = s
	document.body.appendChild el
	el.select()
	document.execCommand 'copy'
	document.body.removeChild el

fac = (n) -> if n <= 1 then 1 else	n * fac n - 1
combinations = (n, k) ->  fac(n + k - 1) / fac(k - 1) / fac(n)

short = (n) ->
	m = Math.floor Math.log10(n)/3
	dekad = 1000 ** m 
	value = Math.round n/dekad
	value + " KMGT"[m]

assert "999 ", short 999
assert "1K", short 1000
assert "1K", short 1001
assert "1K", short 1499
assert "2K", short 1500
assert "20K", short 20000
assert "200K", short 200000
assert "2M", short 2000000

