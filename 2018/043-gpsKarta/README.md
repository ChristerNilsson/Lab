# 043-gpsKarta

Underlättar orientering.

Köp kartan [här](http://www.skogsluffarna.se/Arrangemang/Naturpasset)

# Funktionalitet

Man ser karta, kontroller samt egen position hela tiden.
Kontrollernas diameter är cirka 75 meter.

* C : Centrerar aktuell position
* L : Flyttar vänster
* R : Flyttar höger
* U : Flyttar upp
* D : Flyttar ner
* Minus : Zoomar ut
* Plus : Zoomar in
* S : Sparar aktuell position. Visas med rött.
* 0 : Droppar senast sparad position. Visar antalet sparade.

Praktisk noggrannhet tycks ligga kring 15-20 meter.

Den egna positionen visas med fem gula cirklar. Den minsta cirkeln är den senaste.

# ToDo:

*	Begränsa zoom
*	Drag och pinch istf knappar
*	Transformationer mellan wgs84 och bitmappskoordinater sker via åtta anrop till map. Borde kunna förbättras. 
*	GlobalMercator kan möjligen användas för denna projektion.
