https://github.com/fogleman/Minecraft

Installera Python 2.7
Installera pyglet
Installera pygame

Startar i riktning norrut, dvs 0 grader geografiskt
x-axeln pekar österut
y-axeln pekar upp i himlen
z-axeln pekar söderut
En ruta motsvarar 10 meter
Fem block längs z-axeln, två block längs x-axeln
Initialt kan man röra sig längs z-axeln mha Pitch.

Minecrafts koordinatsystem:

            North 0

  West 270      .        90 East (x-axel)

            South 180
            (z-axel)

Gamepaden har två stycken joysticks:
        thrust:                  pitch:
          -1                      -1
 yaw: -1   .  +1        roll: -1   .  +1
          +1                      +1

Thrust hanterar gasen, i vårt fall höjden
Yaw roterar farkosten, stillastående i luften.
Pitch innebär att farkosten rör sig framåt eller bakåt
Roll innebär att farkosten rör sig i sidled.

Kontrollerna hanteras annorlunda i ett flygplan.

Uppgifter:

#01# Skapa ett schackbräde, 40x40 boxar, slumpa GRASS och SAND, i xz-planet.
#02# Se till att man även kan röra sig längs med x-axeln, dvs i sidled, med hjälp av Roll på Gamepaden.
#03# Se till att man även kan röra sig längs med y-axeln, dvs i höjdled, med hjälp av Thrust på Gamepaden.
#04# Skriv ut texter som visar x,y,z,angle
                               pitch,roll,yaw,thrust
                               fps
#04.5# Använd rotate så att upplevelsen blir att man sitter i cockpit.
#05# Skapa tio stycken ballonger, bestående av en box vardera.
#06# Lägg in ljud då man träffar en ballong.
#06.5# Starta en klocka då man tar första ballongen. Stoppa klockan då man tagit sista ballongen.
#07# Slumpa ballongerna på samma ställe varje gång.
#08# Spela ett annat ljud då man tagit den tionde och sista ballongen.
#09# Låt ballongerna ha en grå skugga
#10# Ändra ballongernas färger till något annat

Googlingar:
stackoverflow python list
                     list append
                     math
                     random
                     random seed
                     dict
minecraft wiki

Länkar:
http://minecraft.gamepedia.com/Coordinates
https://pyglet.readthedocs.io/en/pyglet-1.2-maintenance/
http://www.pygame.org/docs/ref/joystick.html
https://www.opengl.org/
https://docs.python.org/2/library/winsound.html