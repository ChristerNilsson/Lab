priser = 
	K963: 30/0.300
	K2226: 30
	K1395: 80/0.25 # räkor, skalade. 50% går bort.

gr = 1
mgr = 0.001
µgr = 1e-6

RDI =
	mg: 0.350 * mgr
	selen: 1 * µgr # ren gissning

f = (s) ->
	res = []
	total = {pris:0,kcal:0,kolhydrater:0,fett:0,protein:0,mg:0}
	for item in s.split '|'
		arr = item.split ' '
		key = arr[0]
		amount = parseInt arr[1]
		data = db[key]

		name = data[0]
		pris = priser[key]
		kcal = parseFloat data[2] # kcal/100g RDI:2300 kcal
		kolhydrater = parseFloat data[4] # g/100g
		fett = parseFloat data[5] # g/100g 
		protein = parseFloat data[6] # g/100g 
		mg = parseFloat data[54] # mg/100g  RDI:350 mg

		total.pris        += amount/1000 * pris
		total.kcal        += amount/100 * kcal
		total.kolhydrater += amount/100 * kolhydrater # [g]
		total.fett        += amount/100 * fett # [g]
		total.protein     += amount/100 * protein # [g]
		total.mg          += amount/100 * mg # [mg] 
		res.push [amount,kcal,kolhydrater,fett,protein,mg,name]

	total["fett/protein"] = format 0,'%', 100*total.fett/total.protein # Riktvärde: 1.0
	total.pris        = format 2,'kr',total.pris
	total.kcal        = format 0,'kcal',total.kcal
	total.kolhydrater = format 0,'g',total.kolhydrater
	total.fett        = format 0,'g',total.fett
	total.protein     = format 0,'g',total.protein
	total.mg          = format 0,'mg',total.mg

	res.push total
	res

format = (decs,unit,value) -> "#{value.toFixed decs} #{unit}"

db = {}
buildDb = ->
	for line in database.split '\n'
		arr = line.split '|' 
		for item,i in arr
			if item=='' then arr[i]=0
		arr[0] = arr[0].toLowerCase()
		if arr[0].includes 'räk' then print arr[0],arr[1]
		db["K"+arr[1]] = arr

setup = ->
	createCanvas 200,200

	#print titles.split '|'

	buildDb()

	# bacon 1003
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
	# ägg 1225

	#print f 'K1003 100|K984 500' # bacon fläsklägg
	#print f 'K1453 250|K963 300|K1714 125|K2226 50|K1003 125' # kycklinglever köttfärs kaffegrädde pasta bacon
	print f 'K963 300|K2226 50|K1395 125' # köttfärs pasta räkor
