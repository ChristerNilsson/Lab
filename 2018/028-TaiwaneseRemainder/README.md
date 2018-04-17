# 028-TaiwaneseRemainder

Använd exakt det antal steg som föreslås.

Se till att alla visarna står på klockan tolv!

Klick på klocka tickar alla klockor de tick denna klocka har. 

Hitta minimalt total.

När du behärskar spelet: skriv algoritmen solve som beräknar minsta möjliga total!

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

Skriv därefter en rutin som packar en kappsäck exakt.

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

