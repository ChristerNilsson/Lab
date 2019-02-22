# Tunnelbanan

[Try it!](https://christernilsson.github.io/Lab/2017/075-simulator-Linje17/index.html)

En supersimpel simulator

* Linje 17, gröna linjen i Stockholm
* Har försökt göra allt skalenligt.
* Dock är avstånden mellan stationerna lika stort.
* Zoom och pan med musen

* Ett tåg består av 3 vagnar.
* En vagn består av tre delar, med totalt fyra boogier
* [Ritning C20](https://melkerlarsson.files.wordpress.com/2015/07/c20-ritning.jpg)
* En vagn är 46.5 m.
* Ett tåg är 140 meter långt och 2.9 m bred.
* Acceleration 1.25 m/s2
* Maxhastighet 90 km/h
* Linje 17 är 39.2 km lång, round trip.
* Det tar 82 minuter att göra en round trip.
* Medelhastighet: 8 m/s = 29 km/h (inklusive stopp och inbromsningar)
* Perrongtid 60 sekunder.

* Simulerar i första hand stopp på perrong samt inbromsning för andra tåg
* Inbromsningspunkt räknas ut enbart m h a egen hastighet
* Tåg betraktas som opålitligt föremål som kan tvärstanna när som helst
* Räknar ut högsta möjliga acceleration m a p närmaste framförvarande perrong
* Räknar ut högsta möjliga acceleration m a p närmaste framförvarande tåg
* Lägsta accelerationen av dessa båda väljs
* Bezier används för halvcirklarna.
