# https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt

with open('10000.txt','r') as f:
	words = f.readlines()

with open('eng4-9.js','w') as g:
	res = []
	for word in words:
		w = word.strip()
		if 4 <= len(w) <= 9:
			res.append(w)
	g.write(' '.join(res))
