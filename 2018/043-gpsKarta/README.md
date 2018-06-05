# 043-gpsKarta

Underlättar orientering.
Just nu innehåller den ett foto av Naturpasset 2018 med 50 kontroller. 
Köp kartan [här](http://www.skogsluffarna.se/Arrangemang/Naturpasset)

# Funktionalitet

Man ser karta, kontroller samt egen position hela tiden.
Kontrollernas diameter är cirka 75 meter.

* Left: Flyttar vänster
* Right: Flyttar höger
* Up: Flyttar upp
* Down : Flyttar ner
* - : Zoomar ut
* + : Zoomar in
* C : Centrerar aktuell position
* Save: Sparar aktuell position. Visas med rött.
* 0: Droppar senast sparad position. Visar antalet sparade.

Praktisk noggrannhet tycks ligga kring 15-20 meter.

# ToDo:

*	Begränsa zoom
*	Drag och pinch istf knappar
*	Transformationer mellan wgs84 och bitmappskoordinater sker via åtta anrop till map. Borde kunna förbättras. 
*	GlobalMercator kan möjligen användas för denna projektion.

