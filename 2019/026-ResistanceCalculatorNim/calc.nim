#? replace(sub = "\t", by = "  ")

import strutils,strformat

type
	Node = ref object
		kind : string # s=serial p=parallel r=resistor
		resistance : float
		voltage : float
		a : Node
		b : Node

proc current(node : Node) : float = return node.voltage / node.resistance
proc effect (node : Node) : float = return node.current * node.voltage

proc report(node : Node) : seq[Node] =
	result = @[node]
	if node.kind in ["s","p"]:
		result.add report node.a
		result.add report node.b

proc evalR(node : Node) : float =
	if node.kind == "s" : node.resistance = node.a.evalR + node.b.evalR
	if node.kind == "p" : node.resistance = 1/(1/node.a.evalR + 1/node.b.evalR)
	return node.resistance

proc setVoltage(node : Node, voltage : float) =
	node.voltage = voltage
	if node.kind == "s":
		let ra = node.a.resistance 
		let rb = node.b.resistance 
		node.a.setVoltage ra/(ra+rb) * voltage
		node.b.setVoltage rb/(ra+rb) * voltage
	if node.kind == "p": 
		node.a.setVoltage voltage
		node.b.setVoltage voltage

proc build(voltage : float, s : string) : Node =
	var stack : seq[Node]
	for word in s.split ' ':
		if word in ["s","p"]: 
			stack.add Node(kind : word, a : stack.pop, b : stack.pop)
		else: 
			stack.add Node(kind : "r", resistance : parseFloat(word))
	let node = stack.pop
	discard node.evalR
	node.setVoltage voltage
	node

let node = build(12.0, "8 4 s 12 p 6 s")
#let node = build(18.0, "6 4 10 2 s 6 p 8 s 6 p 4 s 8 p s 8 p s")

let nodes = node.report
echo "       Ohm     Volt   Ampere     Watt"
for i in countdown(nodes.len - 1, 0):
	let node = nodes[i]
	echo fmt"{node.kind} {node.resistance:8.3f} {node.voltage:8.3f} {node.current:8.3f} {node.effect:8.3f}"
