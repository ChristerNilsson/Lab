# HP-35

[Try it!](https://christernilsson.github.io/Lab/2018/070-HP35/index.html)

![HP-35](http://www.hpmuseum.org/35last.jpg)

Legendarisk kalkylator från Hewlett-Packard 1972. 
I ett enda slag blev följande metoder omoderna:

* [Logaritmtabell (Napier,Briggs) 1624-1972](https://en.wikipedia.org/wiki/Common_logarithm)
* [Räknesticka (Oughtred) 1622-1972](http://www.antiquark.com/sliderule/sim/n909es/virtual-n909-es.html)
* [Mekanisk kalkylator (Odhner) 1874-1972](https://www.youtube.com/watch?v=ZDn_DDsBWws)
* [Elektromekanisk kalkylator 1927-1972](https://www.youtube.com/watch?v=Bd3R9u2vuCo)
* [Elektronisk räknare, fyra räknesätt 1961-1972](https://www.oldcalculatormuseum.com/friden130.html)

## Personerna bakom HP-35

* [Henry Briggs, PhD in Math, 1624](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Briggs%20and%20the%20HP35.htm)
* [Jack E Volder, BSEE, 1959](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Volder_CORDIC.pdf)
* [J. E. Meggitt, PhD in Math, 1961](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Meggitt_62.pdf)
* [Tom Osborne, MSEE, 1962](http://www.hp9825.com/html/osborne_s_story.html)
* [J. S. Walther, HP, 1971](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Welther-Unified%20Algorithm.pdf)
* [David Cochran, MSEE, 1971](http://www8.hp.com/us/en/pdf/023hpjournal03_tcm_245_935056.pdf)

## Föregångaren HP-9100 (1968)

![HP-9100](http://www.hpmuseum.org/9100pr.jpg)

## Kod

Denna simulator använder sig av det ursprungliga [rommet](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/coffee/asm.coffee) om 3 * 256 * 10 = [960 bytes](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/HP35_ROM.txt).
De enda instruktioner som används är addition och shift.
Alla övriga instruktioner, t ex mult, div, sin, cos, tan, ln, log, e^x utnyttjar sig enbart av addition och shift.

## Hastighet

* Bit tar 5 mikrosekunder
* Digit 20 mikrosekunder
* Word 280 mikrosekunder
* HP-35:s normala hastighet är cirka 1000000/280 = 3571 operationer per sekund
* Långsammaste operationen, tangens, tar cirka 500 ms.

## Register

* Data: 7 register om 14 nibbles = 49 bytes (nibble = 4 bitar)
* Status: 12 bitar.

* A   Styr displayen
* B   [Styr displayen](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Output%20format.htm)
* C X Talet användaren ser i displayen
* D Y Del av stacken
* E Z Del av stacken
* F T Del av stacken
* M   Memory
* S = [Status register](http://home.citycable.ch/pierrefleur/Jacques-Laporte/status_bit_flags.htm)
* PC = Program Counter 
  
## Projektet består av tre filer

* [hp35.coffee](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/coffee/hp35.coffee): 390 rader. Kalkylatorklass inklusive Styrprogram i ROM
* [sketch.coffee](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/coffee/sketch.coffee): 160 rader. GUI
* [asm.coffee](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/coffee/asm.coffee): 768 rader. Styrprogrammet på läsbar form

## Trace 

* Genom att klicka på bakgrunden kan man slå av och på trace
* Då får man se vad registren innehåller
* Dessutom kan man använda F12 för att se vilka instruktioner som körs
* Vid spårning sänks hastigheten till 60 operationer per sekund
* Exempel: [123 * 456](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/Trace_123x456.txt)
  * Notera att multiplikationen utförs på samma sätt som när man räknar för hand. [Enbart addition och skift](https://github.com/ChristerNilsson/Lab/blob/master/2018/070-HP35/Trace_compact.txt).

## Länkar

* [Baksida](https://www.keesvandersanden.nl/calculators/images/HP35_1302S48386_backlabel.jpg)

* [Manual](http://www.cs.columbia.edu/~sedwards/hp35colr.pdf)

* [Wikipedia](https://en.wikipedia.org/wiki/HP-35)

* [HP-35 simulator](http://www.hpmuseum.org/simulate/hp35sim/calc.html)

* [The 'Powerful Pocketful': an Electronic
Calculator Challenges the Slide Rule](http://www.hpl.hp.com/hpjournal/pdfs/IssuePDFs/1972-06.pdf)

* [Reverse Polish Notation (RPN)](https://www.youtube.com/watch?v=g6_cnRg5GmI)

* [Originalkod för Arduino av Pietro de Luca](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Image_deluca/hp35_lcd.pde)

* [Jacques Laporte's dokumentation](http://home.citycable.ch/pierrefleur/Jacques-Laporte/index-old.html)

* [Andra HP simulatorer](http://www.teenix.org/)

* [Free42](http://thomasokken.com/free42)

* [DM42](https://www.swissmicros.com/dm42.php)

* [HP CPU and Programming](http://www.hpmuseum.org/techcpu.htm)

* [Operationskoder](http://home.citycable.ch/pierrefleur/HP-Classic/HP-ClassicOpcodeMap.html)

* [Genomgång av beräkning av logaritm](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Logarithm_1.htm)

* [Pseudo Multiplication av Meggitt 1961](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Meggitt_62.pdf)
  
* [Hewlett-Packard 9100 - Computer Calculator For Math And Science (1968)](https://www.youtube.com/watch?v=Ki1Inux1_wU)

* [A reconstruction of the tables of Briggs’ Arithmetica
logarithmica (1624)](https://hal.inria.fr/inria-00543939/document)