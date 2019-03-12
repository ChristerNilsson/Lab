import time

clock = time.perf_counter

class Node:
	def current(self) : return self.voltage / self.resistance
	def effect(self): return self.current() * self.voltage
	def report(self, level = "") :
		print(f"{self.resistance:8.3f} {self.voltage:8.3f} {self.current():8.3f} {self.effect():8.3f} {level}{self.kind}")

class Resistor(Node):
	def __init__(self,resistance):
		self.resistance = resistance
		self.kind = 'r'
	def evalR(self): return self.resistance
	def setVoltage(self, voltage): self.voltage = voltage
	def report(self,level=""): 
		super().report(level)

class Serial(Node):
	def __init__(self,a,b) :
		self.a = a
		self.b = b
		self.kind = 's'
	def evalR(self):
		self.resistance = self.a.evalR() + self.b.evalR()
		return self.resistance
	def setVoltage(self, voltage):
		self.voltage = voltage
		ra = self.a.resistance
		rb = self.b.resistance
		self.a.setVoltage(ra/(ra+rb) * voltage)
		self.b.setVoltage(rb/(ra+rb) * voltage)
	def report(self,level=""):
		super().report(level)
		self.a.report(level + "| ")
		self.b.report(level + "| ")

class Parallel(Node):
	def __init__(self,a,b):
		self.a = a
		self.b = b
		self.kind = 'p'
	def evalR(self):
		self.resistance = 1 / (1 / self.a.evalR() + 1 / self.b.evalR())
		return self.resistance
	def setVoltage(self, voltage):
		self.voltage = voltage
		self.a.setVoltage(voltage)
		self.b.setVoltage(voltage)
	def report(self,level=""):
		super().report(level)
		self.a.report(level + "| ")
		self.b.report(level + "| ")

def build(voltage, s) :
	stack = []
	for word in s.split(' '):
		if word == "s": stack.append(Serial(stack.pop(), stack.pop()))
		elif word == "p": stack.append(Parallel(stack.pop(), stack.pop()))
		else: stack.append(Resistor(float(word)))
	node = stack.pop()
	node.evalR()
	node.setVoltage(voltage)
	return node

#let node = build(12.0, "8")
#let node = build(12.0, "8 10 s")
#let node = build(12.0, "3 12 p")
#let node = build(12.0, "8 4 s 12 p 6 s")

start = clock()
for i in range(1000000):
	node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s")
print(clock()-start)

print("     Ohm     Volt   Ampere     Watt Network tree")
node.report()
