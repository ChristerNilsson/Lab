# 008-Kalkyl

Här kan man testa sina one-liners!
Även lämplig som kalkylator.
Man kan namnge sina uttryck.
Dessutom kan man skapa funktioner.

## Hide
Döljer tangentbordet på smartphones

## Clear
Tömmer kalkylatorn

## Samples
Visar nedanstående exempel.

## Reference
Länk till relevant Javascriptdokumentation

## Exempel

Skriv t ex in 

```javascript
sträcka=12
tid=5
hastighet=sträcka/tid
```

Ändra därefter sträcka till 20

Klarar även String, Array, Object, funktioner

## Fler exempel

```javascript
2+3

sträcka = 150
tid = 6
tid
sträcka/tid
25 == sträcka/tid 
30 == sträcka/tid

// String
a = "Volvo" 
5 == a.length
'l' == a[2]

// Math
5 == sqrt(25) 

// Date
c = new Date() 
2018 == c.getFullYear()
c.getHours()

// Array
numbers = [1,2,3] 
2 == numbers[1]
numbers.push(47)
4 == numbers.length
numbers 
47 == numbers.pop()
3 == numbers.length
numbers

// Object
person = {fnamn:'David', enamn:'Larsson'}
'David' == person['fnamn']
'Larsson' == person.enamn

// functions
kvadrat(x)=x*x
25 == kvadrat(5)

serial(a,b) = a+b
2 == serial(1,1)
5 == serial(2,3)

parallel(a,b) = a*b/(a+b)
0.5 == parallel(1,1)
1.2 == parallel(2,3)

fak(x) = x==0 ? 1 : x * fak(x-1)
3628800 == fak(10)

fib(x) = x<=0 ? 1 : fib(x-1)+fib(x-2) 
1 == fib(0)
2 == fib(1)
5 == fib(3)
8 == fib(4)
13 == fib(5)
21 == fib(6)
// 1
// 2 Tre extra rader pga Androidproblem
// 3
```

## Observera

Den matematiska syntaxen för funktioner är inte den samma som i Javascript/Coffeescript.

## Todo

Notera den stora marginalen längst ner.
Beror på problem med Android.
https://stackoverflow.com/questions/10610743/android-browsers-screen-width-screen-height-window-innerwidth-window-inner