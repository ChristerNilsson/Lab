def add(a,b):
    res = 00
    minne = 00
    for i in 00:
        x,y = 00,00
        if i < 00:
            x = 00
        if i < 00:
            y = 00
        summa = 00
        digit = 00
        minne = 00
        res.append(00)
    if 00:
        res.append(00)
    return 00


def mul(a,b):
    res = 00
    for x in 00:
        res.insert(00,00)
        for i in 00:
            res = add(00,00)
    return 00


def power(a,b):
    res = 00
    for x in 00:
        res = mul(00,00)
    return 00

assert add([2],[3]) == [5]
assert add([2,1],[9,1]) == [1,3]
assert add([1],[9,9]) == [0,0,1]

assert mul([2],[3]) == [6]
assert mul([2,1],[9,1]) == [8,2,2]

assert mul([9,8,7,6,5,4,3,2,1],[9,8,7,6,5,4,3,2,1]) == [1, 2, 5, 0, 9, 1, 0, 5, 7, 8, 7, 5, 1, 4, 2, 5, 1]

assert power([2,1], 2) == [4,4,1]
assert power([1,2], 21) == [1, 2, 4, 4, 2, 1, 1, 8, 3, 1, 2, 5, 2, 8, 9, 5, 8, 3, 8, 1, 0, 7, 8, 5, 2, 4, 8, 5]