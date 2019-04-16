# Rubik's Cube 3D

[Try it!](https://christernilsson.github.io/Lab/2019/033-RubikCube3D/index.html)

[Coding Train](https://thecodingtrain.com/CodingChallenges/142.2-rubiks-cube.html)

## Clockwise moves
* W = White
* B = Blue
* Y = Yellow
* G = Green
* O = Orange
* R = Red

## Small letters are anti-clockwise. 

## Internal representation
```
        U T S
        V   Z                       Orange
        W X Y 
  J Q P a h g j q p A H G 
  K   O b   f k   o B   F     Green White Blue Yellow
  L M N c d e l m n C D E    
        y x w
        z   v                       Red
        s t u 
```

# Comparison between Coding Train and Coffeescript

## Data storage for the cube

* Coding Train: 27 * 154 = 4158 bytes
* Coffeescript: 27 bytes

## Lines of Code

* Coding Train: 239 lines
* Coffeescript:  38 lines
