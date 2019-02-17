N = 3
last_index = 0

def gen_successors(node):
	def swap(a, b):
		global last_index
		sk = list(state)
		sk[a], sk[b] = sk[b], sk[a]
		last_index += 1
		return (''.join(sk), last_index, node[1], node[N] + 1)

	ret = []
	state = node[0]
	loc = state.index('_')
	if loc % N != 0:   ret.append(swap(loc,loc-1))
	if loc % N != N-1: ret.append(swap(loc,loc+1))
	if loc//N != 0:    ret.append(swap(loc,loc-N))
	if loc//N != N-1:  ret.append(swap(loc,loc+N))
	return ret

def is_goal(node):	return node[0] == '413_25786'

def insert_all(node, fringe):
	children = gen_successors(node)
	for child in children:
		fringe[0:0] = [child]  # fringe.append(child)
		#print(fringe)

def show_result(g, visited_node):
	current_node = g
	#parent_index = current_node[1]
	while True:
		if N==3:
			print(current_node[0][0:3])
			print(current_node[0][3:6])
			print(current_node[0][6:])
		if N==4:
			print(current_node[0][0:4])
			print(current_node[0][4:8])
			print(current_node[0][8:12])
			print(current_node[0][12:])
		print()
		parent_index = current_node[2]
		if parent_index == -1: break
		current_node = visited_node[parent_index]

def dfs(start_node, limited_level):
	global last_index
	last_index = 0
	fringe = [start_node]
	# print(fringe)
	visited_node = {}
	while True:
		if len(fringe) == 0:
			print('Not Found')
			break
		front = fringe[0]
		visited_node[front[1]] = front
		fringe = fringe[1:]
		if is_goal(front):
			show_result(front, visited_node)
			return True
		if front[3] == limited_level:	continue
		insert_all(front, fringe)

for i in range(7):
	print(f"Limit Search at level {i+1}")
	if dfs(('12345678_', 0, -1, 0), i): break
