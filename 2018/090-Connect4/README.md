# Connect Four

https://en.wikipedia.org/wiki/Connect_Four

Spelet går ut på att först få fyra i rad.

* Horisontalt
* Vertikalt eller 
* Diagonalt

* Vid vinst dubblas datorns betänketid
* Vid förlust halveras datorns betänketid

AI:n är baserad på Monte Carlo. http://beej.us/blog/data/monte-carlo-method-game-ai/

* Inledningsvis spelas tio partier per möjliga sju drag. 
* Dragen slumpas hela vägen till slutet.
* Det drag som leder till flest vinster spelas.
* Om datorn förlorar dubblas till tjugo partier, osv.

AI:n i länken nedan är ännu smartare.
https://www.theofekfoundation.org/games/ConnectFour