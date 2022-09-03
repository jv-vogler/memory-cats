class_name Card
extends TextureButton

var id
var face
var back


func _init(card_name, card_back) -> void:
	id = card_name
	face = load('res://assets/cards/' + id + '.png')
	back = card_back
	set_normal_texture(back)


func _ready() -> void:
	set_h_size_flags(3)
	set_v_size_flags(3)
	set_expand(true)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)


func flip() -> void:
	if get_normal_texture() == back:
		set_normal_texture(face)
	else:
		set_normal_texture(back)
