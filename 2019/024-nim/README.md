# 024

## Jämförelse mellan några olika språk.

fib(46) == 2971215073

```code
Språk             Rekursiv   Iterativ   Kommando
C++:               3.877 s   19 nanos   c++ -O3 fib.cpp
Nim:               4.188 s   19 nanos   nim cpp -d:release --opt:speed -r fib.nim
Javascript:       57.231 s   10 micros
Python 3:        708.145 s    5 micros  python fib.py
```

Se även https://github.com/drujensen/fib
