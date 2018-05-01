# 028-TaiwaneseRemainder

Använd exakt det antal steg som föreslås.

Se till att alla visarna står rakt upp.

Klick på klocka tickar alla klockor de tick denna klocka har. 

Klick på andra kolumnen tar bort ett klick på denna klocka.

Klick på reset återställer.

Klick på ok skapar ett nytt problem.

Klick på link visar en url som kan kopieras för detta problem. 

## Manuell lösning

### Fas 1

* Första kolumnen innehåller klockorna. (t ex 7,11)
* Andra kolumnen innehåller initial vridning, räknat moturs från visaren till klockan tolv. (5,7)
* Addera tills alla klockorna visar samma värde. (40,40)
  * 7  | 5 12  19 26 33 40
  * 11 |  7  18     29  40

### Fas 2

* Betrakta 7 och 11 som myntvalörer.
* Använd det antal mynt som ges av stegantalet. Låt oss välja 4 i detta exempel.
* Bilda summan 40.
* Initialt kan man använda t ex 40 delat med 11, vilket blir 3.64, avrundat 4.
  * 7 11 | 40
  * 0  4 | Fyra elvor = 44. Flytta ett mynt från 11 till 7.
  * 1  3 | En sjua + tre elvor = 40
* Lösningen består alltså i att klicka på 7 en gång och 11 tre gånger.
* Ordningen spelar ingen roll.

## Lösning med hjälp av Wolfram Language

Vi använder oss av dessa båda funktioner:
* [ChineseRemainder](https://reference.wolframcloud.com/cloudplatform/ref/ChineseRemainder.html)
* [KnapsackSolve](https://reference.wolframcloud.com/cloudplatform/ref/KnapsackSolve.html)

* Gå in på [Wolfram Language](https://wolfr.am/wpl-eiwl)
* File | New Notebook

### Fas 1

* Klistra in ChineseRemainder[{5,7},{7,11}]
* shift-Enter
* Nu ska du se svaret 40

### Fas 2

* Klistra in KnapsackSolve[{{7,1},{11,1}},{40,4}]
* shift-Enter
* Nu ska du se svaret {1, 3} 
* En sjua + tre elvor = 40

## Programmerad lösning

### Fas 1

När du behärskar den manuella lösningen: skriv funktionen solve som beräknar minsta möjliga total!

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

### Fas 2

Skriv därefter en funktion som packar en kappsäck exakt.

* assert [1,3], knapsack [7,11],40 # 4 steg 
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
