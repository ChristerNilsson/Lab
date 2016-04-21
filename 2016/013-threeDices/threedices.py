# -*- coding: utf-8 -*-

# Problem: https://www.youtube.com/watch?v=xHh0ui5mi_E

def Christer():
    result = [0] * 13
    for i in range(1,7):
        for j in range(1,7):
            for k in range(1,7):
                arr = [i,j,k]
                arr.sort()
                s = sum(arr)
                #      3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
                res = [6,4,6,7,4,5,6, 7, 8, 9,11,10, 3, 2, 3, 6][s-3]
                if arr == [1,1,3]: res = 5  # 5
                if arr == [2,2,2]: res = 3  # 6
                if arr == [4,4,4]: res = 3  # 12
                if arr == [3,5,5]: res = 10 # 13
                if arr == [2,5,6]: res = 12 # 13
                if arr == [3,6,6]: res = 8  # 15
                result[res] += 1
    assert result[2:] == [6, 12, 18, 24, 30, 36, 30, 24, 18, 12, 6]

def Christer2():
    result = [0] * 13
    dice = range(1,7)
    for arr in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = sum(arr)
        uniq = list(set(arr))
        res = 7
        if len(uniq) == 2: res = [7,6,7,7,4,4,5,6,8,9,10,10,7,7,8,7][s-3]
        elif len(uniq) == 3: res = [7,2,3,5,6,8,9,11,12,7,7,8,7][s-6]
        result[res] += 1
    assert result[2:] == [6,12,18,24,30,36,30,24,18,12,6]

# Solution by Matt Stuart: https://www.youtube.com/watch?v=dz3cu9T3fSE&nohtml5=False
def MattStuart():
    result = [0] * 13
    dice = range(1,7)
    for arr in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = sum(arr)
        uniq = list(set(arr))
        for x in uniq: arr.remove(x)
        res = 7
        if len(uniq) == 3: res = [2,5,3,4,5,9,10,11,9,12][s-6]
        elif len(uniq) == 2: res = [0,6,6,7,7,8,8][arr[0]]
        result[res] += 1
    assert result[2:] == [6,12,18,24,30,36,30,24,18,12,6]

# MathAHA https://www.youtube.com/watch?v=6_7IILF9m5A&feature=youtu.be
def MathAHA():
    result = [0] * 13
    dice = range(1,7)
    for arr in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = sum(arr)
        uniq = list(set(arr))
        for x in uniq: arr.remove(x)
        res = 7                  #6 7 8 9 10 11 12 13 14 15
        if len(uniq) == 3: res = [2,9,3,9, 4,10, 5,11, 5,12][s-6]
        elif len(uniq) == 2: res = [0,6,6,7,7,8,8][arr[0]]
        result[res] += 1
    assert result[2:] == [6,12,18,24,30,36,30,24,18,12,6]
MathAHA()

def Herring():
    result = [0] * 13
    for i in range(1,7):
        for j in range(1,7):
            for k in range(1,7):
                arr = [i,j,k]
                #arr.sort()
                s = sum(arr)
                uniq = list(set(arr))
                #      3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
                res = [0,3,2,3,4,6,5, 0, 0, 9, 8,10,11,12,11, 0][s-3]
                if uniq == [1]: res = 4
                if uniq == [2]: res = 4
                if uniq == [3]: res = 4
                if uniq == [4]: res = 10
                if uniq == [5]: res = 10
                if uniq == [6]: res = 10
                if s == 10:
                    if len(uniq) == 3:
                        res = 7
                    else:
                        res = 6
                if s == 11:
                    if len(uniq) == 3:
                        res = 7
                    else:
                        res = 8
                result[res] += 1
    assert result[2:] == [6, 12, 18, 24, 30, 36, 30, 24, 18, 12, 6]
Herring()

# Sort the dice from low to high as ABC (e.g. 114, 245, 366, ...).
# Add [(A+B)mod 6] + [(B+C) mod 6] + 2, and there it is.﻿
def LucStLouis():
    result = [0] * 13
    dice = range(1,7)
    for a,b,c in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        res = (a+b)%6 + (b+c)%6 + 2
        result[res] += 1
    print result[2:]
    print[6,12,18,24,30,36,30,24,18,12,6]

def gliaMe():
    result = [0] * 13
    dice = range(1,7)
    for a,b,c in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        res = a+c
        result[res] += 1
    print result[2:]
    print[6,12,18,24,30,36,30,24,18,12,6]

def SandshrewSamurai():
    result = [0] * 19
    dice = range(1,7)
    for a,b,c in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        n = a+b+c
        res = n - (n%6)
        #print a,b,c,n,res
        result[res] += 1
    #print result[2:]
    #print[6,12,18,24,30,36,30,24,18,12,6]
SandshrewSamurai()

def OcieMitchell():
    result = [0] * 19
    dice = range(1,7)
    for arr in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = sum(arr)
        res = s - s % arr[s%3]
        print arr,res
        result[res] += 1
    print result[2:]
    print [6,12,18,24,30,36,30,24,18,12,6]

def SmokeFumus():
    result = [0] * 13
    dice = range(1,7)
    for arr in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = sum(arr)
        res = int(round(s / 18.0 * 12))
        result[res] += 1
#    print result[2:]
#    print[6,12,18,24,30,36,30,24,18,12,6]

def MichielVanLeeuwen():
    result = [0] * 13
    dice = range(1,7)
    for arr in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = sum(arr)
        res = s - s/3
        result[res] += 1
    assert  result[2:] == [1, 3, 16, 15, 46, 27, 52, 21, 25, 6, 4]

MichielVanLeeuwen()

#Eugenio Guzmán
#For dice a, b, and c suppose a ≤ b ≤ c. If (a+b+c) mod 3 is 0, mark die a. If it is 1, mark die b. If it is 2, mark die c. If the two unmarked dice add up to a value whose mod 2 is 0, mark the lowest die of the two. If it is 1, mark the highest die of the two. Your outputs are the two marked dice.
def Guzman():
    result = [0] * 13
    dice = range(1,7)
    for a,b,c in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        s = a+b+c
        if s%3==0:
            mark = a
            unmark = [b,c]
        if s%3==1:
            mark = b
            unmark = [a,c]
        if s%3==2:
            mark = c
            unmark = [a,b]
        if sum(unmark)%2==0:
            res = mark+unmark[0]
        elif sum(unmark)%2==1:
            res = mark+unmark[1]
        result[res] += 1
    assert result[2:] == [4, 9, 25, 21, 31, 36, 25, 27, 28, 3, 7]
Guzman()

# ( ( 6^0*(a-1) + 6^1*(b-1) + 6^2*(c-1) ) mod 6 ) + 1﻿
def Gray():
    result = [0] * 13
    dice = range(1,7)
    for a,b,c in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        res = ( 1*(a-1) + 6*(b-1) + 36*(c-1) ) % 6 + 1
        result[res] += 1
    assert result[2:] == [61, 37, 19, 7, 1, 0, 0, 0, 0, 0, 0]
Gray()

def Dixon():
    result = [0] * 13
    dice = range(1,7)
    for a,b,c in [sorted([i,j,k]) for i in dice for j in dice for k in dice]:
        res = (13 * (a+b+c)) % 11 + 2
        result[res] += 1
    assert result[2:] == [27, 13, 25, 16, 21, 21, 16, 25, 13, 27, 12]
Dixon()