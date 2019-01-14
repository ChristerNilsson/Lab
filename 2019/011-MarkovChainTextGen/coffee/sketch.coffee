CHARS = 200000
N = 4

# choose = (hash) ->
# 	keys = _.keys hash
# 	values = _.values hash
# 	if keys.length == 1 then return keys[0]
# 	sum = 0
# 	sum += value for value in values
		
# 	r = int random sum
# 	sum = 0
# 	for value,i in values 
# 		sum += value
# 		if r < sum then return keys[i]
# 	_.last keys
# setup = ->
# #	print choose {adam:1,bertil:1,cesar:10}

# 	start = Date.now()
# 	model = {}
# 	for i in range data.length - N
# 		state = data.slice i, i+N 
# 		next = data[i+N]
# 		if model[state] == undefined
# 			model[state] = {}
# 		if model[state][next] == undefined	
# 			model[state][next] = 0
# 		model[state][next]++

# 	keys = _.keys model
# 	index = int random keys.length
# 	state = keys[index]
# 	out = [state]
# 	for i in [0..CHARS]
# 		if state not of model then break
# 		char = choose model[state]
# 		out.push char
# 		state = state.slice(1,N) + char
# 	print out.join ''
# 	print Date.now()-start 

choose = (arr) -> arr[int random arr.length]
setup = ->
	start = Date.now()
	model = {}
	for i in range data.length - N
		state = data.slice i, i+N 
		next = data[i+N]
		if state of model then model[state].push next else model[state] = [next]

	# reducera listor med lika element
	for state of model
		if model[state].length==1 then continue
		a = _.uniq model[state]
		if a.length==1 then model[state]=a

	print model

	keys = _.keys model
	index = int random keys.length
	state = keys[index]
	out = [state]
	for i in [0..CHARS]
		if state not of model then break
		char = choose model[state]
		out.push char
		state = state.slice(1,N) + char
	print out.join ''
	print Date.now()-start 