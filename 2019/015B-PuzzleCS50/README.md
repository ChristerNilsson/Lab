# Fifteen Puzzle 

[Harvard CS50](https://www.youtube.com/watch?v=XAisU3eJ9Nw)

[Github](https://github.com/coderigo17/game_of_fifteen)

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

1) Creating a problem with shuffle() does not consider
  * Leaving the 4x4 box
  * Undoing a previous move
  * This makes the problem a lot easier as the solution will be shorter.
  
2) Making the variable searched a dictionary instead of a list, increases speed.

3) 1D board is quicker than a 2D. No deepcopy() needed.

4) move_*() replaced by one function.

5) function successors() simplified

6) A* with a priority queue is needed if you want a speedy solution

7) Variable fringe simplified. Everything stored in board now.

8) Binary tree shown in video is not relevant for explaining a simple queue. No heap used.

## Changes:

1) Using letters A-O instead of 1-15

2) 
