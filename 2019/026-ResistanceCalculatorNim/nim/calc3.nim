#? replace(sub = "\t", by = "  ")

# Iterative, static version. 
# Just 50 allocations initially.
# The iterative method is almost twice as slow (2.2 μsecs) than the recursive

import strutils,strformat,algorithm
from times import cpuTime

proc clock() : float = cpuTime()

type
	Node = ref object
		kind : char # s=serial p=parallel r=resistor
		resistance : float
		voltage : float
		a : int 
		b : int 
		level : int

var nodes : array[50,Node]

proc update(node : Node, kind : char, b : int, a : int) = # b,a
	node.kind = kind
	node.a = a
	node.b = b
	let ra = nodes[a].resistance
	let rb = nodes[b].resistance
	if kind == 's': node.resistance = ra+rb
	if kind == 'p': node.resistance = 1/(1/ra+1/rb)

proc update(node : Node, kind : char, resistance : float) =
	node.kind = kind
	node.resistance = resistance

proc current(node : Node) : float = return node.voltage / node.resistance
proc effect (node : Node) : float = return node.current * node.voltage

proc report(node : Node, level : string = "") =
	echo fmt"{node.resistance:8.3f} {node.voltage:8.3f} {node.current:8.3f} {node.effect:8.3f}  {level}{node.kind}"
	if node.kind in "sp":
		nodes[node.a].report level & "| "
		nodes[node.b].report level & "| "

proc build(voltage : float, s : string) : Node =
	var stack : seq[int]
	let arr = s.split ' '
	let n = arr.len
	for i,word in arr:
		let node = nodes[i]
		if   word == "s": node.update('s', stack.pop, stack.pop)
		elif word == "p": node.update('p', stack.pop, stack.pop)
		else: 			      node.update('r', parseFloat(word))
		stack.add i 

	nodes[n-1].voltage = voltage	 
	nodes[n-1].level = 0
	for i in countdown(n-1,0):
		let node = nodes[i]
		let a = nodes[node.a] 
		let b = nodes[node.b] 
		if node.kind == 'r': continue
		a.level = node.level + 1
	  b.level = node.level + 1
		if node.kind == 'p':
			a.voltage = node.voltage
			b.voltage = node.voltage
		else: # 's'
			let ra = a.resistance
			let rb = b.resistance
			let total = node.voltage/(ra+rb)
			a.voltage = ra * total
			b.voltage = rb * total

	nodes[stack.pop]

#let node = build(12.0, "8")
#let node = build(12.0, "8 10 s")
#let node = build(12.0, "3 12 p")
#let node = build(12.0, "8 4 s 12 p 6 s")

proc main = 
	for i in 0 ..< nodes.len:
		nodes[i] = Node()
	var node : Node
	let start = clock()
	for i in 0 ..< 1000000:
		node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s")
	echo clock()-start

	echo "     Ohm     Volt   Ampere     Watt  Network tree"
	node.report

main()