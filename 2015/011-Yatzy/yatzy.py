# -*- coding: utf-8 -*-

import random
from collections import Counter as mset
import optimal

LETTERS = 'abcdefghijklmno'
NAMES = '1or 2or 3or 4or 5or 6or 1par 2par 3tal 4tal 1..5 2..6 hus chans yatzy'.split(' ')

class Robot(object):
    def move(self, yatzy, dices, selection):
        pass

class Yatzy(object):
    def __init__(self):
        self.state = [''] * 15  # '' innebär möjlig.  0 innebär struken
        self.selected = []  # 1..6, sparade tärningar
        self.oy = optimal.OptimizeYatzy()

    def free(self):
        lst = [item for item in self.state if item == '']
        return len(lst) > 0

    def total_score(self):
        bonus = 0
        if sum(self.state[0:6]) >= 63:
            bonus = 50
        return bonus + sum(self.state)

    def display(self):
        r = ''
        s = ''
        t = ''
        for letter in LETTERS:
            r += letter.rjust(6)
        for name in NAMES:
            s += name.rjust(6)
        for score in self.state:
            t += str(score).rjust(6)
        return '\n' + r + '\n' + s + '\n' + t

    def signatur(self,lst):
        arr = self.occurs(lst)
        arr = sorted(arr)
        arr = [str(item) for item in arr if item > 0]
        return ''.join(arr)

    def occurs(self,lst):
        arr = [0] * 7
        for x in lst:
            arr[x] += 1
        return arr

    def limit(self, occurs, n):
        return [i for i in range(len(occurs)) if occurs[i] >= n]

    def calc(self, selected, s):
        i = LETTERS.index(s)
        occurs = self.occurs(selected)
        signatur = self.signatur(selected)

        if 'a' <= s <= 'f':  # 1or 2or 3or 4or 5or 6or
            return selected.count(i+1) * (i+1)
        if s == 'g':  # 1par
            arr = self.limit(occurs,2)
            if arr:
                return 2 * arr[-1]
        if s == 'h':  # 2par
            if signatur == '122' or signatur == '23':
                arr = self.limit(occurs,2)
                if len(arr) >= 2:
                    return 2 * arr[-1] + 2 * arr[-2]
        if s == 'i':  # 3tal
            arr = self.limit(occurs,3)
            if arr:
                return 3 * arr[-1]
        if s == 'j':  # 4tal
            arr = self.limit(occurs,4)
            if arr:
                return 4 * arr[-1]
        if s == 'k':  # 1..5
            if selected == [1, 2, 3, 4, 5]:
                return 15
        if s == 'l':  # 2..6
            if selected == [2, 3, 4, 5, 6]:
                return 20
        if s == 'm':  # hus
            if signatur == '23':
                return sum(selected)
        if s == 'n':  # chans
            return sum(selected)
        if s == 'o':  # yatzy
            if signatur == '5':
                return 50
        return 0

    def intersect(self, a, b):  # måste kunna hantera dubletter
        return list((mset(a) & mset(b)).elements())

    def select(self):
        count = 0
        letters = ''
        for i in range(len(NAMES)):
            if self.state[i] == '':
                letters += LETTERS[i]
        while True:
            if count < 3:
                lst = self.selected[:]
                for i in range(5-len(lst)):
                    lst.append(random.randint(1, 6))
                lst = sorted(lst)
            self.dices = [str(item) for item in lst]
            self.dices = ''.join(self.dices)

            if count < 2:
                s = raw_input(self.dices + ' Välj tärningar: ')
                self.robot(count,s)
            else:
                s = raw_input(self.dices + ' Välj en bokstav: ')
                self.robot(count,s)
            if len(s) == 1 and s in LETTERS:
                if len(lst) == 5:
                    self.selected = lst
                    if self.state[LETTERS.index(s)] == '':
                        self.state[LETTERS.index(s)] = self.calc(self.selected, s)
                        return
            else:
                tmp = [int(dice) for dice in list(s)]
                self.selected = self.intersect(tmp, lst)
                count += 1

    def robot(self, count, human):  # Denna anropas för varje tärningskast.
        categories = 0
        for i in range(15):
            if self.state[14-i] != '':
                categories |= 1 << i
        upper_size = 0
        for i in range(6):
            if self.state[i] != '':
                upper_size += self.state[i]
        if upper_size > 63:
            upper_size = 63
        # print 'count',count,'dices',self.dices,'categories', categories, 'upper_size',upper_size
        data = self.oy.storage(count, self.dices, categories, upper_size)
        text = ''
        if count < 2:
            for i in range(5):
                if (data & 1 << i) != 0:
                    text = self.dices[4-i] + text
            if human != text:
                text += ' OLIKA!'
        else:
            text = LETTERS[data] + ' (' + NAMES[data] + ')'
            if human != LETTERS[data]:
                text += ' OLIKA!'
        print 'Robot:', text


