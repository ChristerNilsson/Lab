hash = {}

normalize = (ord) -> 
	arr = ord.split ''
	arr.sort()
	arr.join ''

setup = ->
	for ord in ordlista.split ' '
		key = normalize ord
		if hash[key] then hash[key].push ord else hash[key] = [ord] 
	inp = createInput ''
	inp.input ->
		key = normalize @value()
		unscrambled = hash[key]
		div.html if unscrambled then unscrambled else ''
	div = createDiv 'Mata in 4-9 bokstäver. T ex dunh'
