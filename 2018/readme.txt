Vid problem med extern coffeescript version:

Kopiera in version av ztartProject.ahk som använder Coffeescript 2.0
Den ska gå mot node_modules i katalogerna github resp Lab
Läser även .babelrc i dessa kataloger.

Sökning sker mot roten.
Detta innebär att man inte behöver lägga node_modules i varenda projektkatalog.

######################

p5Dojo:
Den interna coffeescript-versionen är tillsvidare oförändrad.
Dvs, den generar ES5 kod, ej ES6.
Då den förändras, måste alla exempel som använder class skrivas om något.
Gäller bl a super. 

Kräver troligen att babelkod installeras i p5dojo katalogen. 
Avvaktar med detta tills vidare.

