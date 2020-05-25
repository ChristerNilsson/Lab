# gpsKarta

## Digital orienteering

* [Orienteering](https://en.wikipedia.org/wiki/Orienteering)
* [Naturpasset](https://www.facebook.com/Naturpasset.Nackareservatet)
* [Compass](https://en.wikipedia.org/wiki/Compass)

Buy the paper map [here](http://www.skogsluffarna.se/Arrangemang/Naturpasset)

## Functionality

You see the map, controls and position all the time.
The size of the controls are roughly 100 meter.

* Center (centers your position)
* In (Zooms in)
* Out (Zooms out)
* Take (marks a target with littera)
	* ABCDE
	* FGHIJ
	* KLMNO
	* PQRST
	* UVWXYZ
* More	
	* Init (initializes speaker)
	* Mail (sends data in a mail)
	* Setup
		* Coins. Toggle Meter indication sound
		* Distances. Toggle Distance voice
		* Sector
			* Selects size of sector. 10-90 degrees.
	* Clear
	* Info
* Save (stores one or many current positions with names hh:mm)
* Aim (sets target to crosshair position)

Accuracy : Approx ten meters

Your position is shown with five black circles. The smallest circle is the most recent.

Stop screen rotation on Android like this:
* Settings
* Display
* When device is rotated: Stay in portrait view

Allow the app to work even if your phone is turned off
* Settings
* Apps & notifications
* Special app access
* Unrestricted data access
* Chrome On

Reference points are stored under the names A,B and C. They are used for mapping between WGS and bitmap coordinates.

## How To

* Connect your headphones.
* Click on More... | Init
* Save (saves starting position, e.g. a bike or a car)
* Click on Target control
* If you have a compass
	* When the Bearing changes, turn your analog Compass house.
	* "Bearing Two Seven" => 270 degrees = West
	* Start walking in that direction.
* Distances are read now and then as "One Hundred" (meter)
* Every meter closer to the target can be heard as a coin drop.
* Every meter lost to the target can be heard as a small explosion.
* When distance is less than twenty meter, no Bearing is given. The Bearing is changing very often, when you are close to the Target.
* Click on Take... when you have found your target
* Click on the starting position to find your bike or car.

## Methods

* 1. Listen to bearings and use a compass. Most efficient method.
* 2. Listen to distance indicating sounds (coins and explosions)
* 3. Look at the map on the screen and the five circles.

## Pan Speed

As my Android has a very slow update rate (4Hz), I had to invent a new way of panning.
I'm using adjustable speed. Starting in the middle gives a factor of 0.2, starting in a corner, 2.0
This feature can be disabled with PanSpeed.

## Future Development

* Låt localStorage lagras i molnet vid wifikontakt (typ Google Photo)
* Då man går in på en annan enhet kopieras localStorage ner till den enheten (typ Google Photo)
* Fördelar: man kommer åt data insamlade på en annan enhet utan att behöva någon server.
* localStorage lagras per domän, per inloggad
* Konflikt om två olika enheter ändrar localStorage samtidigt.
* Alternativ: lagra i Google Sheets?

* Har ej lyckats ställa in rätt röst på iOS. getVoices? Allt annat tycks fungera. Röst 0 är obegriplig. 
  * Borde vara 10 på iOS, 5 på Android.