with open('ordlista.txt','r',encoding='utf-8') as f:
	words = f.readlines()

with open('swe4-15.js','w',encoding='utf-8') as g:
	res = []
	for word in words:
		w = word.strip()
		arr = w.split('/')
		if len(arr)==2:
			w = arr[0]
			if '.' not in w:
				if 4 <= len(w) <= 15:
					if w.lower() == w:
						res.append(w)
	g.write('ordlista="' +  ' '.join(res) + '"')
