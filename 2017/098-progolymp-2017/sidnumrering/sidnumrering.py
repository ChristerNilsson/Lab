def f(n):
    digits = [0] * 10
    for i in range(1,n+1):
        if i%2 == 1:
            s = str(i)
            for digit in s:
                digits[int(digit)] += 1
    return ' '.join(str(x) for x in digits)

# 82056
import sys
for i,line in enumerate(sys.stdin):
    if i == 0:
        n = int(line)

print f(n)

# assert f(23) == '0 8 2 3 0 2 0 2 0 2'
# assert f(306) == '13 96 65 49 15 46 15 45 15 45'
# assert f(82056) == '12178 25911 17233 25411 17205 25409 17200 25405 13228 20405'

