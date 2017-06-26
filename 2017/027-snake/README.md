# Snake

## Javascript till Coffeescript

### Steg 1. Nödvändiga ändringar

- function bort. Byt { mot ->
- var bort. Global variabler initialiseras till null.
- {} bort
- byt "for i" mot "for i in range"
- byt === mot == 
- inför class och constructor om så behövs
- byt = mot : i metoderna
- testa!

### Steg 2. Lyxiga ändringar. Testa efter varje steg.

- Byt this. mot @ överallt
- Tag bort ; överallt
- Tag bort onödiga ()
- Byt vissa "for i" mot "for in"