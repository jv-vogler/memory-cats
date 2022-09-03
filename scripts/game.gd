extends Control

# setup

var card_back = preload('res://assets/cards/back.png')
var deck = Array()
var choice1
var choice2
var cards = ['amaru1', 'amaru2', 'chili1', 'chili2', 'chili3', 'ghali1', 'ghali2', 'naru1', 'naru2',
			'amaru&ghali1', 'amaru&ghali2', 'chili&naru1']

# timers
var matchTimer = Timer.new()
var flipTimer = Timer.new()
var secondsTimer = Timer.new()

# ui
onready var pointsLabel = get_node('Panel/HBoxContainer/SectionPoints/points')
onready var timerLabel = get_node('Panel/HBoxContainer/SectionTimer/seconds')
onready var pairsLabel = get_node('Panel/HBoxContainer/SectionPairs/pairs')


func _ready() -> void:
	fillDeck()
	dealDeck()
	setupTimers()
	setupHUD()


func setupTimers() -> void:
	flipTimer.connect('timeout', self, 'turnOverCards')
	flipTimer.set_one_shot(true)
	add_child(flipTimer)
	
	matchTimer.connect('timeout', self, 'matchCardsAndScore')
	matchTimer.set_one_shot(true)
	add_child(matchTimer)
	
	secondsTimer.connect('timeout', self, 'countSeconds')
	add_child(secondsTimer)
	secondsTimer.start()


func setupHUD() -> void:
	Globals.points = 0
	Globals.seconds = 0
	Globals.pairs = cards.size()
	pointsLabel.text = str(Globals.points)
	timerLabel.text = str(Globals.seconds)
	pairsLabel.text = str(Globals.pairs)


func countSeconds() -> void:
	Globals.seconds += 1
	timerLabel.text = str(Globals.seconds)


func fillDeck() -> void:
	for c in cards:
		var card1 = Card.new(c, card_back)
		var card2 = Card.new(c, card_back)
		card1.connect('pressed', self, 'chooseCard', [card1])
		card2.connect('pressed', self, 'chooseCard', [card2])
		deck.append(card1)
		deck.append(card2)


func dealDeck() -> void:
	randomize()
	deck.shuffle()
	var c = 0
	while c < deck.size():
		get_node('grid').add_child(deck[c])
		c += 1


func chooseCard(c) -> void:
	if !choice1:
		choice1 = c
		choice1.flip()
		choice1.set_disabled(true)
	elif !choice2:
		choice2 = c
		choice2.flip()
		choice2.set_disabled(true)
		checkCards()


func checkCards() -> void:
	if choice1.id == choice2.id:
		matchTimer.start(1)
	else:
		flipTimer.start(1)


func turnOverCards() -> void:
	choice1.flip()
	choice2.flip()
	choice1.set_disabled(false)
	choice2.set_disabled(false)
	choice1 = null
	choice2 = null


func matchCardsAndScore() -> void:
	choice1.set_modulate(Color(0.6, 0.6, 0.6, 0.5))
	choice2.set_modulate(Color(0.6, 0.6, 0.6, 0.5))
	Globals.pairs -= 1
	pairsLabel.text = str(Globals.pairs)
	start_quiz(choice1)
	choice1 = null
	choice2 = null
	

func start_quiz(cat) -> void:
	var quiz = preload('res://scenes/quiz.tscn').instance()
	quiz.gato = cat
	add_child(quiz)
	get_tree().set_pause(true)


func _on_Voltar_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/title_screen.tscn")
