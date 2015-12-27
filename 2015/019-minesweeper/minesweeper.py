# -*- coding: utf-8 -*-

# https://gist.github.com/mohd-akram/3057736
# A command line version of Minesweeper

import random
import re
import time
from string import ascii_lowercase

def setupgrid(gridsize, start, numberofmines):
    emptygrid = [['0' for i in range(gridsize)] for i in range(gridsize)]
    mines = getmines(emptygrid, start, numberofmines)
    for i, j in mines:
        emptygrid[i][j] = 'X'
    grid = getnumbers(emptygrid)
    return (grid, mines)

def showgrid(grid):
    gridsize = len(grid)
    toplabel = '   '
    for i in ascii_lowercase[:gridsize]:
        toplabel += i + ' '
    print(toplabel)

    for idx, i in enumerate(grid):
        nr = '{0:2}'.format(idx + 1)
        row = nr
        for j in i:
            z = len(j)
            row += ' ' + j.replace(' ','.') # + ' |'
        print(row + ' ' + nr)
    print(toplabel)

def getrandomcell(grid):
    gridsize = len(grid)
    a = random.randint(0, gridsize - 1)
    b = random.randint(0, gridsize - 1)
    return (a, b)

def getneighbors(grid, rowno, colno):
    gridsize = len(grid)
    neighbors = []
    for i in range(-1, 2):
        for j in range(-1, 2):
            if i == 0 and j == 0:
                continue
            elif -1 < (rowno + i) < gridsize and -1 < (colno + j) < gridsize:
                neighbors.append((rowno + i, colno + j))
    return neighbors

def getmines(grid, start, numberofmines):
    mines = []
    neighbors = getneighbors(grid, *start)
    for i in range(numberofmines):
        cell = getrandomcell(grid)
        while cell == start or cell in mines or cell in neighbors:
            cell = getrandomcell(grid)
        mines.append(cell)
    return mines

def getnumbers(grid):
    for rowno, row in enumerate(grid):
        for colno, cell in enumerate(row):
            if cell != 'X':
                values = [grid[r][c] for r, c in getneighbors(grid, rowno, colno)]
                grid[rowno][colno] = str(values.count('X'))
    return grid

def showcells(grid, currgrid, rowno, colno):
    if currgrid[rowno][colno] != ' ':
        return
    currgrid[rowno][colno] = grid[rowno][colno]
    if grid[rowno][colno] == '0':
        for r, c in getneighbors(grid, rowno, colno):
            if currgrid[r][c] != 'F':
                showcells(grid, currgrid, r, c)

def playagain():
    choice = input('Play again? (y/n): ')
    return choice.lower() == 'y'

def parseinput(inputstring, gridsize, helpmessage):
    cell = ()
    flag = False
    message = "Invalid cell. " + helpmessage
    pattern = r'([a-{}])([0-9]+)(f?)'.format(ascii_lowercase[gridsize - 1])
    validinput = re.match(pattern, inputstring)
    if inputstring == 'help':
        message = helpmessage
    elif validinput:
        rowno = int(validinput.group(2)) - 1
        colno = ascii_lowercase.index(validinput.group(1))
        flag = bool(validinput.group(3))
        if -1 < rowno < gridsize:
            cell = (rowno, colno)
            message = ''
    return {'cell': cell, 'flag': flag, 'message': message}

def playgame():
    gridsize = 26  # MAX = 26
    numberofmines = gridsize*gridsize/5
    currgrid = [[' ' for i in range(gridsize)] for i in range(gridsize)]
    grid = []
    flags = []
    starttime = 0
    helpmessage = ("Type the column followed by the row (eg. a5). "
                   "To put or remove a flag, add 'f' to the cell (eg. a5f).")

    print(helpmessage + " Type 'help' to show this message again.\n")
    showgrid(currgrid)

    while True:
        minesleft = numberofmines - len(flags)
        prompt = raw_input('Enter the cell ({} mines left): '.format(minesleft))
        result = parseinput(prompt, gridsize, helpmessage + '\n')

        message = result['message']
        cell = result['cell']

        if cell:
            rowno, colno = cell
            currcell = currgrid[rowno][colno]
            flag = result['flag']

            if not grid:
                grid, mines = setupgrid(gridsize, cell, numberofmines)
            if not starttime:
                starttime = time.time()

            if flag:
                # Add a flag if the cell is empty
                if currcell == ' ':
                    currgrid[rowno][colno] = 'F'
                    flags.append(cell)
                # Remove the flag if there is one
                elif currcell == 'F':
                    currgrid[rowno][colno] = ' '
                    flags.remove(cell)
                else:
                    message = 'Cannot put a flag there'

            elif cell in flags:
                message = 'There is a flag there'

            elif grid[rowno][colno] == 'X':
                print('Game Over\n')
                showgrid(grid)
                if playagain():
                    playgame()
                return

            elif currcell == ' ':
                showcells(grid, currgrid, rowno, colno)

            else:
                message = "That cell is already shown"

            if set(flags) == set(mines):
                minutes, seconds = divmod(int(time.time() - starttime), 60)
                print(
                    'You Win. '
                    'It took you {} minutes and {} seconds.\n'.format(minutes,
                                                                      seconds))
                showgrid(grid)
                if playagain():
                    playgame()
                return

        showgrid(currgrid)
        print(message)

playgame()