yatzy = Yatzy()

assert yatzy.occurs([1,2,3,4,5]) == [0,1,1,1,1,1,0]
assert yatzy.occurs([1,2,2,4,5]) == [0,1,2,0,1,1,0]
assert yatzy.occurs([1,1,2,3,3]) == [0,2,1,2,0,0,0]
assert yatzy.occurs([1,2,2,2,6]) == [0,1,3,0,0,0,1]
assert yatzy.occurs([1,1,1,2,2]) == [0,3,2,0,0,0,0]
assert yatzy.occurs([1,2,2,2,2]) == [0,1,4,0,0,0,0]
assert yatzy.occurs([1,1,1,1,1]) == [0,5,0,0,0,0,0]

assert yatzy.signatur([1,2,3,4,5]) == '11111'
assert yatzy.signatur([1,2,2,4,5]) == '1112'
assert yatzy.signatur([1,1,2,3,3]) == '122'
assert yatzy.signatur([1,2,2,2,6]) == '113'
assert yatzy.signatur([1,1,1,2,2]) == '23'
assert yatzy.signatur([1,2,2,2,2]) == '14'
assert yatzy.signatur([1,1,1,1,1]) == '5'

assert yatzy.limit([0,1,1,1,1,1,0],2) == []
assert yatzy.limit([0,1,1,1,1,1,0],1) == [1,2,3,4,5]
assert yatzy.limit([0,1,2,0,1,1,0],2) == [2]
assert yatzy.limit([0,1,0,0,0,2,2],2) == [5,6]
assert yatzy.limit([0,1,3,0,0,0,1],3) == [2]

assert yatzy.calc([1,1,2,3,4], 'a') == 2  # 1or
assert yatzy.calc([1,1,1,1,1], 'a') == 5  # 1or

assert yatzy.calc([1,1,2,3,4], 'b') == 2  # 2or
assert yatzy.calc([1,1,3,4,5], 'b') == 0  # 2or

assert yatzy.calc([1,1,2,3,4], 'c') == 3  # 3or
assert yatzy.calc([1,1,2,3,4], 'd') == 4  # 4or
assert yatzy.calc([1,1,2,3,4], 'e') == 0  # 5or
assert yatzy.calc([6,6,6,6,6], 'f') == 30 # 6or

assert yatzy.calc([1,2,3,4,6], 'g') == 0  # 1par
assert yatzy.calc([1,1,2,3,4], 'g') == 2  # 1par
assert yatzy.calc([1,1,1,2,2], 'g') == 4  # 1par
assert yatzy.calc([1,1,2,2,2], 'g') == 4  # 1par
assert yatzy.calc([1,2,2,2,2], 'g') == 4  # 1par
assert yatzy.calc([1,1,1,1,2], 'g') == 2  # 1par
assert yatzy.calc([1,1,1,1,1], 'g') == 2  # 1par

assert yatzy.calc([1,5,6,6,6], 'h') == 0   # 2par
assert yatzy.calc([1,5,5,6,6], 'h') == 22  # 2par
assert yatzy.calc([5,5,5,6,6], 'h') == 22  # 2par
assert yatzy.calc([5,5,6,6,6], 'h') == 22  # 2par

assert yatzy.calc([1,1,5,6,6], 'i') == 0   # 3tal
assert yatzy.calc([1,1,6,6,6], 'i') == 18  # 3tal

assert yatzy.calc([5,5,6,6,6], 'j') == 0   # 4tal
assert yatzy.calc([5,6,6,6,6], 'j') == 24  # 4tal
assert yatzy.calc([6,6,6,6,6], 'j') == 24  # 4tal

assert yatzy.calc([1,1,3,4,5], 'k') == 0   # 1..5
assert yatzy.calc([1,2,3,4,5], 'k') == 15  # 1..5

assert yatzy.calc([2,2,4,5,6], 'l') == 0   # 2..6
assert yatzy.calc([2,3,4,5,6], 'l') == 20  # 2..6

assert yatzy.calc([1,1,2,3,4], 'm') == 0   # hus
assert yatzy.calc([1,1,1,2,2], 'm') == 7   # hus

assert yatzy.calc([1,1,2,3,4], 'n') == 11  # chans

assert yatzy.calc([1,1,2,3,4], 'o') == 0   # yatzy
assert yatzy.calc([1,1,1,1,1], 'o') == 50  # yatzy

assert yatzy.intersect([1,2,2],[2,2,3]) == [2,2]
assert yatzy.intersect([1,2],[2,2,3]) == [2]
assert yatzy.intersect([1,2,2],[2,3]) == [2]
assert yatzy.intersect([1,2,2],[3,4]) == []

while yatzy.free() > 0:
    print yatzy.display()
    yatzy.selected = []
    yatzy.select()

print yatzy.display()
print 'Total score: ', yatzy.total_score()
