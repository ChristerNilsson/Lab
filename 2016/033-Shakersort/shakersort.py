def bubblesort(a):
    i = 0
    r = len(a)-1
    while 0 < r:
        if a[i] > a[i+1]: a[i], a[i+1] = a[i+1], a[i]
        i += 1
        if i >= r:
            i = 0
            r -= 1
    return a
assert bubblesort([9,8,7,6,5,4,3,2,1,0]) == [0,1,2,3,4,5,6,7,8,9]

def shakersort(a):
    dir = 1
    l,r = 0,len(a)-1
    i = 0
    while l < r:
        if a[i] > a[i+1]: a[i], a[i+1] = a[i+1], a[i]
        i += dir
        if i >= r:
            dir = -1
            r -= 1
            i = r-1
        if i < 0:
            dir = 1
            l += 1
            i=l
    return a
assert shakersort([9,8,7,6,5,4,3,2,1,0]) == [0,1,2,3,4,5,6,7,8,9]

def shakersort1(a):
    l,r = 0,len(a)-1
    i = l
    j = r
    while l < r:
        if a[i] > a[i+1]: a[i], a[i+1] = a[i+1], a[i]
        if a[j-1] > a[j]: a[j-1], a[j] = a[j], a[j-1]
        i += 1
        j -= 1
        if i > r-1:
            l += 1
            r -= 1
            i = l
            j = r
    return a
assert shakersort1([9,8,7,6,5,4,3,2,1,0]) == [0,1,2,3,4,5,6,7,8,9]