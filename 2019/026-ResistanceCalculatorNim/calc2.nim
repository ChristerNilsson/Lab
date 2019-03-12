#? replace(sub = "\t", by = "  ")

# static version. Just 50 allocations initially.

import strutils,strformat
from times import cpuTime

proc clock() : float = cpuTime()

type
	Node = ref object
		kind : char # s=serial p=parallel r=resistor
		resistance : float
		voltage : float
		a : int 
		b : int 

var nodes : array[50,Node]
var nodestop : int = -1

proc update(node : Node, kind : char, b : int, a : int) = # b,a
	node.kind = kind
	node.a = a
	node.b = b

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

proc evalR(node : Node) : float =
	if node.kind == 's' : 
		let a : Node = nodes[node.a]
		let b : Node = nodes[node.b]
		node.resistance = a.evalR + b.evalR
	if node.kind == 'p' : 
		let a : Node = nodes[node.a]
		let b : Node = nodes[node.b]
		node.resistance = 1/(1/a.evalR + 1/b.evalR)
	return node.resistance

proc setVoltage(node : Node, voltage : float) =
	node.voltage = voltage
	if node.kind == 's':
		let a : Node = nodes[node.a]
		let b : Node = nodes[node.b]
		let ra = a.resistance 
		let rb = b.resistance 
		let total = voltage/(ra+rb)
		a.setVoltage ra * total #/(ra+rb) * voltage
		b.setVoltage rb * total #/(ra+rb) * voltage
	if node.kind == 'p': 
		let a : Node = nodes[node.a]
		let b : Node = nodes[node.b]
		a.setVoltage voltage
		b.setVoltage voltage

proc build(voltage : float, s : string) : Node =
	nodestop = -1
	var stack : seq[int]
	for word in s.split ' ':
		nodestop.inc
		let node : Node = nodes[nodestop]
		if   word == "s": node.update('s', stack.pop, stack.pop)
		elif word == "p": node.update('p', stack.pop, stack.pop)
		else: 			      node.update('r', parseFloat(word))
		stack.add nodestop 
	let node : Node = nodes[stack.pop]
	discard node.evalR
	node.setVoltage voltage
	node

#let node = build(12.0, "8")
#let node = build(12.0, "8 10 s")
#let node = build(12.0, "3 12 p")
#let node = build(12.0, "8 4 s 12 p 6 s")

proc main = 
	for i in 0 .. 50:
		nodes[i] = Node()
	var node : Node
	let start = clock()
	for i in 0 ..< 1000000:
		node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s")
	echo clock()-start

	echo "     Ohm     Volt   Ampere     Watt  Network tree"
	node.report

main()