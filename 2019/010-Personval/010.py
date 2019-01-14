VALOMRÅDESKOD = 1

def skapaFil(namn,lst):
	file = open('data/'+namn+'.txt', mode='w')
	file.write("\n".join(lst))
	file.close()

file = open('data/kandidaturer.txt', mode='r')
lines = file.read()
file.close()

hash = {}
lines = lines.split("\n")
for line in lines:
	arr = line.split(';')
	if len(arr)!=24: continue
	kod = arr[VALOMRÅDESKOD]
	if kod not in hash: hash[kod] = []
	hash[kod].append(line)

for kod in hash:
	skapaFil(kod,hash[kod])
