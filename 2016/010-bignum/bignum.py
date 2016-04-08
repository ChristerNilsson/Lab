antal = 0

def add(a,b):
    res = []
    minne = 0
    for i in range(max(len(a),len(b))):
        x,y = 0,0
        if i < len(a):
            x = a[-1-i]
        if i < len(b):
            y = b[-1-i]
        summa = x+y+minne
        digit = summa % 10
        minne = summa / 10
        res.insert(0,digit)
    if minne == 1:
        res.insert(0,minne)
    return res


def mul(a,b):
    res = []
    global antal
    antal += 1
    for x in a:
        res.append(0)
        for i in range(x):
            res = add(res,b)
    return res


def power(a,n):
    res = [1]
    for x in range(n):
        res = mul(res,a)
    return res

assert add([2],[3]) == [5]
assert add([1,2],[1,9]) == [3,1]
assert add([1],[9,9]) == [1,0,0]

assert mul([2],[3]) == [6]
assert mul([1,2],[1,9]) == [2,2,8]

assert mul([1,2,3,4,5,6,7,8,9],[1,2,3,4,5,6,7,8,9]) == [1, 5, 2, 4, 1, 5, 7, 8, 7, 5, 0, 1, 9, 0, 5, 2, 1]

assert power([1,2], 2) == [1,4,4]

assert power([2,1], 21) == [5, 8, 4, 2, 5, 8, 7, 0, 1, 8, 3, 8, 5, 9, 8, 2, 5, 2, 1, 3, 8, 1, 1, 2, 4, 4, 2, 1]

antal = 0
assert len(power([2,1], 99)) == 131
assert antal == 99