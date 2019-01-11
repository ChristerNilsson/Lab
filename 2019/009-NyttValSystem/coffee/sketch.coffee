S = 0
M = 1
SD = 2
C = 3
V = 4
KD = 5
L = 6
MP = 7
FI = 8
AFS = 9
MED = 10
ÖVRIGA = 11

partier = []
save = (namn,andel) -> partier.push {andel,available:true, total:0,namn}
save 'S', 28.26
save 'M',  19.84
save 'SD', 17.53
save 'C', 8.61
save 'V', 8.00
save 'KD', 6.32
save 'L', 5.49
save 'MP', 4.41
save 'FI', 0.46
save 'AfS', 0.31
save 'MED', 0.30
save 'Övriga', 0.47

N = 7497123
röster = []

process = (lst,andel=1) ->
	index = lst[0]
	parti = partier[index]
	n = round parti.andel * andel * N / 100
	for i in range n
		röster.push lst

SkapaRöster = ->
	process [S]
	process [M]
	process [SD,V,S],0.3
	process [SD,KD,M],0.7
	process [C,S],0.5
	process [C,M],0.5
	process [V,S]
	process [KD,M]
	process [L,M]
	process [MP,V,S],0.7
	process [MP,V,M],0.3
	process [FI,V,MP,S]
	process [AFS,SD,M]
	process [MED,SD,M]
	process [ÖVRIGA]
	röster = _.shuffle röster
	print "#{röster.length} röster inlästa"

RäknaRöster = ->
	for parti in partier
		parti.total = 0
	for röst in röster
		for index in röst
			if partier[index].available
				partier[index].total++
				break 
	for p in partier
		print "#{nf 100*p.total/N,0,2}% #{p.total} #{p.namn}" if p.available

eliminera = ([antal,index]) ->
	parti = partier[index]
	print "Tag bort #{parti.namn} med #{antal} röster"
	parti.available = false

setup = ->
	SkapaRöster()
	for i in range partier.length-1
		print ''
		print "------- Omgång #{i} --------"
		RäknaRöster()
		arr = ([parti.total,i] for parti,i in partier when parti.total > 0)
		arr.sort (a,b) -> b[0] - a[0]

		summa = röster.length 
		[antal,index] = arr[0]
		störst = partier[index]
		print ''
		print "Största parti: #{störst.namn} med #{nf (antal/summa*100), 0,2}% av rösterna"

		eliminera _.last arr

	print '===================================================='
	[antal,index] = arr[0]
	parti = partier[index]
	print "Slutlig segrare: #{parti.namn} med #{nf (antal/summa*100), 0,2} röster"
