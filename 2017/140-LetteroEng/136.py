with open('200000.txt','r',encoding='utf-8') as f:
	words = f.readlines()

with open('eng4-15.js','w',encoding='utf-8') as g:
	res = []
	for word in words:
		w = word.strip()
		if '.' not in w:
			if 4 <= len(w) <= 15:
				if w.lower() == w:
					res.append(w)
	g.write('ordlista="' +  ' '.join(res) + '"')
