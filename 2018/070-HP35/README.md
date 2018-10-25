# HP-35

Legendarisk kalkylator från Hewlett-Packard 1972. I ett slag förflyttades logaritmtabeller och räknestickor till muséerna.

Översättning från C++ till Coffeescript.

Denna simulator använder sig av det ursprungliga rommet om 960 bytes.
De enda instruktioner som används är addition och shift.
Alla övriga instruktioner, t ex mult, div, sin, cos, tan, ln, log, e^x utnyttjar sig enbart av addition och shift.

* Hela programmet ryms i 3 x 256 x 10 bitar = 960 bytes
* Data: 7 register om 14 nibbles = 49 bytes (nibble = 4 bitar)
* Status: 12 bitar.

## Trace 

* Genom att klicka på bakgrunden kan man slå av och på trace
* Då får man se vad registren innehåller
* Dessutom kan man använda F12 för att se vilka instruktioner som körs

## Hastighet
* Bit tar 5 mikrosekunder
* Digit 20 mikrosekunder
* Word 280 mikrosekunder
* HP-35:s normala hastighet är cirka 1000000/280 = 3571 operationer per sekund
* Vid spårning sänks hastigheten till 60 operationer per sekund

## Register

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

* hp35.coffee: 390 rader. Kalkylatorklass inklusive Styrprogram i ROM.
* sketch.coffee: 135 rader. GUI
* asm.coffee: 768 rader. Styrprogrammet på läsbar form.

## Länkar

* [Baksida](https://www.keesvandersanden.nl/calculators/images/HP35_1302S48386_backlabel.jpg)

* [Manual](http://www.cs.columbia.edu/~sedwards/hp35colr.pdf)

* [Wikipedia](https://en.wikipedia.org/wiki/HP-35)

* [HP-35 simulator](http://www.hpmuseum.org/simulate/hp35sim/calc.html)

* [Originalkod för Arduino av Pietro de Luca](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Image_deluca/hp35_lcd.pde)

* [Jacques Laporte's dokumentation](http://home.citycable.ch/pierrefleur/Jacques-Laporte/index-old.html)

* [Andra HP simulatorer](http://www.teenix.org/)

* [HP CPU and Programming](http://www.hpmuseum.org/techcpu.htm)

* [Operationskoder](http://home.citycable.ch/pierrefleur/HP-Classic/HP-ClassicOpcodeMap.html)

* [Genomgång av beräkning av logaritm](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Logarithm_1.htm)

* [Pseudo Multiplication av Meggitt 1961](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Meggitt_62.pdf)
  