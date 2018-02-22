Symbolisk RPN Kalkylator
========================

En symbolisk kalkylator räknar alltid exakt.
T ex lagras bråktalet 1/3 exakt.
Bignums hanteras. T ex 4**4**4 (155 siffror)
Variabler hanteras, t ex x,y och z.
Även funktioner kan hanteras, t ex f(x) och g(x)
Derivator, integraler, gränsvärden och oändliga summor hanteras.
Komplexa tal anges med stora I.
Pi: N(pi,30)     = 3.14159265358979323846264338328
e:  N(exp(1),30) = 2.71828182845904523536028747135

### Matematiska operationer

*                  ( y x -- y*x )
+                  ( y x -- y+x )
-                  ( y x -- y-x )
/                  ( y x -- y/x )
**                 ( y x -- y**x )
inv                ( x -- 1/x )
chs                ( x -- -x )
sq                 ( x -- x*x )
sqrt               ( x -- sqrt(x) )

### Logaritmer ###

log                ( x -- log(x) )
ln                 ( x -- log(x) )
exp                ( x -- exp(x) )

### Trigonometri ###

sin                ( x -- sin(x) )
cos                ( x -- cos(x) )
tan                ( x -- tan(x) )
radians            ( degrees -- radians )

### Symboler ###

x                  ( -- x )
y                  ( -- y )
z                  ( -- z )
t                  ( -- t )
oo                 ( -- oo )
inf                ( -- oo )
infinity           ( -- oo )

### Analys ###

simplify           ( expr -- expr )
expand             ( expr -- expr )
factor             ( expr -- expr )
apart              ( expr -- expr )
together           ( expr -- expr )

[1,2,3]            ( -- [1,2,3] )
item               ( [1,2,3] 0 item -- 1 )
polynom            ( [4,5,6] -- 4+5*x+6*x**2 )
diff               ( x**2 x -- 2*x )
integrate          ( x**2 x -- x**3/3 )
solve              ( x**4-1 x -- [-1,1,-I,I] )
eval               ( x**2 x 3 -- 9 )
limit              ( x sin x / x 0 -- 1 )
sum                ( 1 x x * / x 1 oo -- pi**2/6 )

### Geometri ###

point              ( 1 2 -- point )
line               ( p1 p2 -- Line )
circle             ( point radius -- circle )
center             ( circle -- center )
radius             ( circle -- radius )
triangle           ( p1 p2 p3 -- triangle )
incircle           ( triangle -- circle )
circumcircle       ( triangle -- circle )
tangent_lines      ( circle point -- [line] )
intersection       ( line1 line2 -- [point] )
perpendicular_line ( line point -- line )

### Diverse ###

?,help             Visar tillgängliga kommandon
history            Visar inmatade kommandon
undo               Ångrar senaste kommando
N                  ( symbolic -- numeric )
clr                ( x y z -- )
dup                ( x -- x x )
drp                ( z -- )
swp                ( x y -- y x )
f=                 ( expr -- )  # expr lagras i f
f                  ( -- expr )  # expr hämtas
defs               Visar alla sparade uttryck
sketch             Skapar javascriptkod för att visa geometri

Observera att blanktecken är signifikanta.
T ex kan x+1 matas in på två sätt:
  x+1    Algebraisk notation
  x 1 +  RPN = Reverse Polish Notation
Båda resulterar i uttrycket x+1.

Allt som sympy kan göra finns tillgängligt via algebraisk notation.