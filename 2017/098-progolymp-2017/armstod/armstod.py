left = []
right = []
n = 0

def evaluate(s):
    res = 0
    for i in range(n):
        if s[i]=='H' and left[i]==0 and right[i]==1: res += 1
        if s[i]=='V' and left[i]==1 and right[i]==0: res += 1
        if s[i]=='B' and left[i]==1 and right[i]==1: res += 1
        if s[i]=='A' and left[i]==0 and right[i]==1: res += 1
        if s[i]=='A' and left[i]==1 and right[i]==0: res += 1
        if s[i]=='I' and left[i]==0 and right[i]==0: res += 1
    return res

def execute(type,s):
    global left,right
    for i in range(n):
        if s[i] == type:
            l = (i-1)%n # left neighbor
            r = (i+1)%n # right neighbor
            if type=='H':
                if left[r]==0: right[i]=1
            if type=='V':
                if right[l]==0: left[i]=1
            if type=='B':
                if left[r]==0 and right[l]==0:
                    left[i]=1
                    right[i]=1
            if type=='A':
                if left[r] == 1 and right[l] == 0:
                    left[i]=1
                elif right[l] == 1 and left[r] == 0:
                    right[i]=1
    #print type, left,right

def f(s):
    global n,left,right
    n = len(s)
    #print n,s
    left = [0] * n
    right = [0] * n
    execute('V',s)
    execute('H',s)
    execute('B',s)
    execute('A',s)
    return evaluate(s)

import sys
for i,line in enumerate(sys.stdin):
    if i==1: s = line.strip()

print f(s)

# assert -1%6 == 5
# assert f('BAVIABH') == 6
# assert f('IHAVB') == 4
# assert f('BHVBABHVIBHABVV') == 11
