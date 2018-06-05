# 043-gpsKarta

Just nu innehåller den ett foto av Naturpasset 2018

Funktionalitet:

Man ser karta, kontroller samt egen position hela tiden.

Left,Right,Up,Down : Flyttar fönstret
-, +: Zoom
C: Centrerar aktuell position

Praktisk noggrannhet tycks ligga kring 15-20 meter.

Transformationer mellan wgs84 och bitmappskoordinater sker via åtta anrop till map. Borde kunna förbättras. 
GlobalMercator kan möjligen användas för denna projektion.

ToDo:
	Begränsa zoom
	Drag och pinch istf knappar
	Knapp för att spara position. Den visas med egen färg.
	Track borde spara bitmappskoordinater istf LatLon.