# 024

## Jämförelse mellan några olika språk.

fib(46) == 2971215073

```code
Språk             Rekursiv   Iterativ   Kommando
Nim:               1.072 s   22 nanos   nim cpp -d:release -r fib.nim
C++:               4.374 s   19 nanos   c++ -O3 fib.cpp
Javascript:       57.231 s   10 micros
Python 3:        708.145 s    5 micros  python fib.py
```

Se även https://github.com/drujensen/fib
