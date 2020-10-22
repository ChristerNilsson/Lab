# Generalens Tidsfördriv

[Prova!](https://christernilsson.github.io/Lab/2018/056-GeneralensTidsf%C3%B6rdriv/index.html)

* I've heard that a number of generals are playing this solitaire in peace time, to keep their brains alert.
* The goal of this patience is to build upwards om the aces. Put twos on the aces all the way upto kings.
* On the upper eight sequences it's ok to build upwards and downwards.
* You can place any card on an empty slot.
* The lower eight cards are not allowed to build on.
* Always follow suit. Heart on heart and so on.

# The Menu
Click on the green background to show the menu.

* __Help__ This page is shown
* __Undo__ Undoes the latest move. It is indicated with __From__ and __To__
* __Hint__ Shows a hint. See red/green indicator
  * You may also try a Restart before clicking Hint.
* __Cycle Move__ Sometimes the cards are placed in wrong place. With this command you may choose an alternative place.
* __More...__
  * __Restart__ Resets the current patience.
  * __Total Restart__ Start from the beginning level 0.
  * __Link__ Saves a link for this patience on the clipboard. Send to a friend!
* __Next__ Go to next level.
* Click on the middle circle to close a menu.

# Levels 
_Classic_ All the sequences have the same length.
Higher levels may be reached by using as few moves as possible and without using any hints.

* 0 = Classic Ace to 3. _Easy_ (Cards=8)
* 1 = Ace to 4
* 2 = Ace to 5
* 3 = Classic Ace to 5
* 4 = Ace to 6
* 5 = Ace to 7
* 6 = Classic Ace to 7
* 7 = Ace to 8
* 8 = Ace to 9
* 9 = Classic Ace to 9
* 10 = Ace to Ten
* 11 = Ace to Jack
* 12 = Classic Ace to Queen
* 13 = Ace to Queen
* 14 = Ace to King
* 15 = Classic Ace to King. _Hard_ (Cards=48)

# Hints

* If you click on __Hint__ You will see a move to continue against the solution.
* Initially an __Hint__ may show one or more __Undo__ indicated with red color
* You must click on these hints
* Using __Hint__ makes it impossible to reach next level

# Indicators

* __From__ Shows where the move starts
* __To__ Shows where the move ends
* Red is a backward Hint. Click __Undo__
* Green is a forward hint. Click on the card
  * If the card goes to the wrong place, use __Cycle Move__
* Yellow shows which __Undo__ was done. No need to click

# Solvability

The created patiences are always solvable. In other words, it is always to early to give up.

## Bonus
If you are smarte than the computer, these moves are save to a higher level.

# Literature

_Att lägga patiens_. Swedish book published 1957.
Level 15 with minor changes.

# The picture

* We are seven moves into solving a level 11 patience.
* The computer has already solved it. It is possible to solve in 53 moves
  * Sometimes you will find a shorter solution
* The latest move moved Nine of Spades from Two of Clubs to Eight of Spades
  * This can be undone with __Undo__
  * If you prefer moving the Nine to Ten of Spades, use __Cycle Move__
* Level 11 has 44 cards
  * Four of these have been placed on Ace of Hearts
* Normally one move connects two cards in a sequence
* The number 9 (53-44) tells how many moves that does not connect two cards
  * This can be done by moving a card or a sequence to an empty slot
* The player has 5 (47-42) saved bonus moves
  * The player can use maximum 58 (53+5) moves to reach the next level
* Total used time is 131 seconds

![](bild0.jpg "GT")
