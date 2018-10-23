# HP-35

Legendarisk kalkylator från Hewlett-Packard 1972. Översättning från C++ till Coffeescript.

Denna simulator använder sig av det utsprungliga rommet om 960 bytes.
De enda instruktioner som används är addition och shift.
Alla övriga instruktioner, t ex mult, div, sin, cos, tan, ln, log, e^x utnyttjar sig enbart av addition och shift.

* Hela programmet ryms i 3 x 256 x 10 bitar = 960 bytes
* Data: 8 tal om 16 nibbles = 64 bytes
* Status: 12 bitar.

* I programkoden kan man slå av/på trace mha konstanten TRACE.
* Exekveringshastigheten påverkas med konstanten SPEED.

Projektet består av tre filer:

* hp35.coffee: 450 rader. kalkylatorklass inklusive ROM.
* sketch.coffee: 160 rader. GUI
* asm.coffee: 768 rader med instruktioner. ROM i klartext.

* [HP-35 simulator](http://www.hpmuseum.org/simulate/hp35sim/hp35sim.htm)

* [Manual](file:///C:/Users/christer/AppData/Local/Temp/Temp1_HP35.zip/HP35oh.pdf)

* [Originalkod för Arduino av Pietro de Luca](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Image_deluca/hp35_lcd.pde)

* [Jacques Laporte's dokumentation](http://home.citycable.ch/pierrefleur/Jacques-Laporte/index-old.html)

* [Andra HP simulatorer](http://www.teenix.org/)

* [Operationskoder](http://home.citycable.ch/pierrefleur/HP-Classic/HP-ClassicOpcodeMap.html)

* [Genomgång av beräkning av logaritm](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Logarithm_1.htm)

* [Pseudo Multiplication av Meggitt 1961](http://home.citycable.ch/pierrefleur/Jacques-Laporte/Meggitt_62.pdf)
  