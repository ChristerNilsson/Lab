def add(a,b):
    res = []
    minne = 0
    for i in range(max(len(a),len(b))):
        x,y = 0,0
        if i < len(a):
            x = a[i]
        if i < len(b):
            y = b[i]
        summa = x+y+minne
        digit = summa % 10
        minne = summa / 10
        res.append(digit)
    if minne == 1:
        res.append(minne)
    return res


def mul(a,b):
    res = []
    for x in reversed(a):
        res.insert(0,0)
        for i in range(x):
            res = add(res,b)
    return res


def power(a,b):
    res = [1]
    for x in range(b):
        res = mul(res,a)
    return res

assert add([2],[3]) == [5]
assert add([2,1],[9,1]) == [1,3]
assert add([1],[9,9]) == [0,0,1]

assert mul([2],[3]) == [6]
assert mul([2,1],[9,1]) == [8,2,2]

assert mul([9,8,7,6,5,4,3,2,1],[9,8,7,6,5,4,3,2,1]) == [1, 2, 5, 0, 9, 1, 0, 5, 7, 8, 7, 5, 1, 4, 2, 5, 1]

assert power([2,1], 2) == [4,4,1]
assert power([1,2], 21) == [1, 2, 4, 4, 2, 1, 1, 8, 3, 1, 2, 5, 2, 8, 9, 5, 8, 3, 8, 1, 0, 7, 8, 5, 2, 4, 8, 5]