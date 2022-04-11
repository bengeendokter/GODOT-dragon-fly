extends Button

signal new_state

export(Texture) var on_icon
export(Texture) var off_icon
var pressed_state := false
# TODO fix state problems

func _ready():
	$CenterContainer/Icon.texture = on_icon

	
func _on_ToggleBtn_toggled(button_pressed := !pressed_state):
	pressed_state = button_pressed
	change_icon(button_pressed)


func change_icon(is_pressed : bool):
	var icon : Texture
	icon = off_icon if is_pressed else on_icon
	$CenterContainer/Icon.texture = icon
	emit_signal("new_state", is_pressed)
