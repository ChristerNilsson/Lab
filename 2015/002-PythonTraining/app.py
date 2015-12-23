# Tag bort denna cell innan leverans till eleverna!

stack = []

def clr():
    del stack[:]

def drp():
    stack.pop()

def swp(x,y):
    stack.append(x)
    stack.append(y)

hash0 = {}
hash0['clr'] = clr
hash0['drp'] = drp

hash1 = {}
hash1['inv'] = lambda x : push(1.0/x)
hash1['chs'] = lambda x : push(-x)

hash2 = {}
hash2['+'] = lambda x,y : push(x+y)
hash2['-'] = lambda x,y : push(y-x)
hash2['*'] = lambda x,y : push(x*y)
hash2['/'] = lambda x,y : push(y/x)
hash2['swp'] = swp


def push(x):
    stack.append(x)

def calc(s):
    #del stack[:]
    arr = s.split()
    for item in arr:
        if item in hash0:
            f = hash0[item]
            f()
        elif item in hash1:
            f = hash1[item]
            f(stack.pop())
        elif item in hash2:
            f = hash2[item]
            f(stack.pop(), stack.pop())
        else:
            push(float(item))
    return stack

#assert calc('2 3 +') == [5]
#assert calc('2 3 *') == [6]
#assert calc('2 3 -') == [-1]
#assert calc('2 3 4 + +') == [9]
#assert calc('2 3 4 * +') == [14]
#assert calc('10 2 /') == [5]
#assert calc('2 3 clr') == []
#assert calc('2 3 swp') == [3,2]
#assert calc('2 3 drp') == [2]
#assert calc('4 inv') == [0.25]
#assert calc('4 chs') == [-4]
#assert calc('-4 chs') == [4]

while True:
    cmd = raw_input(str(stack) + ' Command: ')
    calc(cmd)
