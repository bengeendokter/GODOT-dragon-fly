extends CanvasLayer

signal start_game
signal screen_button
signal pause
signal toggle_music


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


func hide_credits_btn():
	$Credits.hide()


func show_credits_btn():
	$Credits.show()


func hide_pause_btn():
	$Pause.hide()


func show_pause_btn():
	$Pause.show()


func show_music_btn():
	$Music.show()


func hide_music_btn():
	$Music.hide()


func hide_credits_window():
	$CreditsWindow.hide()


func _on_ScreenButton_pressed():
	 emit_signal("screen_button")

func on_pause_key_pressed():
	print("key pressed")
	$Pause._on_ToggleBtn_toggled()

func on_Pause_pressed(new_state):
	print("pause game: "+ str(new_state))
	if(new_state):
		print("grab")
		$Pause.grab_focus()
	else:
		print("release")
		$Pause.release_focus()
	emit_signal("pause")



func toggle_music(new_state):
	emit_signal("toggle_music", new_state)


func _on_Credits_pressed():
	$CreditsWindow.visible = !$CreditsWindow.visible
	if($CreditsWindow.visible):
		$CreditsWindow.grab_focus()
