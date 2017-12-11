language = 'swe'

with open('data/' + language + '.txt','r',encoding='utf-8') as f:
	lines = f.readlines()
	print(language)

with open('data/' + language +'.js','w',encoding='utf-8') as g:
	g.write('ordlista=[')
	for line in lines:
		res = []
		words = line.split(' ')
		for word in words:
			w = word.strip()
			arr = w.split('/')
			if len(arr)==2: w = arr[0]
			if '.' not in w and '-' not in w:
				if 3 <= len(w) <= 15:
					if w.lower() == w:
						res.append(w)
		if len(res)>0:
			g.write('"' + ' '.join(res) + '",\n')
			print(len(res))
	g.write(']')
