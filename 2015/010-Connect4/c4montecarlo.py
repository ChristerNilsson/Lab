# -*- coding: utf-8 -*-
#from board import Board

# Spela ett antal partier till slutet, slumpmässigt
# Välj det drag som ger flest vinster minus förluster
# todo Låt spelaren tänka 1 sekund. Idag går spelet fortare i slutet.

# mot FindWinner
# MonteCarlo vinner 100 av 100.   (n=7*70) 39 sek
# MonteCarlo vinner 199 av 200.   (n=7*70) 84 sek
# MonteCarlo vinner 1987 av 2000. (n=7*70) 816 sek

PROBES = 500


class Player(object):

    def __init__(self, name='MonteCarlo'):
        self.name = name

    def play_complete(self, b):
        while True:
            marker = b.last_marker()
            m = b.rand()
            if len(b.board[m]) < 6:
                b.move(m)
                if b.calc() is True:
                    return marker
            if len(b.moves) == 42:
                return "draw"


    def move(self,board):
        arr = [0,0,0,0,0,0,0]
        marker = board.last_marker()
        lst = [m for m in range(7) if len(board.board[m]) < 6]
        if len(lst) == 1:
            return lst[0]
        for m in lst:
            for i in range(PROBES):
                b = board.copy()
                b.move(m)
                if b.calc():
                    return m
                mrkr = self.play_complete(b)
                if mrkr == marker:
                    arr[m] += 1
                elif mrkr != 'draw':
                    arr[m] -= 1
        bestm = lst[0]
        best = arr[bestm]
        for m in lst:
            if arr[m] > best:
                bestm = m
                best = arr[m]
        return bestm

