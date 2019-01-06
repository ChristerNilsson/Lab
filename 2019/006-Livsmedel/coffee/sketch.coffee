f = (s) ->
	res = []
	total = {k:0,f:0,c:0,p:0,price:0,amount:0,n:'TOTAL'}
	for item in s.split '|'
		arr = item.split ' '
		key = arr[0]
		amount = parseInt arr[1]
		data = db[key]

		n = data.n # name
		price = amount * data.price / data.weight 
		k = amount * data.k/100 # kcal RDI:2300 kcal
		c = amount * data.c/100 # carb g
		f = amount * data.f/100 # fat g 
		p = amount * data.p/100 # prot g 
		res.push {k,c,f,p,price,amount,n}

		total.k += k
		total.c += c # [g]
		total.f += f # [g]
		total.p += p # [g]
		total.price += price 
		total.amount += amount

	res.push total
	summa = (total.f+total.c+total.p)/100
	res.push {k:0,f:total.f/summa,c:total.c/summa,p:total.p/summa,price:0,amount:0,n:'%'}
	res

fmt = (value,width,decs=0) -> value.toFixed(decs).padStart width

db = {}
buildDb = ->
	db.K0 = {n:'bacon',   k:308, f:28, c:3.5, p:14,   weight:125, price:13}
	db.K1 = {n:'chorizo', k:273, f:23, c:3.5, p:13,   weight:540, price:40}
	db.K2 = {n:'ägg',     k:140, f:10, c:0,   p:12.5, weight:630, price:33}
	db.K3 = {n:'musslor', k:100, f:2.8, c:3.1,p:15,   weight:250, price:32}

setup = ->
	createCanvas 200,200
	buildDb()

	# fläsklägg 984
	# kaffegrädde 1714
	# kalvlever 1441
	# kokhöna 1161
	# kycklinghjärta 1452
	# kycklinglever 1453
	# köttfärs 963
	# lammhjärta 1435
	# makrill 1279
	# mozarella
	# märgben 956
	# nötstek 950
	# pasta 2226
	# pollock 4615
	# räkor 1395 # OBS! Hälften går bort som skal
	# torsk 1246

	söndag = 'K0 125|K1 360|K2 120|K3 125'

	print ' kcal fat carb prot price amount name'
	for item in f söndag
		print "#{fmt item.k,5} #{fmt item.f,3} #{fmt item.c,4} #{fmt item.p,4} #{fmt item.price,5,2} #{fmt item.amount,6} #{item.n}" #  #{fmt 50*item.f/item.p,4}%
	print '       75    5   20              Keto Std'
	print '       60    5   35              Keto HP'

#######

		# gr = 1
# mgr = 0.001
# µgr = 1e-6

# RDI =
# 	mg: 0.350 * mgr
# 	selen: 1 * µgr # ren gissning

	# for line in database.split '\n'
	# 	arr = line.split '|' 
	# 	for item,i in arr
	# 		if item=='' then arr[i]=0
	# 	arr[0] = arr[0].toLowerCase()
	# 	if arr[0].includes 'chorizo' then print arr[0],arr[1]
	# 	db["K"+arr[1]] = arr

#format = (decs,unit,value) -> "#{value.toFixed decs} #{unit}"
