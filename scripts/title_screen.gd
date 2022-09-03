extends Control





func _on_Jogar_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/game.tscn")


func _on_Instrucoes_pressed() -> void:
#	get_tree().set_pause(true)
	var instructions = preload('res://scenes/instructions.tscn').instance()
	add_child(instructions)


func _on_Sair_pressed() -> void:
	get_tree().quit()
