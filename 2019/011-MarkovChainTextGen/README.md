# MarkovChainTextGen

https://eli.thegreenplace.net/2018/elegant-python-code-for-a-markov-chain-text-generator/

Min variant av choose() använder Array istället för Hash.
Den är dubbelt så snabb, även jämfört med Python.

Koranen processas på ett par sekunder

Frekvensberäkning finns. Beräknar fanout.

Exempel:

N=4 CHARS = 200000

Ett state består av fyra tecken.

1 24576 # 24576 states följs av exakt ett tecken. Ingen slump här. T ex gröd ['a']
2 7341  # 7341 states följs av två tecken. t ex 'mödo' ['r', 'r', 's']
3 3410  # t ex ' möd' ['o', 'a', 'a', 'r', 'a', 'r', 'a', 'r', 'r', 'a', 'a', 'a', 'a', 'r', 'r', 'o', 'o']
4 1975
5 1431
6 948
7 696
8 552
9 494
10 286
11 690
12 134
13 98
14 91
15 65
16 64
17 56
18 51
19 39
20 53
21 52
22 38
23 37
24 26
25 22
26 19
27 28
28 16
29 15
30 15
31 8
32 10 # 10 states följs av 32 olika tecken.
33 6
34 5
35 3
37 5
38 3
39 1
40 1
42 1
45 2
46 1

