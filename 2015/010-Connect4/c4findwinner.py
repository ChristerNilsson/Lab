# -*- coding: utf-8 -*-

# Försök hitta draget som vinner direkt.
# Finns inget sådant, slumpa.

class FindWinner(object):
    def __init__(self, name):
        self.name = name

    def move(self, board):
        b = board
        for m in range(7):
            b.move(m)
            if b.calc():
                b.undo()
                return m
            b.undo()
        return board.rand()
