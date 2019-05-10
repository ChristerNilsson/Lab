# 043-gpsKarta

Underlättar orientering.

Köp kartan [här](http://www.skogsluffarna.se/Arrangemang/Naturpasset)

## Funktionalitet

Man ser karta, kontroller samt egen position hela tiden.
Kontrollernas diameter är cirka 100 meter.

*   : Centrerar aktuell position
* L : Flyttar vänster
* R : Flyttar höger
* U : Flyttar upp
* D : Flyttar ner
* Minus : Zoomar ut
* Plus : Zoomar in
* S : Sparar aktuell position. Visas med rött.
* P : Droppar senast sparad position. Visar antalet sparade.

Praktisk noggrannhet tycks ligga kring 10 meter.

Den egna positionen visas med fem svarta cirklar. Den minsta cirkeln är den senaste.

Hindra skärmrotation på din mobil (Android) :
* Settings
* Display
* When device is rotated: Stay in portrait view

## Klicka på kontroll
Genom att klicka på en kontroll kan man se bäring och avstånd till kontrollen.

## Arbetsgång
* Koppla in hörlurarna.
* Avläs bäring till kontrollen
* Ställ in den på kompassen
* Gå i den bäringen eller gå runt hinder
* Justera bäringen då rösten säger t ex "bearing 2 7" (270 grader = västerut)
* Avstånd läses upp som t ex "distance 100" (meter)
* Då avståndet < 10 meter ges ingen bäring. Utnyttja eventuellt bildskärmen för finlir på slutet.
* Om hastigheten mot målet minskar till noll, gör en 90-graders sväng. Behövs ej om man följer rätt bäring.

## ToDo:

*	Drag och pinch istf knappar

## Intern info

* playSound måste göra ett minimum för att hinna med 10 Hz.