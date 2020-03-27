# Improving execution speed.

### Moving to Python 3.8
Execution time 129.6 secs

### Pinpointing bottleneck
The hamming function takes 90% of the time

### Moving to numpy
* Very quick C routines for arrays
* Exec time 5.5 secs.
* (24 times faster)

### Implementation
* Changed 'ACGT' to [0,1,2,3] 
* numpy handles looping over arrays
* used numpy function count_nonzero()

### 10% shorter exec time?
Is the deepcopy necessary?
