# -*- coding: utf-8 -*-

# anropas t ex play c4 monte_carlo # Då spelas ett parti mot en människa
# play c4 Pelle1 Robot1 innebär att en match spelas mellan dessa två robotar med 100 partier
# play c4 Pelle1 Robot1 1000 innebär att en match spelas mellan dessa två robotar med 1000 partier
# play c4 A B C D innebär att alla möter alla.

# Bygger på att man dynamiskt kan ladda programkod.

# c4modulo c4random c4findwinner

import sys
import time

GAMES = 1
#SHOW = False
SHOW = True

import c4 as engine
from board import Board

def single_game(robot, logfile):
    print 'You will play against ' + robot.name
    board = Board()
    board.display()
    while True:
        command = input('Command:')
        m = int(command)
        board.move(m)
        print board.display(),
        logfile.write(board.display())
        if board.calc():
            print "You Win"
            break
        m = robot.move(board)
        board.move(m)
        if board.calc():
            print "You Lose"
            break
        print board.display()
        logfile.write(board.display())

def match(engine, result, a, b, logfile):
    for i in range(GAMES):
        res = engine.game(a,b,logfile)
        result[res] += 1
        res = engine.game(b,a,logfile)
        result[res] += 1

robots = []
for arg in sys.argv[1:]:
    klass = __import__(arg)
    robots.append(klass.Player())

logfile = open('log.txt', 'w')

if len(robots) == 1:
    single_game(robots[0], logfile)
else:
    start = time.clock()
    engine = engine.Engine(False)
    #engine = engine.Engine(True)
    result = {'draw': 0}
    arr = {}
    for robot1 in robots:
        arr[robot1.player] = 0
        for robot2 in robots:
            if robot1 != robot2:
                result[robot1.player + '-' + robot2.player] = 0
    for robot1 in robots:
        for robot2 in robots:
            if robot1 != robot2:
                match(engine, result, robot1, robot2, logfile)

    logfile.write("\n")
    keys = sorted(result.keys())
    for key in keys:
        if key != 'draw':
            arr[key.split('-')[0]] += result[key]
        logfile.write(key + ' ' + str(result[key]) + "\n")
    logfile.write("\n")
    for key in arr:
        logfile.write(key + ' ' + str(arr[key]) + "\n")
    logfile.write("\n")
    logfile.write(str(time.clock()-start))

logfile.close()