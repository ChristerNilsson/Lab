# CC130 Fourier

Tried to reduce points, but found an algorithm that is much better.

The Ramer-Douglas-Peucker algorithm

http://mourner.github.io/simplify-js/

I did not observe any improvement using highestQuality.
Nor did it take longer time.

I was amazed the algorithm handles non-increasing x-values.
It finds the most distant point and keeps it repeatedly.