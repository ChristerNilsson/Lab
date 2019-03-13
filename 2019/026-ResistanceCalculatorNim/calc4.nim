#? replace(sub = "\t", by = "  ")

import strutils,strformat
from times import cpuTime

proc clock() : float = cpuTime()

type 
	Node = ref object of RootObj
		kind : char
		resistance : float
		voltage : float
		a : Node
		b : Node
	# Resistor = ref object of Node
	# Serial   = ref object of Node
	# Parallel = ref object of Node

proc setVoltage(node:Node, voltage:float) = 
	node.voltage = voltage 
	if node.kind == 's':
		let ra = node.a.resistance
		let rb = node.b.resistance
		node.a.setVoltage(ra/(ra+rb) * voltage)
		node.b.setVoltage(rb/(ra+rb) * voltage)
	if node.kind == 'p':
		node.a.setVoltage(voltage)
		node.b.setVoltage(voltage)

proc current(node:Node) : float = node.voltage / node.resistance
proc effect(node:Node) : float = node.current() * node.voltage

proc report(node:Node) = #, kind:char, level:int) =
	echo fmt"{node.kind} {node.resistance:8.3f} {node.voltage:8.3f} {node.current():8.3f} {node.effect():8.3f}" #   {level}{kind}"
	if node.kind != 'r': node.a.report 
	if node.kind != 'r': node.b.report 

proc evalR(node:Node) : float =
	if node.kind == 's': node.resistance = node.a.evalR() + node.b.evalR() 
	if node.kind == 'p': node.resistance = 1/(1/node.a.evalR() + 1/node.b.evalR())
	return node.resistance

proc build(voltage:float, s:string) : Node =
	var stack : seq[Node]
	for word in s.split ' ':
		if   word == "s": stack.add Node(kind:'s', a:stack.pop(), b:stack.pop())
		elif word == "p": stack.add Node(kind:'p', a:stack.pop(), b:stack.pop())
		else:             stack.add Node(kind:'r', resistance:parseFloat word)
	let node = stack.pop()
	discard node.evalR()
	node.setVoltage voltage
	node

#let node = build(12.0, "8")
#let node = build(12.0, "8 10 s")
#let node = build(12.0, "3 12 p")
#let node = build(12.0, "8 4 s 12 p 6 s")

proc main = 
	var node : Node
	let start = clock()
	for i in 0 ..< 1000000:
		node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s")
	echo clock()-start

	echo "     Ohm     Volt   Ampere     Watt  Network tree"
	node.report

main()

##############################

#proc report : (node:Node, level:int) =
#proc evalR(node:Resistor) : float = node.resistance
#proc setVoltage(node:Resistor, voltage:float) = 
#	node.voltage = voltage	

# class Resistor extends Node
# 	constructor : (@resistance) -> super()
# 	evalR : -> @resistance
# 	setVoltage : (@voltage) ->
# 	report : (level) -> super 'r',level

#proc evalR(node:Serial) : float = node.a.evalR() + node.b.evalR() 

# proc setVoltage(node:Serial, voltage:float) =
# 	let ra = node.a.resistance
# 	let rb = node.b.resistance
# 	node.a.setVoltage(ra/(ra+rb) * voltage)
# 	node.b.setVoltage(rb/(ra+rb) * voltage)

#proc report(node:Serial, level:int=0) =
#	node.report('s',level)
# class Serial extends Node
# 	constructor : (@a,@b) -> super()
# 	evalR : -> @resistance = @a.evalR() + @b.evalR()
# 	setVoltage : (@voltage) ->
# 		ra = @a.resistance
# 		rb = @b.resistance
# 		@a.setVoltage ra/(ra+rb) * @voltage
# 		@b.setVoltage rb/(ra+rb) * @voltage
# 	report : (level) -> super 's',level

#proc evalR(node:Parallel) : float = 1/(1/node.a.evalR + 1/node.b.evalR)

# proc setVoltage(node:Parallel, voltage:float) =
# 	node.a.setVoltage voltage
# 	node.b.setVoltage voltage

#proc report(node:Parallel, level:int=0) =
#	node.report('p',level)

# class Parallel extends Node
# 	constructor : (@a,@b) -> super()
# 	evalR : -> @resistance = 1 / (1 / @a.evalR() + 1 / @b.evalR())
# 	setVoltage : (@voltage) ->
# 		@a.setVoltage @voltage
# 		@b.setVoltage @voltage
# 	report : (level) -> super 'p',level

