nodes = null

class Node
	constructor : (@head,@size,@edges) ->
	setHead : (head) -> 
		@head = head
	update : (other) -> 
		@size  += other.size
		@edges += other.edges + 1 

f = (n,lst) ->   
	nodes = (new Node i,1,0 for i in range n)        
	for [a,b] in lst 
		a = findHead a
		b = findHead b
		if a != b 
			nodes[a].setHead b
			nodes[b].update nodes[a]
		else
			nodes[a].edges++
	for node,i in nodes
		if node.head == i and node.size*(node.size-1) != 2*node.edges then return false
	true
findHead = (u) -> if u == nodes[u].head then u else findHead nodes[u].head 
 
assert true, f 4,[[0,2],[0,3],[2,3]] # zero based
print nodes
assert false, f 4,[[2,0],[1,2],[2,3],[0,1]]
print nodes
