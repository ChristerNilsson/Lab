# 001-SushiRestaurant

Målsättning

Skapa en statisk websida som kan användas för beställning av hämtmat via email.
Ingen app behöver installeras.
Fungerar i första hand på telefoner och tablets.
Även laptops kan fås att fungera om man konfigurerar mailto:

Kunden:

* Kunden scannar QR-koden
* Kunden klickar på de maträtter som önskas.
* Antal minskas då man klickar på det.
* Klicka på Skicka då beställningen är klar.
* Klicka på totalpriset för att rensa beställningen.

Shopen:

* Använd två enheter för mottagandet.
  * Mobil för ljudsignal.
  * laptop/tablet för hantering av beställningar.
    * Oläst. Syns med fetstil. Ej påbörjat
    * Läst. Normal stil. Påbörjat.
    * Levererat. Borttaget eller arkiverat. 
  * Ljudsignal hörs ej om mailhanteraren är aktiv.

Kundernas mailto: måste vara konfigurerad i browsern:
* https://developers.google.com/web/updates/2012/02/Getting-Gmail-to-handle-all-mailto-links-with-registerProtocolHandler

* Gå till tidigare version av Gmail.
  * Klicka på Gmail i vänstra kolumnen
  * ctrl-shift-j (cmd-opt-j på Mac)
  * Klistra in
    * navigator.registerProtocolHandler("mailto","https://mail.google.com/mail/?extsrc=mailto&url=%s","Gmail");
  * Klicka på Skicka
  * Nu ska du komma till Gmails sändsida.
