# Nytt valsystem

Det går att minska datainläsning från 29MB till cirka 500KB genom att läsa .txt-filer skapade av 010.py
* 00.txt Riksdagen
* 01.txt Stockholms län
* 0180.txt Stockholms kommun
* personer.txt
* partier.txt

personer.txt och partier.txt skrivs lämpligen in i slutet på de övriga filerna.

00.txt 01.txt 0180.txt har alla samma struktur:

A|1475|123456|123457                           partikod kandidatnummer*
B|1013|Bollp|Bollnäspartiet                    partikod partinamn partibeteckning
C|355151|28|K|Jessica Ohlson|jurist, Nyköping  kandidatnummer ålder kön namn uppgift

00.txt   A: 6000 B:100 C:6000  Totalt 42K + 2K + 300K = 344K
01.txt   A: 1500 B:50  C:1500  Totalt 10K + 1K + 75K  = 86K
0180.txt A: 750  B:50  C:750   Totalt 5K + 1K+ 37K    = 43K

Totalt: 344K + 86K + 43K = 473K (Stockholm)

Små kommuner tar cirka 350K