extends Control


onready var acertos = $'%acertos'
onready var tempo = $'%tempo'


func _ready() -> void:
	if Globals.points == 12:
		acertos.text = 'Parabéns! Você acertou todos!'
	else:
		acertos.text = str(Globals.points) + ' acertos.'
	
	_calcular_tempo()


func _calcular_tempo() -> void:
	if Globals.seconds < 60:
		tempo.text = str(Globals.seconds) + ' segundos.'
	elif Globals.seconds/60 % 60 == 1:
		tempo.text = str(Globals.seconds/60 % 60) + ' minuto e ' + str(Globals.seconds % 60) + ' segundos.'
	else:
		tempo.text = str(Globals.seconds/60 % 60) + ' minutos e ' + str(Globals.seconds % 60) + ' segundos.'


func _on_MenuPrincipal_pressed() -> void:
	get_tree().change_scene("res://scenes/title_screen.tscn")


func _on_Sair_pressed() -> void:
	get_tree().quit()
