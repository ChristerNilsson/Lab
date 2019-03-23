# Resistor Mesh Calculator

#### Introduction

Calculate the resistance of any resistor network.

The network is stated with a string.
The resistors are separated by a vertical dash.
Each resistor has a starting node, an ending node and a resistance, separated by space characters.

#### Regular 3x3 mesh, using twelve one ohm resistors
```
0 1 2
3 4 5 
6 7 8
```
Battery connection nodes: 0 and 8  
assert 3/2  == network(9,0,8,"0 1 1|1 2 1|3 4 1|4 5 1|6 7 1|7 8 1|0 3 1|3 6 1|1 4 1|4 7 1|2 5 1|5 8 1")

#### Regular 4x4 mesh, using 24 one ohm resistors
```
 0  1  2  3
 4  5  6  7
 8  9 10 11
12 13 14 15
``` 
Battery connection nodes: 0 and 15  
assert 13/7 == network(16,0,15,"0 1 1|1 2 1|2 3 1|4 5 1|5 6 1|6 7 1|8 9 1|9 10 1|10 11 1|12 13 1|13 14 1|14 15 1|0 4 1|4 8 1|8 12 1|1 5 1|5 9 1|9 13 1|2 6 1|6 10 1|10 14 1|3 7 1|7 11 1|11 15 1")

#### Ten resistor network

Insert Picture here

Battery connection nodes: 0 and 1  
assert 10 == network(7,0,1,"0 2 6|2 3 4|3 4 10|4 5 2|5 6 8|6 1 4|3 5 6|3 6 6|3 1 8|2 1 8")

#### Wheatstone network

Picture Here

This network is not possible to solve using the Resistor Calculator previous published on Rosetta Code.
There is no natural starting point.

assert 180 == network(4,0,3,"0 1 150|0 2 50|1 3 300|2 3 250")

