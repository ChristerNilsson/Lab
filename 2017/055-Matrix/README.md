# Matrix

Simple class inspired by numpy shape and broadcast.

# Broadcasts

The matrices does not have to have the same shapes.
Missing data is filled in automatically.

Examples:
```coffeescript
shape1 shape2 result
2,3    2,3    2,3
2,1    1,3    2,3
2      2,3    2,3
1,3    2,3    2,3
6      2,3    2,3
2      3      -
1,2    1,3    -
```

* m1.add m2
* m1.add 10

# Methods

* add
* sub
* mul
* dot
* transpose
* map
* toArray
* copy
* randint

* reshape
* matrix
* cell

For more information, check out the asserts in coffee/test.coffee