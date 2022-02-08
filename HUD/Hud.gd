extends CanvasLayer

signal start_game


func set_score(score : int):
	$Score.text = str(score)


func _on_Button_pressed():
	emit_signal("start_game")


func show_game_over():
	$Button.show()


func hide_game_over():
	$Button.hide()


func grab_focus():
	$Button.grab_focus()
