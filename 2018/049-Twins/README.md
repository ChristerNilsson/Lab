# 049-Twins

[Twins](http://www.novelgames.com/en/twins/)

## Rules
* Make pairs with the same Sum
* The Sum is found at the bottom of the screen
* Level = Sum
* The path must make zero, one or two 90 degrees turns
* Wrapping wraps around horizontal and vertical edges
* Wrapping costs one life
* Pairing without a path costs two lives

## Information
* Green star = Free pair available
* White number = Numbers left
* Less Than = First Level
* Minus = Previous Level
* Level
* Plus = Next Level
* Greater Than = Last Level
* Time in seconds
* Red star = Wrapping pair available
* Clicking on frame toggles it

## Example 
```
. . . . . . . 
. 7 0 x x x .
. . . . . . . 
. . 1 x 2 x .
. x x 4 x 3 .
. x x x x x .
. . . . . . .
```

* 7-0 = 0 turns. Free 
* 7-1 = 1 turn. Free  
* 7-2 = 2 turns. Free 
* 7-3 = 2 turns using Wrap. One Life
* 7-4 = No connection. Two lives