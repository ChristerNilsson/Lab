def f(slag):
    totalt = 0
    for i in range(len(slag)):
        s = min(7,slag[i])
        par = 2 if i%2==0 else 3
        totalt += s - par
    return totalt

# 6
# 1 9 1 1 1 1
import sys
for i,line in enumerate(sys.stdin):
    if i == 1:
        lst = map(int, line.split(' '))

print f(lst)

# assert f([5,3,1]) == 2
# assert f([1,9,1,1,1,1]) == -3


