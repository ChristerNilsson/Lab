# Resistance Calculator in Nim

* Enter the resistor network using RPN
* s = serial
* p = parallel

## Example 1

![Network](res1.gif)

### Input

```code
12 V
12
```

### Output

```code
     Ohm    Volt  Ampere    Watt Network tree
  12.000  12.000   1.000  12.000 r
```

## Example 2
![Network](res2.gif)

### Input

```code
12 V
6 6 s
```

### Output
```code
     Ohm    Volt  Ampere    Watt Network tree
  12.000  12.000   1.000  12.000 s
   6.000   6.000   1.000   6.000 | r
   6.000   6.000   1.000   6.000 | r
```

## Example 3
![Network](res3.gif)

### Input

```code
12 V
200 470 220 p p
```

### Output
```code
     Ohm    Volt  Ampere    Watt Network tree
  85.667  12.000   0.140   1.681 p
 149.855  12.000   0.080   0.961 | p
 220.000  12.000   0.055   0.655 | | r
 470.000  12.000   0.026   0.306 | | r
 200.000  12.000   0.060   0.720 | r
```

## Example 3B
![Network](res3B.gif)

### Input

```code
12 V
12 12 p 6 s
```
### Output
```code
     Ohm    Volt  Ampere    Watt Network tree
  12.000  12.000   1.000  12.000 s
   6.000   6.000   1.000   6.000 | r
   6.000   6.000   1.000   6.000 | p
  12.000   6.000   0.500   3.000 | | r
  12.000   6.000   0.500   3.000 | | r
```

## Example 4
![Network](res4.gif)

### Input

```code
12 V
8 4 s 12 p 6 s
```
### Output
```code
    Ohm    Volt  Ampere    Watt Network tree
  12.000  12.000   1.000  12.000 s
   6.000   6.000   1.000   6.000 | r
   6.000   6.000   1.000   6.000 | p
  12.000   6.000   0.500   3.000 | | r
  12.000   6.000   0.500   3.000 | | s
   4.000   2.000   0.500   1.000 | | | r
   8.000   4.000   0.500   2.000 | | | r
```

## Example 5
![Network](res5.gif)

### Input

```code
12 V
10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s
```

### Output

```code
     Ohm    Volt  Ampere    Watt Network tree
  10.000  12.000   1.200  14.400 s
   6.000   7.200   1.200   8.640 | r
   4.000   4.800   1.200   5.760 | p
   8.000   4.800   0.600   2.880 | | r
   8.000   4.800   0.600   2.880 | | s
   4.000   2.400   0.600   1.440 | | | r
   4.000   2.400   0.600   1.440 | | | p
   8.000   2.400   0.300   0.720 | | | | r
   8.000   2.400   0.300   0.720 | | | | s
   4.000   1.200   0.300   0.360 | | | | | r
   4.000   1.200   0.300   0.360 | | | | | p
   6.000   1.200   0.200   0.240 | | | | | | r
  12.000   1.200   0.100   0.120 | | | | | | s
   8.000   0.800   0.100   0.080 | | | | | | | r
   4.000   0.400   0.100   0.040 | | | | | | | p
   6.000   0.400   0.067   0.027 | | | | | | | | r
  12.000   0.400   0.033   0.013 | | | | | | | | s
   2.000   0.067   0.033   0.002 | | | | | | | | | r
  10.000   0.333   0.033   0.011 | | | | | | | | | r
```

### Performance

```code
Coffeescript  1.171 micros
Nim           1.955 micros    
C++           4.941 micros static
C++          10.866 micros dynamic
Python       23.280 micros
```