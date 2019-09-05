assert = chai.assert.deepEqual

SIZE = 70

LETTERS = 'abcdefghijklmnopqrstuvwxyz'
words = "abruptly absurd abyss affix askew avenue awkward axiom azure bagpipes bandwagon banjo bayou beekeeper blitz blizzard boggle bookworm boxcar buckaroo buffalo buffoon buxom buzzing buzzwords caliph cobweb cockiness croquet crypt curacao cycle daiquiri dirndl disavow dizzying duplex dwarves embezzle equip espionage euouae exodus faking fishhook fixable fjord flapjack flopping fluffiness flyby foxglove frazzled frizzled fuchsia funny gabby galaxy galvanize gazebo giaour gizmo glowworm glyph gnarly gnostic gossip grogginess haphazard hyphen icebox injury ivory jackpot jaundice jawbreaker jaywalk jazziest jazzy jelly jigsaw jinx jiujitsu jockey jogging joking jovial joyful juicy jukebox jumbo kayak kazoo keyhole khaki kilobyte kiosk kitsch kiwifruit klutz knapsack larynx lengths lucky luxury lymph marquis matrix megahertz microwave mnemonic mystify naphtha nightclub nowadays numbskull nymph onyx ovary oxidize oxygen pajama peekaboo phlegm pixel pizazz pneumonia polka pshaw psyche puppy puzzling quartz queue quips quixotic quiz quizzes quorum razzmatazz rhubarb rhythm rickshaw schnapps scratch snazzy sphinx spritz squawk staff strength strengths stretch stronghold stymied subway swivel syndrome thriftless thumbscrew topaz transcript transgress transplant triphthong twelfth unknown unzip uptown vaporize vixen voodoo vortex walkway waltz wave wavy waxy wellspring wheezy whiskey whomever wimpy witchcraft wizard woozy wristwatch wyvern xylophone yachtsman yippee yoked youthful yummy zephyr zigzag zilch zipper zodiac zombie"
buttons = []
hm = {}

reset = ->
	hm.secret = words[Math.floor words.length * Math.random()]
	hm.green = hm.secret.split('').map => '-'
	hm.red = []

class Button 
	constructor : (@x,@y,@title,@click = ->) -> #@state = 0
	draw : ->
		fc 1
		rect @x,@y,0.96*SIZE,0.96*SIZE
		textSize 0.75*SIZE

		fc 0
		if @title in hm.red then fc 1,0,0
		if @title in hm.green then fc 0,1,0
		text @title,@x,@y
	inside : (mx,my) -> @x-0.48*SIZE < mx < @x+0.48*SIZE and @y-0.48*SIZE < my < @y+0.48*SIZE 

guess = (letter) ->
	green = false 
	for ltr,i in hm.secret 
		if ltr == letter
			hm.green[i] = letter
			green = true
	if not green then hm.red.push letter

setup = ->
	createCanvas windowWidth,windowHeight
	rectMode CENTER
	textAlign CENTER,CENTER

	words = words.split ' '

	for letter,i in LETTERS
		x = (0.5+i//13) * SIZE
		y = (0.5+i%%13) * SIZE
		do (letter) -> buttons.push new Button x,y,letter, => guess letter
	reset()
		
draw = ->
	bg 0
	for button in buttons	
		button.draw()
	for letter,i in hm.green
		fc 1,1,0
		text letter,200,SIZE*(i+1.5)

mousePressed = -> 
	for button in buttons
		if button.inside mouseX,mouseY then return button.click()
