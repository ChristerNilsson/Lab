for language in 'swe eng fra dan ger isl ita nor rus spa'.split(' '):

	with open('data/' + language + '.txt','r',encoding='utf-8') as f:
		words = f.readlines()
		words.sort()
		print(language)

	with open('data/' + language +'.js','w',encoding='utf-8') as g:
		res = []
		for word in words:
			w = word.strip()
			arr = w.split('/')
			if len(arr)==2: w = arr[0]
			if '.' not in w:
				if 4 <= len(w) <= 15:
					if w.lower() == w:
						res.append(w)
		g.write('ordlista="' +  ' '.join(res) + '"')
		print(language,len(res))