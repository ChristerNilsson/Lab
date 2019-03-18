#? replace(sub = "\t", by = "  ")

import tables, strutils, sequtils, sugar,strformat

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

echo parse "2 3 + 4 *  "
let input = "(13+14)*12" 
#let input = "3 + 4 * 2" 
echo "infix:   ", input 
echo "postfix: ", shuntRPN input