# Fifteen Puzzle 

[Harvard CS50](https://www.youtube.com/watch?v=XAisU3eJ9Nw)

[Github](https://github.com/coderigo17/game_of_fifteen)

[Korf 1985 Depth-First Iterative-Deepening: An Optimal Admissible Tree Search](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.91.288&rep=rep1&type=pdf)

[Korf 2004 Additive Pattern Database Heuristics](https://www.aaai.org/Papers/JAIR/Vol22/JAIR-2209.pdf)

[Korf 2008 Linear-Time Disk-Based Implicit Graph Search](https://www.cs.helsinki.fi/u/bmmalone/heuristic-search-fall-2013/Korf2008.pdf)

[Culberson+Schaeffer 1994 Efficiently Searching the 15-Puzzle](https://pdfs.semanticscholar.org/d8d7/0958abc0bcd75640c6d5b8bd01a4a89688a2.pdf)

[Gasser 1995](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.39.6069&rep=rep1&type=pdf)

[Borowski](http://brian-borowski.com/software/puzzle/)

[yuvallb 2016 Solving the 15-tile puzzle using MM search](https://github.com/yuvallb/15-puzzle-solver-MM-search)

[mwong510ca](https://github.com/mwong510ca/15Puzzle_OptimalSolver)

## Keys

* ESC = quit
* Four Arrow Keys 
* shift = solve

## Goal

    A B C D
    E F G H
    I J K L 
    M N O •
    
## Critic

* Creating a problem with shuffle() does not consider
  * Leaving the 4x4 box
  * Undoing a previous move
  * This makes the problem a lot easier as the solution will be shorter.
  
* Making the variable searched a dictionary instead of a list, increases speed.

* 1D board is quicker than a 2D. No deepcopy() needed.

* move_*() replaced by one function.

* function successors() simplified

* A* with a priority queue is needed if you want a speedy solution

* Variable fringe simplified. Everything stored in Board now.

* Binary tree shown in video is not relevant for explaining a simple queue. No heap used.

* There is no reason to store the constant goal in each and every Board instance.

## Changes:

* Using letters A-O instead of 1-15

## Sample timings

~~~~
N        10  12   14   16    18     20
Without 240 930 3109 1944 20704 298869 ms
With A*   2   4    4    6     8     11 ms   
~~~~

## IDA* with Pattern Database

N             41    51    53    57     61     63     65    80
MD java  
PD java       15    31    46    31    989    579    297 ms
MD python
PD python  0.065 0.596 1.232 1.981 76.166 67.353 33.505 secs  
