extends Control

func pause() -> bool:
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	return new_pause_state
