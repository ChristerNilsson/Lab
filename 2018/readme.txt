Vid problem med extern coffeescript version:

Kopiera in version av ztartProject.ahk som anv�nder Coffeescript 2.0
Den ska g� mot node_modules i katalogerna github resp Lab
L�ser �ven .babelrc i dessa kataloger.

S�kning sker mot roten.
Detta inneb�r att man inte beh�ver l�gga node_modules i varenda projektkatalog.

######################

p5Dojo:
Den interna coffeescript-versionen �r tillsvidare of�r�ndrad.
Dvs, den generar ES5 kod, ej ES6.
D� den f�r�ndras, m�ste alla exempel som anv�nder class skrivas om n�got.
G�ller bl a super. 

Kr�ver troligen att babelkod installeras i p5dojo katalogen. 
Avvaktar med detta tills vidare.

