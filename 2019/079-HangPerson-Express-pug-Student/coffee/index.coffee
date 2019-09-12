express = require 'express'
_ = require 'lodash'
print = console.log

LETTERS = 'abcdefghijklmnopqrstuvwxyz'

app = express()

words = "abruptly absurd abyss affix askew avenue awkward axiom azure bagpipes bandwagon banjo bayou beekeeper blitz blizzard boggle bookworm boxcar buckaroo buffalo buffoon buxom buzzing buzzwords caliph cobweb cockiness croquet crypt curacao cycle daiquiri dirndl disavow dizzying duplex dwarves embezzle equip espionage euouae exodus faking fishhook fixable fjord flapjack flopping fluffiness flyby foxglove frazzled frizzled fuchsia funny gabby galaxy galvanize gazebo giaour gizmo glowworm glyph gnarly gnostic gossip grogginess haphazard hyphen icebox injury ivory jackpot jaundice jawbreaker jaywalk jazziest jazzy jelly jigsaw jinx jiujitsu jockey jogging joking jovial joyful juicy jukebox jumbo kayak kazoo keyhole khaki kilobyte kiosk kitsch kiwifruit klutz knapsack larynx lengths lucky luxury lymph marquis matrix megahertz microwave mnemonic mystify naphtha nightclub nowadays numbskull nymph onyx ovary oxidize oxygen pajama peekaboo phlegm pixel pizazz pneumonia polka pshaw psyche puppy puzzling quartz queue quips quixotic quiz quizzes quorum razzmatazz rhubarb rhythm rickshaw schnapps scratch snazzy sphinx spritz squawk staff strength strengths stretch stronghold stymied subway swivel syndrome thriftless thumbscrew topaz transcript transgress transplant triphthong twelfth unknown unzip uptown vaporize vixen voodoo vortex walkway waltz wave wavy waxy wellspring wheezy whiskey whomever wimpy witchcraft wizard woozy wristwatch wyvern xylophone yachtsman yippee yoked youthful yummy zephyr zigzag zilch zipper zodiac zombie"
words = words.split ' '

game = {}

reset = -> 
	game.secret = _.sample(words)
	game.red = []
	game.green = game.secret.split('').map () => '_'
	
app.use express.urlencoded { extended: false } # true: [] {}
app.set 'view engine', 'pug'

app.get '/', (req, res) -> 
	reset()
	res.render 'index', { LETTERS, red:game.red, green:game.green }

app.post '/', (req, res) -> 
	print req.body
	if req.body.new
		reset()
	else
		letter = req.body.letter 
		for ltr,index in game.secret 
			if letter == ltr then game.green[index] = letter
		if letter not in game.secret && letter not in game.red then game.red.push letter
	res.render 'index', { LETTERS, red:game.red, green:game.green }

PORT = process.env.PORT || 3000
app.listen PORT, -> console.log "Server started on port #{PORT}"


# Form            no Form
# urlencoded
# req.body.letter req.params.letter
# localhost:3000  localhost:3000/letter/a