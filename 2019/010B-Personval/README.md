# Nytt valsystem

[Try it!](https://christernilsson.github.io/Lab/2019/010B-Personval/index.html)

Datainläsningen har minskat från 29M till cirka 0.5M genom att använda .txt-filer skapade av 010.py
* 00.txt   Riksdagen
* 01.txt   Stockholms län
* 0180.txt Stockholms kommun
* omraden.txt (namn på kommuner och landsting)

00.txt 01.txt 0180.txt har alla samma struktur:

T|Stockholm                                    Riksdagen, Landstinget eller Kommunens namn
A|1475|123456|355151                           PARTIKOD|KANDIDATNUMMER|KANDIDATNUMMER|...
B|1013|C|Centerpartiet                         PARTIKOD|PARTIFÖRKORTNING|PARTIBETECKNING
C|355151|28|K|Jessica Ohlson|jurist, Nyköping  KANDIDATNUMMER|ÅLDER_PÅ_VALDAGEN|KÖN|NAMN|VALSEDELSUPPGIFT

00.txt    388K
01.txt    100K
0180.txt   52K

Totalt:   540K (Stockholm)
Minsta:   411K (Arjeplog)

Beskrivning av kolumner i kandidaturer.js:

VALTYP = 0
VALOMRÅDESKOD = 1
VALOMRÅDESNAMN = 2
VALKRETSKOD = 3
VALKRETSNAMN = 4
PARTIBETECKNING = 5
PARTIFÖRKORTNING = 6
PARTIKOD = 7
VALSEDELSSTATUS = 8
LISTNUMMER = 9
ORDNING = 10
ANMKAND = 11
ANMDELTAGANDE = 12
SAMTYCKE = 13
FÖRKLARING = 14
KANDIDATNUMMER = 15
NAMN = 16
ÅLDER_PÅ_VALDAGEN = 17
KÖN = 18
FOLKBOKFÖRINGSORT = 19
VALSEDELSUPPGIFT = 20
ANT_BEST_VALS = 21
VALBAR_PÅ_VALDAGEN = 22
GILTIG = 23
