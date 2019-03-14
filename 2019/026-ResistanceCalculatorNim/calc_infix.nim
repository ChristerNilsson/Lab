#? replace(sub = "\t", by = "  ")

import strutils,strformat,sugar,sequtils

type 
	Resistor = ref object of RootObj
		symbol : char # 'r'=Resistor '+'=Serial '*'=Parallel
		resistance,voltage : float
		a,b : Resistor

proc res(r:Resistor) : float =
	result = case r.symbol:
		of '+': r.a.res + r.b.res
		of '*': 1 / (1 / r.a.res + 1 / r.b.res)
		else: r.resistance
proc setVoltage(r:Resistor, voltage:float) = 
	case r.symbol:
		of '+':
			let ra = r.a.res
			let rb = r.b.res
			r.a.setVoltage ra/(ra+rb) * voltage
			r.b.setVoltage rb/(ra+rb) * voltage
		of '*':
			r.a.setVoltage voltage
			r.b.setVoltage voltage
		else:
			discard
	r.voltage = voltage
proc current(r:Resistor) : float = return r.voltage / r.res
proc effect(r:Resistor) : float = return r.current * r.voltage
proc report(r:Resistor,level:string="") =
	echo fmt"{r.res:8.3f} {r.voltage:8.3f} {r.current:8.3f} {r.effect:8.3f}  {level}{r.symbol}"
	if r.symbol != 'r':
		r.a.report level & "| "
		r.b.report level & "| "
proc `+`(a:Resistor,b:Resistor) : Resistor = return Resistor(symbol:'+', a:a, b:b)
proc `*`(a:Resistor,b:Resistor) : Resistor = return Resistor(symbol:'*', a:a, b:b)

var R1,R2,R3,R4,R5,R6,R7,R8,R9,R10 : Resistor
let resistors = [6,8,4,8,4,6,8,10,6,2].map(res => Resistor(symbol:'r',resistance:res.float))
(R1,R2,R3,R4,R5,R6,R7,R8,R9,R10) = resistors 
let node = ((((R8 + R10) * R9 + R7) * R6 + R5) * R4 + R3) * R2 + R1
node.setVoltage 18

echo("     Ohm     Volt   Ampere     Watt  Network tree")
node.report
