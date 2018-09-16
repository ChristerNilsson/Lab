# Generalens Tidsfördriv

[Prova!](https://christernilsson.github.io/Lab/2018/056-GeneralensTidsf%C3%B6rdriv/index.html)

* Livet är kort!
* Det lär vara ett antal generaler som lägger denna patiens i fredstid för att hålla sina hjärnor i trim.
* Denna patiens går ut på att bygga uppåt på Essen. Dvs Tvåor läggs på Essen osv upp till Kung.
* På de övre åtta sekvenserna får man bygga både uppåt och neråt.
* Blir en sekvens tom får man placera valfritt kort där.
* De nedre åtta fria korten får man inte bygga på. Man får enbart plocka dessa.
* Färg bibehålles alltid. Det finns fyra färger.

# Menyn
Menyn nås genom att klicka på den gröna bakgrunden eller något av essen.

* __Undo__ Ångrar senaste drag. Draget indikeras med __From__ och __To__
* __Hint__ Ger en ledtråd. Se röd/grön indikator
  * Prova även att göra en Restart innan du klickar på Hint. Då slipper du utföra eventuella Undo
* __Cycle Move__ Ibland placeras korten på en annan plats än du tänkt dig. Med detta kommando kan du välja mellan alternativa platser. Klicka på mittcirkeln då du är nöjd
* __More...__
  * __Restart__ Återställ korten för denna Nivå.
  * __Total Restart__ Innebär att starta om från Nivå 0. Alla Nivåer måste ånyo lösas
  * __Link__ Sparar en länk till aktuell patiens på klippbordet. Skicka till en vän!
* __Next__ Gå till nästa nivå
* Mittcirkeln används för att stänga en meny

# Nivåer 
_Classic_ innebär att sekvenserna är lika långa.
Högre nivåer nås genom att använda så få drag som möjligt och utan att använda någon ledtråd.

* 0 = Classic Ess till 3. _Lätt_ (Cards=8)
* 1 = Ess till 4
* 2 = Ess till 5
* 3 = Classic Ess till 5
* 4 = Ess till 6
* 5 = Ess till 7
* 6 = Classic Ess till 7
* 7 = Ess till 8
* 8 = Ess till 9
* 9 = Classic Ess till 9
* 10 = Ess till Tio
* 11 = Ess till Knekt
* 12 = Classic Ess till Knekt
* 13 = Ess till Dam
* 14 = Ess till Kung
* 15 = Classic Ess till Kung. _Svår_ (Cards=48)

# Ledtrådar

* Klickar man på __Hint__ får man en ledtråd för att komma vidare mot lösningen
* Inledningsvis kan __Hint__ ge en eller flera __Undo__ som indikeras med rött
* Man måste själv utföra de föreslagna dragen
* Använder man __Hint__ kan man inte avancera till nästa nivå

# Indikatorer

* __From__ visar var draget börjar
* __To__ visar var draget slutar
* Rött är en hint bakåt. Klicka på __Undo__
* Grönt är en hint framåt. Klicka på kortet för att utföra draget
  * Om kortet hamnar på fel plats kan du korrigera detta med hjälp av __Cycle Move__
* Gult visar vilken __Undo__ som precis utförts. Du behöver ej klicka på något

# Lösbarhet

De skapade patienserna är alltid lösbara. Det är med andra ord alltid för tidigt att ge upp.

# Tävling
Tävling kan ske mellan två eller flera personer. Man kan t ex bestämma sig för att hålla på en viss tid eller först uppnå en viss nivå.

## Tid
Börja med att bestämma en viss tid, t ex fem minuter eller en halv timma. Den som har hunnit längst har vunnit.
Ligger man lika fortsätter man tills någon når nästa nivå.

## Nivå
Bestäm antal nivåer som ska lösas, t ex 4, 8 eller 16. 

## Allmänt
Om man är smartare än datorn får man tillgodoräkna sig de dragen och använda dem på högre nivåer.

# Tips

* Maximera fönstret med __F11__
* Refresha med __ctrl-R__

# Litteratur

_Att lägga patiens_. Bokförlaget Forum 1957.
Motsvarar Nivå 15.

## Avvikelser från originalpatiensen

* Man måste bygga uppåt på essen.
* Man kan ej använda något fängelse.

# Bilden

* Vi befinner oss 7 drag in i lösandet av en patiens på nivå 11
* Datorn har redan löst problemet. Det går att lösa på 53 drag
  * Dock händer det ganska ofta att kortare lösningar finns
* Det senaste draget flyttade spader 9 från klöver 2 till spader 8
  * Detta går att ångra med __Undo__
  * Vill man istället placera spadera 9 på spader 10 kan det göras med __Cycle Move__
* Nivå 11 innebär att 44 kort ska placeras.
  * Av dessa har just nu fyra placerats på hjärter ess.
* Normalt innebär ett drag att två kort kopplas ihop
* Talet 9 (53-44) anger hur många drag som inte kopplar ihop två kort
  * T ex genom att flytta ett kort eller en hög till ett hål
* Av bilden framgår att spelaren har 5 (47-42) sparade drag sedan tidigare
  * Det innebär att denna uppgift måste lösas med högst 58 (53+5) drag för uppflyttning till nästa nivå
* Totaltiden som använts är 131 sekunder
* Klockan stoppas då alla korten placerats på essen
* Klockan startas igen då man klickar på __Next__

![](bild0.jpg "GT")
