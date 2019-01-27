# Ramer-Douglas-Peucker

[Try it!](https://christernilsson.github.io/Lab/2019/014-Ramer-Douglas-Peucker/index.html)

This program displays the inner workings of the recursive Ramer-Douglas-Peucker algorithm.

The purpose of the algorithm is to remove less needed points in a trail of points.
Corner points are more needed than mid points on a straight line.

![RDP](https://github.com/ChristerNilsson/Lab/blob/master/2019/014-Ramer-Douglas-Peucker/Capture.JPG)

[Wikipedia](https://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm)

[Implementation](http://mourner.github.io/simplify-js/)

[Karthaus](https://karthaus.nl/rdp/)

# Instructions

At startup you can see two red points. These are the starting and ending points of the complete drawing and are included.
In the lower right corner you can see a yellow point. This is the most distant point and it will be included in the final set.

Press the Right Arrow once.

The amount of points is now divided into two parts. We start recursively investigating the first part. The new outlier is found in the upper right. 

Press the Right Arrow again.

We are now making another recursive call, keeping the original starting point.
The ending point is in the upper right. The point most distant from a virtual line between the ending points, can be found in front of the big wheel.

Each time you press the Right Arrow one more point is included in the final set.

Highest recursion depth is 16.