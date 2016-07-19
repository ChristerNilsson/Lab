import fractions
#from cmath import *
from math import *
def unary(f): stack.append(f(stack.pop()))
def binary(f): stack.append(f(stack.pop(),stack.pop()))
def radians(x): return pi/180*x
stack = []
mode = 'float' # Please note: complex numbers uses j instead of i
while True:
    for command in raw_input(" ".join([str(tal) for tal in stack]) + " " + mode + ": ").split(" "):
        if command == "": pass
        elif command == "+":   binary(lambda x, y: y + x)
        elif command == "*":   binary(lambda x, y: y * x)
        elif command == "-":   binary(lambda x, y: y - x)
        elif command == "/":   binary(lambda x, y: y / x)
        elif command == "%":   binary(lambda x, y: y % x)
        elif command == "**":  binary(lambda x, y: y ** x)
        elif command == "chs": unary(lambda x: -x)
        elif command == "inv": unary(lambda x: 1/x)
        elif command == "abs": unary(lambda x: abs(x))
        elif command == "sqrt":unary(lambda x: sqrt(x))
        elif command == "cos": unary(lambda x: cos(radians(x)))
        elif command == "sin": unary(lambda x: sin(radians(x)))
        elif command == "exp": unary(lambda x: exp(x))
        elif command == "ln":  unary(lambda x: log(x))
        elif command == "log": unary(lambda x: log10(x))
        elif command == "clr": stack = []
        elif command == "drp": stack.pop()
        elif command == "dup": stack.append(stack[-1])
        elif command == "swp": stack[-1], stack[-2] = stack[-2], stack[-1]
        elif command == "pi": stack.append(pi)
        elif command == "n":  unary(lambda x: float(x))
        elif command in ['fraction','float','complex']: mode = command
        else: # enter a number
            if mode == 'fraction':  stack.append(fractions.Fraction(command))
            elif mode == 'complex': stack.append(complex(command))
            elif mode == 'float':   stack.append(float(command))