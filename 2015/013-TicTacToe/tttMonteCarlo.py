# -*- coding: utf-8 -*-

import random

# Spela ett antal partier till slutet, slumpmässigt
# Välj det drag som ger flest vinster minus förluster
# todo Låt spelaren tänka 1 sekund. Idag går spelet fortare i slutet.

PROBES = 10

class Player(object):

    def __init__(self, name='MonteCarlo'):
        self.name = name

    def play_complete(self, b, lst):
        for key in lst:
            b.move(key)
            if b.calc() is True:
                marker = b.last_marker()
                return marker  # next

            #for k2 in lst:
            #    if k2 != key:
            #        b.move(k2)
            #        if b.calc():
            #            return b.last_marker()  # Return counter move if a winner
            #        b.undo()

        return "draw"

    def collect_all_empty_squares(self,board):
        lst = []
        for y in range(board.n):
            for x in range(board.n):
                if board.board[y][x] == ' ':
                    lst.append((x, y))
        return lst

    def move(self, board):
        arr = {}
        marker = board.last_marker()  # last
        lst = self.collect_all_empty_squares(board)

        for key in lst:
            arr[key] = 0
            for i in range(PROBES):
                b = board.copy()
                b.move(key)
                if b.calc():
                    return key  # Return first move if a winner

                for k2 in lst:
                    if k2 != key:
                        b.move(k2)
                        if b.calc():
                            return k2  # Return counter move if a winner
                        b.undo()

                candidates = lst[:]
                candidates.remove(key)
                random.shuffle(candidates)
                mrkr = self.play_complete(b, candidates)
                if mrkr == marker:
                    arr[key] += 1
                elif mrkr != 'draw':
                    arr[key] -= 1
        #print arr
        if lst == []:
            return
        bestkey = lst[0]
        best = arr[bestkey]
        for key in lst:
            if arr[key] > best:
                bestkey = key
                best = arr[key]
        print bestkey,best
        return bestkey