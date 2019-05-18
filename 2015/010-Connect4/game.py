from human import *
from c4findwinner import *
from c4random import *
from c4modulo import *
from c4montecarlo import *
import board

x = Human('Christer')
#o = Human('Bertil')

#x = Random('Xerxes')
#o = Random('Olle')

#x = Modulo('Xerxes')
#o = Modulo('Olle')

#x = FindWinner('Xerxes')
#o = FindWinner('Olle')

#x = MonteCarlo('Xerxes')
#o = MonteCarlo('MonteCarlo')
o = Player('MonteCarlo')

board = board.Board()
print(board.display())

while True:
    m = x.move(board)
    board.move(m)
    print(board.display())
    if board.calc():
        print(x.name + " vann!")
        break

    m = o.move(board)
    board.move(m)
    print(board.display())
    if board.calc():
        print(o.name + " vann!")
        break

    if len(board.moves) == 42:
        print('remi!')
        break

