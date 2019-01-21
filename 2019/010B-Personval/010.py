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

def skapaFil(namn,parti,lst):
	file = open('data/'+namn+'.txt', mode='w')
	file.write("\n".join(lst))
	file.close()

file = open('data/kandidaturer.orig', mode='r')
lines = file.read()
file.close()

hash = {}
personer = {}
partier = {}

lines = lines.split("\n")
for line in lines:
	arr = line.split(';')
	if len(arr)!=24: continue
	kod = arr[VALOMRÅDESKOD]
	knr = arr[KANDIDATNUMMER]
	partikod = arr[PARTIKOD] # 1475
	parti = arr[PARTIFÖRKORTNING] # C
	partinamn = arr[PARTIBETECKNING] # C

	if kod not in hash: hash[kod] = {}
	if partikod not in hash[kod]: hash[kod][partikod]={}
	hash[kod][partikod][knr] = 1

	if knr not in personer: personer[knr] = [knr,arr[ÅLDER_PÅ_VALDAGEN],arr[KÖN],arr[NAMN],arr[VALSEDELSUPPGIFT]]
	if partikod not in partier: partier[partikod] = [partikod,parti,partinamn]

for kod in hash:
	file = open('data/'+kod+'.txt', mode='w')
	for partikod in hash[kod]:
		file.write(partikod)
		file.write("|")
		lst = list(hash[kod][partikod].keys())
		lst.sort()
		file.write("|".join(hash[kod][partikod]))
		file.write("\n")
	file.close()

file = open('data/personer.txt', mode='w')
for knr in personer:
	person = personer[knr]
	file.write("|".join(person))
	file.write("\n")
file.close()

file = open('data/partier.txt', mode='w')
for partikod in partier:
	parti = partier[partikod]
	file.write("|".join(parti))
	file.write("\n")
file.close()
