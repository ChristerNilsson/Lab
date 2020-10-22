# 028-TaiwaneseRemainder

[Try it!](https://christernilsson.github.io/Lab/2018/028-TaiwaneseRemainder/index.html)

Use exactly the number och steps shown.

Make all hands point north (twelve o'clock)

Clock on a clock ticks all clocks the number of ticks this clock has.

Click on the number to the right undoes the click

Reset undoes all clicks

Clicking ok produces a new challenge.

Klicking "link" shows an url that can be copied.

A solution will be available after steps minutes.
It shows the number of clicks per clock.

Combinations shows the number of combinations.
* Example:
* Clocks: 2 and 3
* Steps: 2
* Combinations: 2+2=4, 2+3=5 and 3+3=6, that is three combinations.

## Solution using Wolfram Language

Use these functions
* [ChineseRemainder](https://reference.wolframcloud.com/cloudplatform/ref/ChineseRemainder.html)
* [KnapsackSolve](https://reference.wolframcloud.com/cloudplatform/ref/KnapsackSolve.html)

* Go to [Wolfram Language](https://wolfr.am/wpl-eiwl)
* File | New Notebook

### Phase 1

* Paste ChineseRemainder[{5,7},{7,11}]
* shift-Enter
* Now you will see the number 40

### Phase 2

* Paste KnapsackSolve[{{7,1},{11,1}},{40,4}]
* shift-Enter
* Now you will see the answer {1, 3} 
* 1 * 7 + 3 * 11 = 40

## Programming Exercise

### Phase 1

Write the function solve. It calculates the minimal total!

* assert 40, solve [7,11],[5,7]
* assert 23, solve [3,5,7],[2,3,2]
* assert 0, solve [3,11],[0,0] # 0 step
* assert 11, solve [3,11],[2,0] # 1 step (11 + 33k == 77)
* assert 4, solve [2,13],[0,4] # 2 
* assert 5, solve [2,5],[1,0] # 3 (5+10k == 15)
* assert 26, solve [5,11],[1,4] # 4 
* assert 55, solve [2,11,17],[1,0,4] # 5
* assert 48, solve [2,7,11],[0,6,4] # 6
* assert 129, solve [3,17,19],[0,10,15] # 7
* assert 132, solve [3,13,17],[0,2,13] # 8
* assert 93, solve [5,11,17],[3,5,8] # 9
* assert 174, solve [5,11,13,19],[4,9,5,3] # 10
* assert 189, solve [5,7,13,19],[4,0,7,18] # 11
* assert 178, solve [2,7,13,17],[0,3,9,8] # 12

### Phase 2

Write the function knapsack, packing a knapsack perfect.

* assert [1,3], knapsack [7,11],40 # 4 steps
* assert [3,0,2], knapsack [3,5,7],23 # 
* assert [0,1], knapsack [3,11],11 # 1 step
* assert [2,0], knapsack [2,13],4 # 2	
* assert [0,3], knapsack [2,5],15 # 3		OBS: k=1
* assert [3,1], knapsack [5,11],26 # 4
* assert [2,0,3], knapsack [2,11,17],55 # 5	
* assert [2,0,4], knapsack [2,7,11],48 # 6	
* assert [0,2,5], knapsack [3,17,19],129 # 7	
* assert [0,1,7], knapsack [3,13,17],132 # 8
* assert [5,0,4], knapsack [5,11,17],93 # 9		
* assert [0,2,0,8], knapsack [5,11,13,19],174 # 10
* assert [1,0,1,9], knapsack [5,7,13,19],189 # 11
* assert [0,1,4,7], knapsack [2,7,13,17],178 # 12 
