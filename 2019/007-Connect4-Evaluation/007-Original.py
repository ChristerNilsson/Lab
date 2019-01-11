import time

from minimax import Minimax
from simplerandom import SimpleRandom
from montecarlo import MonteCarlo
from human import Human

def fight(n,strategy0,strategy1):

	stats = [0,0,0,0]

	for i in range(n):
		turn = 0 # random.randint(0,1)
		strategy0.reset(0)
		strategy1.reset(1)

		strategy0.print()

		while True:

			start = time.perf_counter()

			if turn%2 == 0:
				col = strategy0.findMove()
				if col != None:
					strategy0.move(col,turn)
					strategy1.move(col,turn)
				if strategy0.winning_move(0):
					stats[0] += 1
					break
				if len(strategy0.moves) == 42: break

			else: # turn%2 == 1
				col = strategy1.findMove()
				if col != None:
					strategy0.move(col,turn)
					strategy1.move(col,turn)
				if strategy1.winning_move(1):
					stats[1] += 1
					break
				if len(strategy1.moves) == 42: break

			stats[2 + turn%2] += time.perf_counter() - start
			if n==1: strategy1.print()

			turn += 1

		strategy1.print()
		print()
		print(stats[0],stats[1],"{:.6f}".format(stats[2]),"{:.6f}".format(stats[3]))

#fight(10, MonteCarlo(1), MonteCarlo(1))
#fight(10, SimpleRandom(),SimpleRandom())
fight(10, MonteCarlo(20), Minimax(5))
#fight(1, Human(), Minimax(6))

# r = SimpleRandom()
# r.load([0,6,1,5,2,4,3])
# assert r.winning_move() == True
# r.reset(1)
# r.load([0,6,1,5,2,4,3])
# assert r.winning_move() == False

#fight(1000, Random(), Random())
#fight(100, MonteCarlo(0.00001), Random()) # Vinner 99-100 av 100, oberoende av tid?
#fight(1, MonteCarlo(0.1),MonteCarlo(0.1)) # Vinner 99-100 av 100, oberoende av tid?
