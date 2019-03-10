# Hash Code

Inspiration for this code can be found here: https://github.com/danieleratti/hashcode-2019

* bb.out contains all photos with their neighbours
* Is used to improve the solution for b. 
* Normal value before 2opt is 205.000.
* Maximum is 240.000 - 3.

* tsp.py reads bb.out and writes bbb.out
* tsp.py uses 2-opt to improve the result by greedy neighbours
* Estimated execution time: 2.5 hours per round.
* Please note: 2-opt does not warrant global optimum.

## Timings for e

First row of 80.000. 

```code
C++:     6 secs  c++ -O3 tspc.cpp
Python: 11 secs  python tspc.py
Nim:    23 secs  nim c --checks:off --opt:speed -r tspc.nim
```
## Problem set:
* Average number of tags per photo
* Frequency statistics of number of tags per photo.

```code
b:
18.0
9 4002
12 11840
15 17922
18 18045
21 13506
24 7993
27 4006
30 1738
33 664
36 193
39 69
42 15
45 6
51 1

c:
9.476
4 2
5 90
6 102
7 118
8 88
9 109
10 91
11 99
12 109
13 100
14 92

d:
10.025
1 1
2 241
3 5503
4 5660
5 5845
6 5737
7 5988
8 6066
9 6236
10 6298
11 6297
12 6553
13 6645
14 6445
15 6146
16 5114
17 3466
18 1446
19 313

e:
19.1
8 6
9 358
10 4066
11 4055
12 4074
13 4191
14 4246
15 4128
16 4158
17 4171
18 4150
19 4039
20 4146
21 4171
22 4140
23 4183
24 4226
25 4223
26 4091
27 4035
28 3422
29 1721
```