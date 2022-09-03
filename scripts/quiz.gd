extends Control

onready var picture = get_node('CenterContainer/Panel/Vbox/Vbox/Picture')
onready var opt1 = get_node('CenterContainer/Panel/Vbox/VBoxContainer/Option1')
onready var opt2 = get_node('CenterContainer/Panel/Vbox/VBoxContainer/Option2')
onready var opt3 = get_node('CenterContainer/Panel/Vbox/VBoxContainer/Option3')
onready var opt4 = get_node('CenterContainer/Panel/Vbox/VBoxContainer/Option4')
onready var timer_bar = get_node('CenterContainer/Panel/Vbox/VBoxContainer/ProgressBar')
var gato
var right_answer
var quiz_timer = Timer.new()


func _ready() -> void:
	picture.texture = gato.face
	_prepare_quiz()
	_create_timer()


func _process(_delta: float) -> void:
	timer_bar.value = quiz_timer.time_left


func _create_timer() -> void:
	quiz_timer.connect('timeout', self, '_finish_timer')
	quiz_timer.set_one_shot(true)
	add_child(quiz_timer)
	quiz_timer.start(10)


func _finish_timer() -> void:
	_finish_quiz()

func _prepare_quiz() -> void:
	if '&' in gato.id:
		opt1.text = 'Amaru & Ghali'
		opt2.text = 'Amaru & Chili'
		opt3.text = 'Chili & Naru'
		opt4.text = 'Chili & Ghali'
		if 'amaru' and 'ghali' in gato.id:
			right_answer = 'amaru&ghali'
		elif 'chili' and 'naru' in gato.id:
			right_answer = 'chili&naru'
	else:
		opt1.text = 'Amaru'
		opt2.text = 'Ghali'
		opt3.text = 'Chili'
		opt4.text = 'Naru'
		if 'amaru' in gato.id:
			right_answer = 'amaru'
		elif 'ghali' in gato.id:
			right_answer = 'ghali'
		elif 'chili' in gato.id:
			right_answer = 'chili'
		elif 'naru' in gato.id:
			right_answer = 'naru'


func _on_Option1_pressed() -> void:
	if opt1.text.to_lower().replace(' ', '') == right_answer:
		Globals.points += 1
		get_parent().pointsLabel.text = str(Globals.points)
	_finish_quiz()

func _on_Option2_pressed() -> void:
	if opt2.text.to_lower().replace(' ', '') == right_answer:
		Globals.points += 1
		get_parent().pointsLabel.text = str(Globals.points)
	_finish_quiz()


func _on_Option3_pressed() -> void:
	if opt3.text.to_lower().replace(' ', '') == right_answer:
		Globals.points += 1
		get_parent().pointsLabel.text = str(Globals.points)
	_finish_quiz()


func _on_Option4_pressed() -> void:
	if opt4.text.to_lower().replace(' ', '') == right_answer:
		Globals.points += 1
		get_parent().pointsLabel.text = str(Globals.points)
	_finish_quiz()


func _finish_quiz() -> void:
	if Globals.pairs == 0:
# warning-ignore:return_value_discarded
		get_tree().change_scene('res://scenes/game_over.tscn')
	get_tree().set_pause(false)
	queue_free()
