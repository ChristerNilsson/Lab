# Introduction

Calculate the resistance of a network of resistors. 
The resistors can be connected in series or parallel. 
Use infix or RPN to state the network.
Calculate resistance, voltage, current and power for every resistor and operation.

# Background

* Serial Resistors: the sum of the resistors gives the equivalent resistor
* Parallel Resistors: the inverse of the sum of the inverse of the resistors
* The voltage drops over the resistors
* Current = Resistance / Voltage
* Power = Current * Voltage

# Input

![Resistor Network](res5.gif)
  * Infix  ((((R8 + R10) * R9 + R7) * R6 + R5) * R4 + R3) * R2 + R1
  * RPN    10 2 + 6 * 8 + 6 * 4 + 8 * 4 + 8 * 6 +  
  
# Output for voltage 18.0 V
```
     Ohm     Volt   Ampere     Watt  Network tree
  10.000   18.000    1.800   32.400  +
   4.000    7.200    1.800   12.960  | *
   8.000    7.200    0.900    6.480  | | +
   4.000    3.600    0.900    3.240  | | | *
   8.000    3.600    0.450    1.620  | | | | +
   4.000    1.800    0.450    0.810  | | | | | *
  12.000    1.800    0.150    0.270  | | | | | | +
   4.000    0.600    0.150    0.090  | | | | | | | *
  12.000    0.600    0.050    0.030  | | | | | | | | +
  10.000    0.500    0.050    0.025  | | | | | | | | | r
   2.000    0.100    0.050    0.005  | | | | | | | | | r
   6.000    0.600    0.100    0.060  | | | | | | | | r
   8.000    1.200    0.150    0.180  | | | | | | | r
   6.000    1.800    0.300    0.540  | | | | | | r
   4.000    1.800    0.450    0.810  | | | | | r
   8.000    3.600    0.450    1.620  | | | | r
   4.000    3.600    0.900    3.240  | | | r
   8.000    7.200    0.900    6.480  | | r
   6.000   10.800    1.800   19.440  | r
```

10.000 ohms in the upper left corner is the equivalent resistance.
The first operation is 10 + 2 = 12 which can be found in the middle rows.
