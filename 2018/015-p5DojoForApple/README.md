# 015-p5DojoForApple

p5Dojo fungerar inte så bra på OSX och iOS.
Detta beror på trädet och listorna som bara visas med en rad.
Här försöker jag byta ut trädet mot trädet från 001-SushiRestaurant
och på köpet få ett ännu kompaktare träd som bara visar vägen mot roten

Exempel:

branch = []

* L1
* L2 # Klick öppnar ger nästa läge
* L3

branch = [1]

* L2 # Klick stänger och ger föregående läge
  * Dices # Klick öppnar och ger nästa läge
  * WhiteCircle

branch = [1,0]

* L2  # Klick stänger och ger första läget
  * Dices # Klick stänger och ger föregående läge
    * A
    * B
    * C
