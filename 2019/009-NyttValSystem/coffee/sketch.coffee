partier = []
save = (namn,andel) -> partier.push {andel,available:true, total:0,namn}
save 'Socialdemokraterna', 28.26
save 'Moderaterna',  19.84
save 'SverigeDemokraterna', 17.53
save 'Centern', 8.61
save 'Vänsterpartiet', 8.00
save 'Kristdemokraterna', 6.32
save 'Liberalerna', 5.49
save 'Miljöpartiet', 4.41
save 'Feministerna', 0.46
save 'AfS', 0.31

N = 7497123
röster = []

SkapaRöster = ->
	for parti,index in partier
		n = int parti.andel * N / 100
		for i in range n
			switch index 
				when 0 then röster.push [0]
				when 1 then röster.push [1]
				when 2 
					röster.push if random() < 0.3 then [2,5,0] else [2,5,1]
				when 3 
					röster.push if random() < 0.5 then [3,0] else [3,1]
				when 4 then röster.push [4,0]
				when 5 then röster.push [5,1]
				when 6 then röster.push [6,1]
				when 7
					röster.push if random() < 0.7 then [7,4,0] else [7,4,1]
				when 8 then röster.push [8,4,7,0]
				when 9 then röster.push [9,2,1]
	röster = _.shuffle röster
	print "#{N} röster inlästa"

RäknaRöster = ->
	for parti in partier
		parti.total = 0
	for röst in röster
		for index in röst
			if partier[index].available
				partier[index].total++
				break 
	for p in partier
		print "#{p.andel}% #{p.total} #{p.namn}" if p.available

setup = ->
	SkapaRöster()
	for i in range 10
		print ''
		print "------- Omgång #{i} --------"
		RäknaRöster()
		arr = ([parti.total,i] for parti,i in partier when parti.total > 0)
		arr.sort (item) -> item[0]
		#print 'Partierna',arr
		summa = röster.length # _.reduce arr, ((sum,pair) -> sum+pair[0]),0
		parti = arr[0]
		print ''
		print "Största parti: #{partier[parti[1]].namn} med #{nf (parti[0]/summa*100), 0,1}% av rösterna"

		#print 'summa',summa 
		if _.last(arr)[0] > summa/2 then break

		parti = _.last arr
		print "Tag bort #{partier[parti[1]].namn} med #{parti[0]} röster"
		partier[parti[1]].available = false
		#print partier

	print '===================================================='
	index = arr[0][1]
	print "Slutlig segrare: #{partier[index].namn} med #{nf (parti[index]/summa*100), 0,1} röster"
