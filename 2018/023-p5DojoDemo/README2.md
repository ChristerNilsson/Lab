## Installation av Coffeescript

Lämpligt att göra när du är klar med alla övningar i p5Dojo.
Då kan du t ex göra animerade 3D-spel som dina vänner kan köra via webben.

### Förkunskaper i Windows

Du bör behärska följande förmågor innan installation sker:

```    
Förmåga        Text Filer Kataloger
===================================
Skapa           x     x       x
Ta bort         x     x       x
Markera allt    x     x       x
Kopiera         x     x       x
Klistra in      x     x       x
Ångra           x     x       x
Byta namn             x       x
```    

### Download 

- download [node.js](https://nodejs.org/en/download)
- Skriv in följande kommando i ett terminalfönster
```javascript
npm install -g coffee-script
```
- download [Sublime Text](https://www.sublimetext.com/3)

### Hämta Mallen

* Mallen innehåller filer du behöver i ett projekt
* index.html startar du med
* Filen sketch.coffee skriver du koden i
* Den transpileras till sketch.js
* sketch.js anropas av index.html
* p5-filer finns i libraries

* Hämta [mallen](https://github.com/ChristerNilsson/000-Mall)
* Du ska klicka på den gröna knappen och välja "Clone or download"
* Välj "Download ZIP"
* Dubbelklicka på den nerladdade filen
* Markera den enda katalogen och kopiera den
* Klistra in den i en katalog med t ex namnet p5Dojo
* Denna katalog ska du INTE arbeta i, enbart kopiera

### Start av nytt projekt 

* Starta createProject.bat
* Byt namn på den nya katalogen.

### Öppna ett visst projekt

* Gå in i projektkatalogen
* Start startProject.bat
  * Editorn startas
  * Bakgrundstranspilering startar
  * Browsern startas med index.html
* Stäng irrevelanta projekt i editorn
* Stäng alla öppna filer
* Öppna coffee/sketch.js

### Felsökning

* Transpileringsproblem
  * Kontrollera att transpilern är igång
    * Stämmer klockslaget?
  * Kontrollera om syntaxfel har inträffat
    * Dessa felmeddelanden är rödfärgade
    * De innehåller Filnamn, Rad, Kolumn samt Orsak
* Exekveringsproblem
  * Klicka på F12 i Chrome, alternativt ctrl-shift-i
    * Välj fliken Console
    * Avläs eventuellt felmeddelande
  * Lägg in print-satser i koden. De hamnar i Console
  * Det går även att [debugga](https://developers.google.com/web/tools/chrome-devtools/javascript) med brytpunkter och radvis exekevering i Chrome

### Viktiga kortkommandon

* Utforskaren
  * ctrl-a Markerar alla filer och kataloger
  * ctrl-x Tar bort markerade filer och kataloger
  * ctrl-c Kopierar markerade filer och kataloger
  * ctrl-v Klistrar in klippbordets filer och kataloger
* Sublime
  * ctrl-s Sparar aktuell fil
  * ctrl-a Markerar allt
  * ctrl-z Ångrar senaste kommandona
  * ctrl-x Tar bort det markerade
  * ctrl-c Kopierar det markerade
  * ctrl-v Klistrar in
* Chrome
  * ctrl-r Refresh
  * ctrl-shift-i Öppar felsökningsfönster

### Indenteringsproblem

* Indentering används istället för krullparenteser i Coffeescript
* Markera allt i textfilen med ctrl-a
* Kontrollera att alla indenteringar är konsekventa
  * Antingen ska de vara två punkter (mellanslag) 
  * eller ett streck (tab)
* Ställ gärna in Sublime så att tab sparas istf mellanslag
  * Olika personer vill ha olika indrag. Tab klarar det
  * Tab tar mindre plats i filen
  * En Tab går snabbare att ta bort än flera mellanslag
* I Sublime kan du även ställa in hur många mellanslag ett Tab ska motsvara.

### Sublime

* Install Package Better Coffeescript
	* Färgsyntax
	* Transpilering
	* Snippets
* Install Package Browser Refresh
  
### Fönsterhantering

* Lämpligt är att ha Sublime på vänstra sidan av skärmen.
  * ctrl-s sparar. Då startar transpileringen.
* Transpilering sker automatiskt då man byter flik
  * Transpilern piper vid syntaxfel.
* Chrome på högra sidan
  * Refresh sker automatiskt
  
### Undvik att använda musen

* Musen är långsam
* Tangentbordet är snabbt
* Lär dig att använda
  * Förflyttningstangenter
    * Piltangenter
    * Home - End
    * PgUp - PgDn
  * ctrl-s Spara
  * ctrl-a Markera allt
  * ctrl-c Kopiera
  * ctrl-x Ta bort
  * ctrl-v Klistra in 
  * ctrl-z Ångra
  * Del - Backspace
  * Escape
  * ctrl samt förflyttningstangenter, (flyttar ordvis)
  * shift samt förflyttningstangenter, (markerar)
  * ctrl-shift samt förflyttningstangenter, (markerar ordvis)

### Github och TortoiseGit

* På Github kan du lagra din kod och låta alla köra dina program.
* TortoiseGit hjälper dig att hantera Git.
* [Github for poets](https://www.youtube.com/watch?v=BCQHnlnPusY)
* [TortoiseGit](https://www.youtube.com/watch?v=mxDCimFA2dw)
