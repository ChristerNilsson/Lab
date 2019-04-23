Använd ej kamera. Scanna ger mycket brättre resultat. Högre upplösning, inget parallaxfel.
* Brother: ställ in Scanning färg, 600 dpi, maxmiakl filstorlek.
1 (SE TILL ATT NORD/SYD linjer är aligned med bitmappen!)
3 Välj fyra hörnpunkter som syns bra i Google Maps
4 Tag reda på deras lat och long mha högerklick|"What's here"
5 Tag reda på x och y mha measure.coffee
  Byt sketch.js mot measure.js i index.html
  Byt kartnamn i measure.coffee
6 Lägg in dessa 4x4 värden i A,B,C och D

Se även bildfilen Construction.jpg

A,B,C,D mäts manuellt, både bitmapskoordinater och gps-kooridinater

ac0,ac1, bd0,bd1 beräknas mha A,B,C,D samt vercal()
ab0,ab1, cd0,cd1 beräknas mha A,B,C,D samt horcal()

nw,ne,se,sw beräknas mha ac0,ac1, bd0,bd1, ab0,ab1, cd0,cd1 samt corners()

I terrängen får man in en gps-koordinat.
Denna omvandlas till (x,y) mha GPS.gps2bmp()
Därefter kan positionen ritas in på kartan.

Distanskalkylator: http://edwilliams.org/gccalc.htm

Högupplösta orienteringskartor: https://www.omaps.net