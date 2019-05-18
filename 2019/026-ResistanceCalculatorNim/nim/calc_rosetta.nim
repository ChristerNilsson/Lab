#? replace(sub = "\t", by = "  ")

import tables,strutils,sequtils,sugar,strformat

type
	Node = ref object
		kind : char  #  + = serial  * = parallel  r = resistor
		resistance : float
		voltage : float
		a : Node
		b : Node

proc res(node : Node) : float =
	if node.kind == '+' : return node.a.res + node.b.res
	if node.kind == '*' : return 1/(1/node.a.res + 1/node.b.res)
	node.resistance

proc current(node : Node) : float = return node.voltage / node.res
proc effect (node : Node) : float = return node.current * node.voltage

proc report(node : Node, level : string = "") =
	echo fmt"{node.res:8.3f} {node.voltage:8.3f} {node.current:8.3f} {node.effect:8.3f}  {level}{node.kind}"
	if node.kind in "+*":
		node.a.report level & "| "
		node.b.report level & "| "

proc setVoltage(node : Node, voltage : float) =
	node.voltage = voltage
	if node.kind == '+':
		let ra = node.a.res
		let rb = node.b.res
		node.a.setVoltage ra/(ra+rb) * voltage
		node.b.setVoltage rb/(ra+rb) * voltage
	if node.kind == '*': 
		node.a.setVoltage voltage
		node.b.setVoltage voltage

proc build(tokens : seq[string]) : Node =
	var stack : seq[Node]
	for token in tokens:
		if   token == "+": stack.add Node(kind : '+', a : stack.pop, b : stack.pop)
		elif token == "*": stack.add Node(kind : '*', a : stack.pop, b : stack.pop)
		else: 	      	   stack.add Node(kind : 'r', resistance : parseFloat(token))
	stack.pop

proc calculate(voltage:float, tokens:seq[string]) : Node = 
	echo ""
	echo "     Ohm     Volt   Ampere     Watt  Network tree"
	let node = build tokens
	node.setVoltage voltage
	node.report
	node

################## RPN

proc rpn(voltage:float, s:string) : Node = calculate(voltage, s.split ' ')
var node = rpn(18.0,"10 2 + 6 * 8 + 6 * 4 + 8 * 4 + 8 * 6 +")
assert 10 == node.res
assert 18 == node.voltage
assert 1.8 == node.current()
assert 32.4 == node.effect()
assert '+' == node.kind

################## Infix

proc parse(s: string): seq[string] =
	var tmp = ""
	for ch in s:
		if ch == ' ': 
			if tmp!="": result.add tmp
			tmp = ""
			continue
		if ch in "+*()": 
			if tmp!="": result.add tmp
			tmp=""
			result.add fmt"{ch}"
		else: tmp &= ch
	if tmp!="": result.add tmp

proc shuntRPN(s:string): seq[string] =
	let ops = "+*" 
	var tokens = parse s
	var stack: seq[string]
	var op: string
 
	for token in tokens:
		case token
		of "(": stack.add token
		of ")":
			while stack.len > 0:
				op = stack.pop()
				if op == "(": break
				result.add op
		else:
			if token in ops:
				while stack.len > 0:
					op = stack[^1]
					if not (op in ops): break
					if ops.find(token) >= ops.find(op): break
					discard stack.pop()
					result.add op
				stack.add token
			else: result.add token
 
	while stack.len > 0: result.add stack.pop()

proc infix(voltage:float, s:string): Node = calculate(voltage, shuntRPN s)
node = infix(18.0,"((((10+2)*6+8)*6+4)*8+4)*8+6")
assert 10 == node.res
assert 18 == node.voltage
assert 1.8 == node.current()
assert 32.4 == node.effect()
assert '+' == node.kind
