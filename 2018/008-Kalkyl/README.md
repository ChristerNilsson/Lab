# 008-Kalkyl

[Try it!](https://christernilsson.github.io/Lab/2018/008-Kalkyl/index.html?content=x%3D=1)

* Here you can test your one-liners!
* Also suitable as a calculator
* Give name to your expressions
* Create your own functions
* Syntax: Coffeescript or Javascript
* Results are displayed with engineering notation:
	* E-12 pico
	* E-9 nano
	* E-6 mikro
	* E-3 milli
	* 
	* E3 kilo
	* E6 mega 
	* E9 giga
	* E12 tera

## Hide
Hides the keyboard on smartphones

## Clear
Clears the calculator

## Samples
Show the following example.

## Reference
Link to relevant Javascript documentation

## URL

Makes a copy of this tab. The link can be copied and sent to a friend.

## Less

Shows less digits

## More

Shows more digits

## Examples

For example, write

```javascript
distance = 12
time = 5
speed = distnace / time
```

Change distance to 20

Also handles strings, lists, objects, functions

## More examples

```javascript
2+3

distance = 150
time = 6
time
distance/time
25 == distance/time
30 == distance/time

# String
a = "Volvo" 
5 == a.length
'l' == a[2]

# Math
5 == sqrt 25 

# Date
c = new Date() 
2018 == c.getFullYear()
c.getHours()

# Array
numbers = [1,2,3] 
2 == numbers[1]
numbers.push 47
4 == numbers.length
numbers 
47 == numbers.pop()
3 == numbers.length
numbers

# Object
person = {fnamn:'David', enamn:'Larsson'}
'David' == person['fnamn']
'Larsson' == person.enamn

# functions (only one liners allowed!)
square = (x) -> x*x
25 == square 5

serial = (a,b) -> a+b
2 == serial 1,1
5 == serial 2,3

parallel = (a,b) -> a*b/(a+b)
0.5 == parallel 1,1
1.2 == parallel 2,3

factorial = (x) -> if x==0 then 1 else x * factorial(x-1)
3628800 == factorial 10

fib = (x) -> if x<=0 then 1 else fib(x-1) + fib(x-2) 
1 == fib 0
2 == fib 1
5 == fib 3
8 == fib 4
13 == fib 5
21 == fib 6
```

## Todo

För att kunna köra Javascript-kod måste man manuellt kommentera ut 'use strict' i sketch.js efter varje kompilering

Notera den stora marginalen längst ner.
Beror på problem med Android.
https://stackoverflow.com/questions/10610743/android-browsers-screen-width-screen-height-window-innerwidth-window-inner