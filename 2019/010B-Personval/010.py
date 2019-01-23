# -*- coding: utf-8 -*-

VALTYP = 0
VALOMRÅDESKOD = 1
VALOMRÅDESNAMN = 2
VALKRETSKOD = 3
VALKRETSNAMN = 4
PARTIBETECKNING = 5
PARTIFÖRKORTNING = 6
PARTIKOD = 7
VALSEDELSSTATUS = 8
LISTNUMMER = 9
ORDNING = 10
ANMKAND = 11
ANMDELTAGANDE = 12
SAMTYCKE = 13
FÖRKLARING = 14
KANDIDATNUMMER = 15
NAMN = 16
ÅLDER_PÅ_VALDAGEN = 17
KÖN = 18
FOLKBOKFÖRINGSORT = 19
VALSEDELSUPPGIFT = 20
ANT_BEST_VALS = 21
VALBAR_PÅ_VALDAGEN = 22
GILTIG = 23

file = open('data/kandidaturer.orig', mode='r')
lines = file.read()
file.close()

hash = {}
personer = {}
partier = {}
områden = {}

# Ersätt dubbla mellanslag med enkla
n = 0
while n != len(lines):
	n = len(lines)
	lines = lines.replace('  ',' ')

lines = lines.split("\n")
for line in lines:
	arr = line.split(';')
	if len(arr)!=24: continue
	kod = arr[VALOMRÅDESKOD]
	områdesnamn = arr[VALOMRÅDESNAMN]
	knr = arr[KANDIDATNUMMER]
	partikod = arr[PARTIKOD] # 1475
	parti = arr[PARTIFÖRKORTNING] # C
	partinamn = arr[PARTIBETECKNING] # C
	namn = arr[NAMN]

	if '[' in namn or ']' in namn: continue # olika texter, t ex [saknas i folkbokforingen]
	if parti == '': continue

	if ',' in namn:
		enamn,fnamn = namn.split(',')
		namn = fnamn.strip() + ' ' + enamn.strip()

	if kod not in hash: hash[kod] = {}
	if partikod not in hash[kod]: hash[kod][partikod]={}
	hash[kod][partikod][knr] = 1

	if kod not in områden: områden[kod] = områdesnamn

	if knr not in personer: personer[knr] = [knr,arr[ÅLDER_PÅ_VALDAGEN],arr[KÖN],namn,arr[VALSEDELSUPPGIFT]]
	if partikod not in partier: partier[partikod] = [partikod,parti,partinamn]

områden['00'] = 'Riksdagen'

for kod in hash:
	file = open('data/'+kod+'.txt', mode='w')
	file.write('T|' + områden[kod] + "\n")
	personhash = {}
	partihash = {}
	for partikod in hash[kod]:
		#if [kod,partikod] in skräppartier: continue
		file.write("A|")
		file.write(partikod)
		file.write("|")
		lst = list(hash[kod][partikod].keys())
		lst.sort()
		file.write("|".join(hash[kod][partikod]))
		for knr in hash[kod][partikod]:
			personhash[knr] = 1
			partihash[partikod] = 1
		file.write("\n")

	for partikod in partihash:
		#if partikod in skräppartier: continue
		parti = partier[partikod]
		file.write("B|")
		file.write("|".join(parti))
		file.write("\n")

	for knr in personhash:
		person = personer[knr]
		file.write("C|")
		file.write("|".join(person))
		file.write("\n")

	file.close()

#print(områden)
file = open('data/omraden.txt', mode='w')
for kod in områden:
	file.write(kod + '|' + områden[kod] + "\n")
file.close()
