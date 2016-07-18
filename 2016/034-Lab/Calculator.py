from fractions import Fraction

stack = []
while True:
    pretty = [str(item) for item in stack]
    print ' '.join(pretty)
    cmd = raw_input(" >")
    if cmd == '+':
        stack.append(stack.pop() + stack.pop())
    elif cmd == '*':
        stack.append(stack.pop() * stack.pop())
    elif cmd == '**':
        x = stack.pop()
        y = stack.pop()
        stack.append(y ** x)
    elif cmd == '-':
        stack.append(-stack.pop() + stack.pop())
    elif cmd == '/':
        stack.append(1/stack.pop() * stack.pop())
    else:
        stack.append(Fraction(cmd))
        #stack.append(float(cmd))