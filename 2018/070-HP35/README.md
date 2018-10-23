# HP-35

Legendarisk kalkylator från Hewlett-Packard 1972.

Översättning från C++ till Coffeescript.

Denna simulator använder sig av det utsprungliga rommet om 960 bytes.
De enda instruktioner som används är addition och shift.
Alla övriga instruktioner, t ex mult, div, sin, cos, tan, ln, log, e^x utnyttjar sig enbart av addition och shift.

* Hela programmet ryms i 3 x 256 x 10 bitar = 960 bytes
* Data: 8 tal om 16 nibbles = 64 bytes
* Status: 12 bitar.

* Genom att klicka på displayen kan man slå av och på trace
* Då får man se vad de åtta registren innehåller.
* Dessutom kan man använda F12 för att se vilka instruktioner som körs
  * A   Styr displayen
  * B   [Styr displayen](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Output%20format.htm)
  * C X Talet användaren ser i displayen
  * D Y Del av stacken
  * E Z Del av stacken
  * F T Del av stacken
	* PC = Program Counter 
  * S = [Status register](http://home.citycable.ch/pierrefleur/Jacques-Laporte/status_bit_flags.htm)
  
Projektet består av tre filer:

* hp35.coffee: 450 rader. Kalkylatorklass inklusive Styrprogram i ROM.
* sketch.coffee: 160 rader. GUI
* asm.coffee: 768 rader. Styrprogrammet på läsbar form.

* [Baksida](https://www.keesvandersanden.nl/calculators/images/HP35_1302S48386_backlabel.jpg)

* [Manual](file:///C:/Users/christer/AppData/Local/Temp/Temp1_HP35.zip/HP35oh.pdf)

* [Wikipedia](https://en.wikipedia.org/wiki/HP-35)

* [HP-35 simulator](http://www.hpmuseum.org/simulate/hp35sim/hp35sim.htm)

* [Originalkod för Arduino av Pietro de Luca](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Image_deluca/hp35_lcd.pde)

* [Jacques Laporte's dokumentation](http://home.citycable.ch/pierrefleur/Jacques-Laporte/index-old.html)

* [Andra HP simulatorer](http://www.teenix.org/)

* [HP CPU and Programming](http://www.hpmuseum.org/techcpu.htm)

* [Operationskoder](http://home.citycable.ch/pierrefleur/HP-Classic/HP-ClassicOpcodeMap.html)

* [Genomgång av beräkning av logaritm](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Logarithm_1.htm)

* [Pseudo Multiplication av Meggitt 1961](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Meggitt_62.pdf)
  