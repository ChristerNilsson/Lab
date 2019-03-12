clock = Date.now

nd = (num,w,decs) -> num.toFixed(decs).padStart w

class Node
	constructor : (@kind) ->
	current : -> @voltage / @resistance
	effect : -> @current() * @voltage
	report : (level = "") ->
		print "#{nd @resistance,8,3} #{nd @voltage,8,3} #{nd @current(),8,3} #{nd @effect(),8,3}  #{level}#{@kind}"

class Resistor extends Node
	constructor : (@resistance) -> super 'r'
	evalR : -> @resistance
	setVoltage : (@voltage) ->
	report : (level="") -> super level

class Serial extends Node
	constructor : (@a,@b) -> super 's'
	evalR : -> @resistance = @a.evalR() + @b.evalR()
	setVoltage : (@voltage) ->
		ra = @a.resistance
		rb = @b.resistance
		@a.setVoltage ra/(ra+rb) * @voltage
		@b.setVoltage rb/(ra+rb) * @voltage
	report : (level="") ->
		super level
		@a.report level + "| "
		@b.report level + "| "

class Parallel extends Node
	constructor : (@a,@b) -> super 'p'
	evalR : -> @resistance = 1 / (1 / @a.evalR() + 1 / @b.evalR())
	setVoltage : (@voltage) ->
		@a.setVoltage @voltage
		@b.setVoltage @voltage
	report : (level="") ->
		super level
		@a.report level + "| "
		@b.report level + "| "

build = (voltage, s) ->
	stack = []
	for word in s.split ' '
		if word == "s" then stack.push new Serial stack.pop(), stack.pop()
		else if word == "p" then stack.push new Parallel stack.pop(), stack.pop()
		else stack.push new Resistor parseFloat word
	node = stack.pop()
	node.evalR()
	node.setVoltage voltage
	node

#let node = build(12.0, "8")
#let node = build(12.0, "8 10 s")
#let node = build(12.0, "3 12 p")
#let node = build(12.0, "8 4 s 12 p 6 s")

setup = ->
	start = clock()
	#for i in range 1000000
	node = build 18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s"
	print clock()-start

	print "     Ohm     Volt   Ampere     Watt  Network tree"
	node.report()
