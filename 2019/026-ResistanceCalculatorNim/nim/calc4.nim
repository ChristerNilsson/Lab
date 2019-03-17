#? replace(sub = "\t", by = "  ")

import strutils,strformat
from times import cpuTime

proc clock() : float = cpuTime()

type 
	Resistor = ref object of RootObj
		resistance : float
		voltage : float
		a : Resistor
		b : Resistor
	Serial   = ref object of Resistor
	Parallel = ref object of Resistor

proc current(node:Resistor) : float = node.voltage / node.resistance
proc effect(node:Resistor) : float = node.current() * node.voltage
proc skriv(node:Resistor,kind:char) =
	echo fmt"{kind} {node.resistance:8.3f} {node.voltage:8.3f} {node.current():8.3f} {node.effect():8.3f}" 

method evalR(node:Resistor) : float {.base.} = node.resistance
method setVoltage(node:Resistor, voltage:float) {.base.} = node.voltage = voltage 
method report(node:Resistor) {.base.} = skriv node,'r'

method evalR(node:Serial) : float =
	node.resistance = node.a.evalR() + node.b.evalR() 
	node.resistance
method setVoltage(node:Serial, voltage:float) = 
	node.voltage = voltage 
	let ra = node.a.resistance
	let rb = node.b.resistance
	node.a.setVoltage(ra/(ra+rb) * voltage)
	node.b.setVoltage(rb/(ra+rb) * voltage)
method report(node:Serial) =
	skriv node,'s'
	node.a.report 
	node.b.report 

method evalR(node:Parallel) : float =
	node.resistance = 1/(1/node.a.evalR() + 1/node.b.evalR())
	node.resistance
method setVoltage(node:Parallel, voltage:float) = 
	node.voltage = voltage 
	node.a.setVoltage(voltage)
	node.b.setVoltage(voltage)
method report(node:Parallel) = 
	skriv node,'p'
	node.a.report 
	node.b.report 

proc build(voltage:float, s:string) : Resistor =
	var stack : seq[Resistor]
	for word in s.split ' ':
		if   word == "s": stack.add Serial(a:stack.pop(), b:stack.pop())
		elif word == "p": stack.add Parallel(a:stack.pop(), b:stack.pop())
		else:             stack.add Resistor(resistance:parseFloat word)
	let node = stack.pop()
	discard node.evalR()
	node.setVoltage voltage
	node

#let node = build(12.0, "8")
#let node = build(12.0, "8 10 s")
#let node = build(12.0, "3 12 p")
#let node = build(12.0, "8 4 s 12 p 6 s")

proc main = 
	var node : Resistor
	let start = clock()
	for i in 0 ..< 1000000:
		node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s")
	echo clock()-start

	echo "     Ohm     Volt   Ampere     Watt  Network tree"
	node.report

main()
